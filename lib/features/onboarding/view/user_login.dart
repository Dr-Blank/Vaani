import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shelfsdk/audiobookshelf_api.dart';
import 'package:vaani/api/api_provider.dart';
import 'package:vaani/api/server_provider.dart';
import 'package:vaani/features/onboarding/view/user_login_with_open_id.dart';
import 'package:vaani/features/onboarding/view/user_login_with_password.dart';
import 'package:vaani/features/onboarding/view/user_login_with_token.dart';
import 'package:vaani/hacks/fix_autofill_losing_focus.dart';
import 'package:vaani/models/error_response.dart';
import 'package:vaani/settings/api_settings_provider.dart';
import 'package:vaani/settings/models/models.dart' as model;

class UserLoginWidget extends HookConsumerWidget {
  UserLoginWidget({
    super.key,
    required this.server,
  });

  final Uri server;
  final serverStatusError = ErrorResponseHandler();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final serverStatus =
        ref.watch(serverStatusProvider(server, serverStatusError.storeError));

    final api = ref.watch(audiobookshelfApiProvider(server));

    return serverStatus.when(
      data: (value) {
        if (value == null) {
          // check the error message
          return Text(serverStatusError.response.body);
        }
        // check available authentication methods and return the correct widget
        return UserLoginMultipleAuth(
          server: server,
          localAvailable:
              value.authMethods?.contains(AuthMethod.local) ?? false,
          openIDAvailable:
              value.authMethods?.contains(AuthMethod.openid) ?? false,
          openIDButtonText: value.authFormData?.authOpenIDButtonText,
        );
      },
      loading: () {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
      error: (error, _) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Server is not reachable: $error'),
              ElevatedButton(
                onPressed: () {
                  ref.invalidate(
                    serverStatusProvider(
                      server,
                      serverStatusError.storeError,
                    ),
                  );
                },
                child: const Text('Try again'),
              ),
            ],
          ),
        );
      },
    );
  }
}

enum AuthMethodChoice {
  local,
  openid,
  authToken,
}

class UserLoginMultipleAuth extends HookConsumerWidget {
  const UserLoginMultipleAuth({
    super.key,
    required this.server,
    this.localAvailable = false,
    this.openIDAvailable = false,
    this.onPressed,
    this.openIDButtonText,
  });

  final Uri server;
  final bool localAvailable;
  final bool openIDAvailable;
  final void Function()? onPressed;
  final String? openIDButtonText;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // will show choice chips for the available authentication methods
    // authToken method is always available
    final methodChoice = useState<AuthMethodChoice>(
      localAvailable ? AuthMethodChoice.local : AuthMethodChoice.authToken,
    );

    final apiSettings = ref.watch(apiSettingsProvider);

    model.AudiobookShelfServer addServer() {
      var newServer = model.AudiobookShelfServer(
        serverUrl: server,
      );
      try {
        // add the server to the list of servers
        ref.read(audiobookShelfServerProvider.notifier).addServer(
              newServer,
            );
      } on ServerAlreadyExistsException catch (e) {
        newServer = e.server;
      } finally {
        ref.read(apiSettingsProvider.notifier).updateState(
              apiSettings.copyWith(
                activeServer: newServer,
              ),
            );
      }
      return newServer;
    }

    return Center(
      child: InactiveFocusScopeObserver(
        child: AutofillGroup(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Wrap(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 10,
                  runAlignment: WrapAlignment.center,
                  runSpacing: 10,
                  alignment: WrapAlignment.center,
                  children: [
                    // a small label to show the user what to do
                    if (localAvailable)
                      ChoiceChip(
                        label: const Text('Local'),
                        selected: methodChoice.value == AuthMethodChoice.local,
                        onSelected: (selected) {
                          if (selected) {
                            methodChoice.value = AuthMethodChoice.local;
                          }
                        },
                      ),
                    if (openIDAvailable)
                      ChoiceChip(
                        label: const Text('OpenID'),
                        selected: methodChoice.value == AuthMethodChoice.openid,
                        onSelected: (selected) {
                          if (selected) {
                            methodChoice.value = AuthMethodChoice.openid;
                          }
                        },
                      ),
                    ChoiceChip(
                      label: const Text('Token'),
                      selected:
                          methodChoice.value == AuthMethodChoice.authToken,
                      onSelected: (selected) {
                        if (selected) {
                          methodChoice.value = AuthMethodChoice.authToken;
                        }
                      },
                    ),
                  ],
                ),
                const SizedBox.square(
                  dimension: 8,
                ),
                switch (methodChoice.value) {
                  AuthMethodChoice.authToken => UserLoginWithToken(
                      server: server,
                      addServer: addServer,
                    ),
                  AuthMethodChoice.local => UserLoginWithPassword(
                      server: server,
                      addServer: addServer,
                    ),
                  AuthMethodChoice.openid => UserLoginWithOpenID(
                      server: server,
                      addServer: addServer,
                      openIDButtonText: openIDButtonText,
                    ),
                },
              ],
            ),
          ),
        ),
      ),
    );
  }
}
