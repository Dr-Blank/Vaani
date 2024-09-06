import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:shelfsdk/audiobookshelf_api.dart';
import 'package:vaani/api/api_provider.dart';
import 'package:vaani/api/authenticated_user_provider.dart';
import 'package:vaani/api/server_provider.dart';
import 'package:vaani/hacks/fix_autofill_losing_focus.dart';
import 'package:vaani/models/error_response.dart';
import 'package:vaani/router/router.dart';
import 'package:vaani/settings/api_settings_provider.dart';
import 'package:vaani/settings/models/models.dart' as model;

class UserLoginWidget extends HookConsumerWidget {
  UserLoginWidget({
    super.key,
    required this.server,
  });

  final Uri server;
  final serverStatusError = ErrorResponse();

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
          openidAvailable:
              value.authMethods?.contains(AuthMethod.openid) ?? false,
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
    this.openidAvailable = false,
    this.onPressed,
  });

  final Uri server;
  final bool localAvailable;
  final bool openidAvailable;
  final void Function()? onPressed;

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
                    if (openidAvailable)
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
                  AuthMethodChoice.local => UserLoginWithPassword(
                      server: server,
                      addServer: addServer,
                    ),
                  AuthMethodChoice.openid => _UserLoginWithOpenID(
                      server: server,
                      addServer: addServer,
                    ),
                  AuthMethodChoice.authToken => UserLoginWithToken(
                      server: server,
                      addServer: addServer,
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

class _UserLoginWithOpenID extends HookConsumerWidget {
  const _UserLoginWithOpenID({
    super.key,
    required this.server,
    required this.addServer,
  });

  final Uri server;
  final model.AudiobookShelfServer Function() addServer;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: implement build
    return const Text('OpenID');
  }
}

class UserLoginWithToken extends HookConsumerWidget {
  UserLoginWithToken({
    super.key,
    required this.server,
    required this.addServer,
  });

  final Uri server;
  final model.AudiobookShelfServer Function() addServer;
  final serverErrorResponse = ErrorResponse();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authTokensController = useTextEditingController();

    final api = ref.watch(audiobookshelfApiProvider(server));
    Future<void> loginAndSave() async {
      api.token = authTokensController.text;
      model.AuthenticatedUser? authenticatedUser;
      LoginResponse? success;
      try {
        success = await api.misc.authorize(
          responseErrorHandler: serverErrorResponse.storeError,
        );
        if (success == null) {
          throw StateError('No response from server');
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Login failed. Got response: ${serverErrorResponse.response.body} (${serverErrorResponse.response.statusCode})',
            ),
            action: SnackBarAction(
              label: 'See Error',
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Error'),
                    content: Text(e.toString()),
                  ),
                );
              },
            ),
          ),
        );
        return;
      }
      authenticatedUser = model.AuthenticatedUser(
        server: addServer(),
        id: success.user.id,
        username: success.user.username,
        authToken: api.token!,
      );

      ref
          .read(authenticatedUserProvider.notifier)
          .addUser(authenticatedUser, setActive: true);

      context.goNamed(Routes.home.name);
    }

    return Form(
      child: Column(
        children: [
          TextFormField(
            controller: authTokensController,
            autofocus: true,
            textInputAction: TextInputAction.done,
            maxLines: 10,
            minLines: 1,
            decoration: InputDecoration(
              labelText: 'API Token',
              labelStyle: TextStyle(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
              ),
              border: const OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter an API token';
              }
              return null;
            },
            onFieldSubmitted: (_) async {
              await loginAndSave();
            },
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: loginAndSave,
            child: const Text('Login'),
          ),
        ],
      ),
    );
  }
}

// class _UserLoginWithToken  extends HookConsumerWidget {

class UserLoginWithPassword extends HookConsumerWidget {
  UserLoginWithPassword({
    super.key,
    required this.server,
    required this.addServer,
  });

  final Uri server;
  final model.AudiobookShelfServer Function() addServer;
  final serverErrorResponse = ErrorResponse();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usernameController = useTextEditingController();
    final passwordController = useTextEditingController();
    final isPasswordVisibleAnimationController = useAnimationController(
      duration: const Duration(milliseconds: 500),
    );

    var isPasswordVisible = useState(false);
    final api = ref.watch(audiobookshelfApiProvider(server));

    // forward animation when the password visibility changes
    useEffect(
      () {
        if (isPasswordVisible.value) {
          isPasswordVisibleAnimationController.forward();
        } else {
          isPasswordVisibleAnimationController.reverse();
        }
        return null;
      },
      [isPasswordVisible.value],
    );

    /// Login to the server and save the user
    Future<void> loginAndSave() async {
      final username = usernameController.text;
      final password = passwordController.text;

      LoginResponse? success;
      try {
        success = await api.login(
          username: username,
          password: password,
          responseErrorHandler: serverErrorResponse.storeError,
        );
        if (success == null) {
          throw StateError('No response from server');
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Login failed. Got response: ${serverErrorResponse.response.body} (${serverErrorResponse.response.statusCode})',
            ),
            action: SnackBarAction(
              label: 'See Error',
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Error'),
                    content: Text(e.toString()),
                  ),
                );
              },
            ),
          ),
        );

        return;
      }
      // save the server
      final authenticatedUser = model.AuthenticatedUser(
        server: addServer(),
        id: success.user.id,
        password: password,
        username: username,
        authToken: api.token!,
      );
      // add the user to the list of users
      ref
          .read(authenticatedUserProvider.notifier)
          .addUser(authenticatedUser, setActive: true);

      // redirect to the library page
      GoRouter.of(context).goNamed(Routes.home.name);
    }

    return Center(
      child: InactiveFocusScopeObserver(
        child: AutofillGroup(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: usernameController,
                  autofocus: true,
                  autofillHints: const [AutofillHints.username],
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    labelStyle: TextStyle(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.8),
                    ),
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: passwordController,
                  autofillHints: const [AutofillHints.password],
                  textInputAction: TextInputAction.done,
                  obscureText: !isPasswordVisible.value,
                  onFieldSubmitted: (_) {
                    loginAndSave();
                  },
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.8),
                    ),
                    border: const OutlineInputBorder(),
                    suffixIcon: ColorFiltered(
                      colorFilter: ColorFilter.mode(
                        Theme.of(context).colorScheme.primary.withOpacity(0.8),
                        BlendMode.srcIn,
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(50),
                        onTap: () {
                          isPasswordVisible.value = !isPasswordVisible.value;
                        },
                        child: Container(
                          margin: const EdgeInsets.only(left: 8, right: 8),
                          child: Lottie.asset(
                            'assets/animations/Animation - 1714930099660.json',
                            controller: isPasswordVisibleAnimationController,
                          ),
                        ),
                      ),
                    ),
                    suffixIconConstraints: const BoxConstraints(
                      maxHeight: 45,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: loginAndSave,
                  child: const Text('Login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
