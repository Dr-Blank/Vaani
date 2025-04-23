import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shelfsdk/audiobookshelf_api.dart';
import 'package:vaani/api/api_provider.dart';
import 'package:vaani/features/onboarding/providers/oauth_provider.dart';
import 'package:vaani/features/onboarding/view/user_login_with_password.dart';
import 'package:vaani/main.dart';
import 'package:vaani/models/error_response.dart';
import 'package:vaani/router/router.dart';
import 'package:vaani/settings/constants.dart';
import 'package:vaani/settings/models/models.dart' as model;
import 'package:vaani/shared/extensions/obfuscation.dart';
import 'package:vaani/shared/utils.dart';

class UserLoginWithOpenID extends HookConsumerWidget {
  UserLoginWithOpenID({
    super.key,
    required this.server,
    required this.addServer,
    this.openIDButtonText,
    this.onSuccess,
  });

  final Uri server;
  final model.AudiobookShelfServer Function() addServer;
  final String? openIDButtonText;
  final responseErrorHandler = ErrorResponseHandler(name: 'OpenID');
  final Function(model.AuthenticatedUser)? onSuccess;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final serverStatus = ref.watch(serverStatusProvider(server));
    void openIDLoginFlow() async {
      appLogger.fine('Clicked Login with OpenID');

      final api = ref.read(audiobookshelfApiProvider(server));
      final (verifier, challenge) = generateVerifierAndChallenge();

      appLogger.fine('Generated verifier: $verifier\nchallenge: $challenge');
      final appRedirectUri =
          '${AppMetadata.appScheme}://${Routes.openIDCallback.fullPath.substring(1)}';
      final (openIDLoginEndpoint, authCookie) = await api.server.oauth2Request(
        clientId: AppMetadata.appName,
        codeChallenge: challenge,
        // redirectUri: Uri(
        //   scheme: AppMetadata.appScheme,
        //   host: Routes.openIDCallback.path.substring(1),
        // ).toString(),
        redirectUri: appRedirectUri,
        responseErrorHandler: responseErrorHandler.storeError,
      );

      if (openIDLoginEndpoint == null) {
        if (responseErrorHandler.response.statusCode == 400 &&
            responseErrorHandler.response.body
                .toLowerCase()
                .contains(RegExp(r'invalid.*redirect.*uri'))) {
          // show error
          handleServerError(
            context,
            responseErrorHandler,
            title: 'Failed to get OpenID login endpoint\n',
            body:
                'Please check that the redirect URI: "$appRedirectUri" is registered with the server.',
            outLink: server.replace(path: '${Routes.settings.fullPath}/auth'),
            outLinkText: 'Server settings',
          );
          return;
        }

        // show error
        handleServerError(
          context,
          responseErrorHandler,
          title: 'Failed to get OpenID login endpoint',
        );
        return;
      }

      // extract the state parameter
      final oauthState = openIDLoginEndpoint.queryParameters['state'];

      if (oauthState == null) {
        handleServerError(
          context,
          responseErrorHandler,
          title: 'Failed to get OpenID login endpoint',
          body: 'No state parameter found in the response',
        );
        return;
      }

      appLogger.fine(
        'Got OpenID login endpoint: ${openIDLoginEndpoint.obfuscate()}',
      );

      // add the flow to the provider
      ref.read(oauthFlowsProvider.notifier).addFlow(
            oauthState,
            verifier: verifier,
            serverUri: server,
            cookie: Cookie.fromSetCookieValue(authCookie!),
          );

      await handleLaunchUrl(
        openIDLoginEndpoint,
      );
    }

    return Column(
      children: [
        ElevatedButton(
          onPressed: openIDLoginFlow,
          child: Text(openIDButtonText ?? 'Login with OpenID'),
        ),
      ],
    );
  }
}
