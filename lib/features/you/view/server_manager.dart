import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vaani/api/api_provider.dart' show makeBaseUrl;
import 'package:vaani/api/authenticated_users_provider.dart'
    show authenticatedUsersProvider;
import 'package:vaani/api/server_provider.dart'
    show ServerAlreadyExistsException, audiobookShelfServerProvider;
import 'package:vaani/features/onboarding/view/user_login.dart'
    show UserLoginWidget;
import 'package:vaani/features/player/view/mini_player_bottom_padding.dart'
    show MiniPlayerBottomPadding;
import 'package:vaani/main.dart' show appLogger;
import 'package:vaani/router/router.dart' show Routes;
import 'package:vaani/settings/api_settings_provider.dart'
    show apiSettingsProvider;
import 'package:vaani/settings/models/models.dart' as model;
import 'package:vaani/shared/extensions/obfuscation.dart' show ObfuscateSet;
import 'package:vaani/shared/widgets/add_new_server.dart' show AddNewServer;

class ServerManagerPage extends HookConsumerWidget {
  const ServerManagerPage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Accounts'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ServerManagerBody(),
        ),
      ),
    );
  }
}

class ServerManagerBody extends HookConsumerWidget {
  const ServerManagerBody({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registeredServers = ref.watch(audiobookShelfServerProvider);
    final registeredServersAsList = registeredServers.toList();
    final availableUsers = ref.watch(authenticatedUsersProvider);
    final apiSettings = ref.watch(apiSettingsProvider);
    final serverURIController = useTextEditingController();
    final formKey = GlobalKey<FormState>();

    appLogger.fine('registered servers: ${registeredServers.obfuscate()}');
    appLogger.fine('available users: ${availableUsers.obfuscate()}');

    return Column(
      // crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const Text(
          'Registered Servers',
        ),
        Expanded(
          child: ListView.builder(
            itemCount: registeredServers.length,
            reverse: true,
            itemBuilder: (context, index) {
              var registeredServer = registeredServersAsList[index];
              return ExpansionTile(
                title: Text(registeredServer.serverUrl.toString()),
                subtitle: Text(
                  'Users: ${availableUsers.where((element) => element.server == registeredServer).length}',
                ),
                // children are list of users of this server
                children: availableUsers
                    .where(
                      (element) => element.server == registeredServer,
                    )
                    .map<Widget>(
                      (e) => AvailableUserTile(user: e),
                    )
                    .nonNulls
                    .toList()

                  // add buttons of delete server and add user to server at the end
                  ..addAll([
                    AddUserTile(server: registeredServer),
                    DeleteServerTile(server: registeredServer),
                  ]),
              );
            },
          ),
        ),
        const SizedBox(height: 20),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('Add New Server'),
        ),
        Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: AddNewServer(
            controller: serverURIController,
            onPressed: () {
              if (formKey.currentState!.validate()) {
                try {
                  final newServer = model.AudiobookShelfServer(
                    serverUrl: makeBaseUrl(serverURIController.text),
                  );
                  ref.read(audiobookShelfServerProvider.notifier).addServer(
                        newServer,
                      );
                  ref.read(apiSettingsProvider.notifier).updateState(
                        apiSettings.copyWith(
                          activeServer: newServer,
                        ),
                      );
                  serverURIController.clear();
                } on ServerAlreadyExistsException catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(e.toString()),
                    ),
                  );
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Invalid URL'),
                  ),
                );
              }
            },
          ),
        ),
        MiniPlayerBottomPadding(),
      ],
    );
  }
}

class DeleteServerTile extends HookConsumerWidget {
  const DeleteServerTile({
    super.key,
    required this.server,
  });

  final model.AudiobookShelfServer server;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      leading: const Icon(Icons.delete),
      title: const Text('Delete Server'),
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Remove Server and Users'),
              // Make content scrollable in case of smaller screens/keyboard
              content: SingleChildScrollView(
                child: Text.rich(
                  TextSpan(
                    children: [
                      const TextSpan(
                        text: 'This will remove the server ',
                      ),
                      TextSpan(
                        text: server.serverUrl.host,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      const TextSpan(
                        text: ' and all its users\' login info from this app.',
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    ref
                        .read(
                          audiobookShelfServerProvider.notifier,
                        )
                        .removeServer(
                          server,
                          removeUsers: true,
                        );
                    Navigator.of(context).pop();
                  },
                  child: const Text('Delete'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class AddUserTile extends HookConsumerWidget {
  const AddUserTile({
    super.key,
    required this.server,
  });

  final model.AudiobookShelfServer server;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      leading: const Icon(Icons.person_add),
      title: const Text('Add User'),
      onTap: () async {
        await showDialog(
          context: context,
          // barrierDismissible: false, // Optional: prevent closing by tapping outside
          builder: (dialogContext) {
            // Use a different context name to avoid conflicts
            return AlertDialog(
              title: Text('Add User to ${server.serverUrl.host}'),
              // Make content scrollable in case of smaller screens/keyboard
              content: SingleChildScrollView(
                child: UserLoginWidget(
                  server: server.serverUrl,
                  // Pass the callback to pop the dialog on success
                  onSuccess: (user) {
                    // Add the user to the server
                    ref.read(authenticatedUsersProvider.notifier).addUser(user);
                    Navigator.of(dialogContext).pop(); // Close the dialog
                    // Optional: Show a confirmation SnackBar
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('User added successfully! Switch?'),
                        action: SnackBarAction(
                          label: 'Switch',
                          onPressed: () {
                            // Switch to the new user
                            ref.read(apiSettingsProvider.notifier).updateState(
                                  ref.read(apiSettingsProvider).copyWith(
                                        activeUser: user,
                                      ),
                                );
                            context.goNamed(Routes.home.name);
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(dialogContext).pop(); // Close the dialog
                  },
                  child: const Text('Cancel'),
                ),
              ],
            );
          },
        );
        // No need for the SnackBar asking to switch user here anymore.
      },
    );
  }
}

class AvailableUserTile extends HookConsumerWidget {
  const AvailableUserTile({
    super.key,
    required this.user,
  });

  final model.AuthenticatedUser user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final apiSettings = ref.watch(apiSettingsProvider);

    return ListTile(
      selected: apiSettings.activeUser == user,
      leading: apiSettings.activeUser == user
          ? const Icon(Icons.person)
          : const Icon(Icons.person_off_outlined),
      title: Text(user.username ?? 'Anonymous'),
      onTap: apiSettings.activeUser == user
          ? null
          : () {
              ref.read(apiSettingsProvider.notifier).updateState(
                    apiSettings.copyWith(
                      activeUser: user,
                    ),
                  );
              // pop all routes and go to the home page
              // while (context.canPop()) {
              //   context.pop();
              // }
              context.goNamed(
                Routes.home.name,
              );
            },
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Remove User Login'),
                content: Text.rich(
                  TextSpan(
                    children: [
                      const TextSpan(
                        text: 'This will remove login details of the user ',
                      ),
                      TextSpan(
                        text: user.username ?? 'Anonymous',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      const TextSpan(
                        text: ' from this app.',
                      ),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      ref
                          .read(
                            authenticatedUsersProvider.notifier,
                          )
                          .removeUser(user);
                      Navigator.of(context).pop();
                    },
                    child: const Text('Delete'),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
