import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shelfsdk/audiobookshelf_api.dart' show AuthMethod;
import 'package:vaani/api/api_provider.dart' show serverStatusProvider;
import 'package:vaani/api/server_provider.dart'
    show ServerAlreadyExistsException, audiobookShelfServerProvider;
import 'package:vaani/features/onboarding/view/onboarding_single_page.dart'
    show fadeSlideTransitionBuilder;
import 'package:vaani/features/onboarding/view/user_login_with_open_id.dart'
    show UserLoginWithOpenID;
import 'package:vaani/features/onboarding/view/user_login_with_password.dart'
    show UserLoginWithPassword;
import 'package:vaani/features/onboarding/view/user_login_with_token.dart'
    show UserLoginWithToken;
import 'package:vaani/hacks/fix_autofill_losing_focus.dart'
    show InactiveFocusScopeObserver;
import 'package:vaani/models/error_response.dart' show ErrorResponseHandler;
import 'package:vaani/settings/api_settings_provider.dart'
    show apiSettingsProvider;
import 'package:vaani/settings/models/models.dart' as model;

class UserLoginWidget extends HookConsumerWidget {
  const UserLoginWidget({
    super.key,
    required this.server,
    this.onSuccess,
  });

  final Uri server;
  final Function(model.AuthenticatedUser)? onSuccess;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final serverStatusError = useMemoized(() => ErrorResponseHandler(), []);
    final serverStatus =
        ref.watch(serverStatusProvider(server, serverStatusError.storeError));

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
          onSuccess: onSuccess,
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
    this.onSuccess,
  });

  final Uri server;
  final bool localAvailable;
  final bool openIDAvailable;
  final void Function()? onPressed;
  final String? openIDButtonText;
  final Function(model.AuthenticatedUser)? onSuccess;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // will show choice chips for the available authentication methods
    // authToken method is always available
    final methodChoice = useState<AuthMethodChoice>(
      localAvailable ? AuthMethodChoice.local : AuthMethodChoice.authToken,
    );

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
              ref.read(apiSettingsProvider).copyWith(
                    activeServer: newServer,
                  ),
            );
      }
      return newServer;
    }

    return Center(
      child: InactiveFocusScopeObserver(
        child: AutofillGroup(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Wrap(
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
                  ].animate(interval: 100.ms).fadeIn(
                        duration: 150.ms,
                        curve: Curves.easeIn,
                      ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AnimatedSwitcher(
                  duration: 200.ms,
                  transitionBuilder: fadeSlideTransitionBuilder,
                  child: switch (methodChoice.value) {
                    AuthMethodChoice.authToken => UserLoginWithToken(
                        server: server,
                        addServer: addServer,
                        onSuccess: onSuccess,
                      ),
                    AuthMethodChoice.local => UserLoginWithPassword(
                        server: server,
                        addServer: addServer,
                        onSuccess: onSuccess,
                      ),
                    AuthMethodChoice.openid => UserLoginWithOpenID(
                        server: server,
                        addServer: addServer,
                        openIDButtonText: openIDButtonText,
                        onSuccess: onSuccess,
                      ),
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
