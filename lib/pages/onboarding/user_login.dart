import 'package:coast/coast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:whispering_pages/api/api_provider.dart';
import 'package:whispering_pages/api/authenticated_user_provider.dart'
    show authenticatedUserProvider;
import 'package:whispering_pages/settings/models/audiobookshelf_server.dart';
import 'package:whispering_pages/settings/models/authenticated_user.dart';
import 'package:whispering_pages/settings/api_settings_provider.dart';
import 'package:whispering_pages/widgets/add_new_server.dart';
import 'package:whispering_pages/widgets/user_login.dart';


/// Once the user has selected a server, they can login to it.
class FirstTimeUserLoginPage extends HookConsumerWidget {
  const FirstTimeUserLoginPage({
    super.key,
    required this.serverUriController,
    required this.heroServerTag,
  });

  final TextEditingController serverUriController;
  final String heroServerTag;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usernameController = useTextEditingController();
    final passwordController = useTextEditingController();

    final apiSettings = ref.watch(apiSettingsProvider);
    final api = ref
        .watch(audiobookshelfApiProvider(Uri.https(serverUriController.text)));

    /// Login to the server and save the user
    void loginAndSave() async {
      final username = usernameController.text;
      final password = passwordController.text;
      final success = await api.login(username: username, password: password);
      // debugPrint('Login success: $success');
      if (success != null) {
        var authenticatedUser = AuthenticatedUser(
          server: AudiobookShelfServer(
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
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login failed'),
          ),
        );
        // give focus back to the username field
      }
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Crab(
            tag: heroServerTag,
            child: AddNewServer(
              controller: serverUriController,
              onPressed: () {},
              readOnly: true,
            ),
          ),
          const SizedBox(height: 30),
          const Text('Login to server'),
          const SizedBox(height: 30),
          UserLogin(
            usernameController: usernameController,
            passwordController: passwordController,
            onPressed: loginAndSave,
          ),
        ],
      ),
    );
  }
}
