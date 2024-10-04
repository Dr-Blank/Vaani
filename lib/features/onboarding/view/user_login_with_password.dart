import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:shelfsdk/audiobookshelf_api.dart';
import 'package:vaani/api/api_provider.dart';
import 'package:vaani/api/authenticated_user_provider.dart';
import 'package:vaani/hacks/fix_autofill_losing_focus.dart';
import 'package:vaani/models/error_response.dart';
import 'package:vaani/router/router.dart';
import 'package:vaani/settings/models/models.dart' as model;
import 'package:vaani/shared/utils.dart';

class UserLoginWithPassword extends HookConsumerWidget {
  UserLoginWithPassword({
    super.key,
    required this.server,
    required this.addServer,
  });

  final Uri server;
  final model.AudiobookShelfServer Function() addServer;
  final serverErrorResponse = ErrorResponseHandler();

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
        handleServerError(
          context,
          serverErrorResponse,
          title: 'Login failed',
          e: e,
        );

        return;
      }
      // save the server
      final authenticatedUser = model.AuthenticatedUser(
        server: addServer(),
        id: success.user.id,
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

Future<void> handleServerError(
  BuildContext context,
  ErrorResponseHandler responseErrorHandler, {
  String title = 'Something went wrong',
  String? body,
  Uri? outLink,
  String? outLinkText,
  Object? e,
}) async {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        '$title\n'
        'Got response: ${responseErrorHandler.response.body} (${responseErrorHandler.response.statusCode})',
      ),
      action: SnackBarAction(
        label: 'See Error',
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Error'),
              content: SelectableText('$title\n'
                  'Got response: ${responseErrorHandler.response.body} (${responseErrorHandler.response.statusCode})\n'
                  'Stacktrace: $e\n\n'
                  '$body\n\n'),
              actions: [
                if (outLink != null)
                  TextButton(
                    onPressed: () async {
                      await handleLaunchUrl(outLink);
                    },
                    child: Text(outLinkText ?? 'Open link'),
                  ),
                TextButton(
                  onPressed: () {
                    // open an issue on the github page
                    handleLaunchUrl(
                      Uri.parse(
                        'https://github.com/Dr-Blank/Vaani/issues',
                      ),
                    );
                  },
                  child: const Text('Open issue'),
                ),
              ],
            ),
          );
        },
      ),
    ),
  );
}
