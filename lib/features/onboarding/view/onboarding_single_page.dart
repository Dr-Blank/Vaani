import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whispering_pages/api/api_provider.dart';
import 'package:whispering_pages/api/authenticated_user_provider.dart';
import 'package:whispering_pages/api/server_provider.dart';
import 'package:whispering_pages/features/onboarding/view/user_login.dart';
import 'package:whispering_pages/router/router.dart';
import 'package:whispering_pages/settings/api_settings_provider.dart';
import 'package:whispering_pages/settings/models/models.dart' as model;
import 'package:whispering_pages/shared/widgets/add_new_server.dart';

class OnboardingSinglePage extends HookConsumerWidget {
  const OnboardingSinglePage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final apiSettings = ref.watch(apiSettingsProvider);
    final serverUriController = useTextEditingController(
      text: apiSettings.activeServer?.serverUrl.toString() ?? '',
    );
    final api = ref
        .watch(audiobookshelfApiProvider(Uri.https(serverUriController.text)));

    final isUserLoginAvailable = useState(apiSettings.activeServer != null);

    final usernameController = useTextEditingController();
    final passwordController = useTextEditingController();

    void addServer() {
      var newServer = serverUriController.text.isEmpty
          ? null
          : model.AudiobookShelfServer(
              serverUrl: Uri.parse(serverUriController.text),
            );
      try {
        // add the server to the list of servers
        if (newServer != null) {
          ref.read(audiobookShelfServerProvider.notifier).addServer(
                newServer,
              );
        }
        // else remove the server from the list of servers
        else if (apiSettings.activeServer != null) {
          ref
              .read(audiobookShelfServerProvider.notifier)
              .removeServer(apiSettings.activeServer!);
        }
      } on ServerAlreadyExistsException catch (e) {
        newServer = e.server;
      } finally {
        ref.read(apiSettingsProvider.notifier).updateState(
              apiSettings.copyWith(
                activeServer: newServer,
              ),
            );
      }
    }

    /// Login to the server and save the user
    Future<void> loginAndSave() async {
      final username = usernameController.text;
      final password = passwordController.text;
      final success = await api.login(username: username, password: password);
      if (success != null) {
        // save the server
        addServer();
        var authenticatedUser = model.AuthenticatedUser(
          server: model.AudiobookShelfServer(
            serverUrl: Uri.parse(serverUriController.text),
          ),
          id: success.user.id,
          password: password,
          username: username,
          authToken: api.token!,
        );
        // add the user to the list of users
        ref.read(authenticatedUserProvider.notifier).addUser(authenticatedUser);

        // set the active user
        ref.read(apiSettingsProvider.notifier).updateState(
              apiSettings.copyWith(
                activeUser: authenticatedUser,
              ),
            );

        // redirect to the library page
        GoRouter.of(context).goNamed(Routes.home.name);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login failed. Please check your credentials.'),
          ),
        );
        // give focus back to the username field
      }
    }

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Welcome to Vaani',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          const SizedBox.square(
            dimension: 16.0,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Please enter the URL of your AudiobookShelf Server',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: AddNewServer(
              controller: serverUriController,
              allowEmpty: true,
              onPressed: () {
                isUserLoginAvailable.value =
                    serverUriController.text.isNotEmpty;
              },
            ),
          ),
          AnimatedSwitcher(
            duration: 500.ms,
            transitionBuilder: (child, animation) {
              return FadeTransition(
                opacity: animation,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 0.3),
                    end: const Offset(0, 0),
                  ).animate(animation),
                  child: child,
                ),
              );
            },
            child: isUserLoginAvailable.value
                ? UserLogin(
                    passwordController: passwordController,
                    usernameController: usernameController,
                    onPressed: loginAndSave,
                  )
                // ).animate().fade(duration: 600.ms).slideY(begin: 0.3, end: 0)
                : const RedirectToABS().animate().fadeIn().slideY(
                      curve: Curves.easeInOut,
                      duration: 500.ms,
                    ),
          ),
        ],
      ),
    );
  }
}

class RedirectToABS extends StatelessWidget {
  const RedirectToABS({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // a simple text with hyper link to only the "click here" part
          const Text('Do not have a server? '),
          // a simple text with hyper link to the github page
          TextButton(
            autofocus: false,
            isSemanticButton: false,
            style: ButtonStyle(
              elevation: MaterialStateProperty.all(0),
              padding: MaterialStateProperty.all(
                const EdgeInsets.all(0),
              ),
            ),
            onPressed: () async {
              // open the github page
              // ignore: avoid_print
              print('Opening the github page');
              await _launchUrl(
                Uri.parse(
                  'https://www.audiobookshelf.org',
                ),
              );
            },
            child: const Text('Click here'),
          ),
          const Text(' to know how to setup a server.'),
        ],
      ),
    );
  }
}

Future<void> _launchUrl(Uri url) async {
  if (!await launchUrl(
    url,
    mode: LaunchMode.platformDefault,
    webOnlyWindowName: '_blank',
  )) {
    // throw Exception('Could not launch $url');
    debugPrint('Could not launch $url');
  }
}
