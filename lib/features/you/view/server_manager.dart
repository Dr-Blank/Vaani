import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vaani/api/api_provider.dart';
import 'package:vaani/api/authenticated_user_provider.dart';
import 'package:vaani/api/server_provider.dart';
import 'package:vaani/models/error_response.dart';
import 'package:vaani/router/router.dart';
import 'package:vaani/settings/api_settings_provider.dart';
import 'package:vaani/settings/models/models.dart' as model;
import 'package:vaani/shared/widgets/add_new_server.dart';

class ServerManagerPage extends HookConsumerWidget {
  const ServerManagerPage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final apiSettings = ref.watch(apiSettingsProvider);
    final registeredServers = ref.watch(audiobookShelfServerProvider);
    final registeredServersAsList = registeredServers.toList();
    final availableUsers = ref.watch(authenticatedUserProvider);
    final serverURIController = useTextEditingController();
    final formKey = GlobalKey<FormState>();

    debugPrint('registered servers: $registeredServers');
    debugPrint('available users: $availableUsers');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Accounts'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
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
                      // trailing: _DeleteServerButton(
                      //   registeredServer: registeredServer,
                      // ),
                      // children are list of users of this server
                      children: availableUsers
                          .where(
                            (element) => element.server == registeredServer,
                          )
                          .map(
                            (e) => ListTile(
                              selected: apiSettings.activeUser == e,
                              leading: apiSettings.activeUser == e
                                  ? const Icon(Icons.person)
                                  : const Icon(Icons.person_off_outlined),
                              title: Text(e.username ?? 'Anonymous'),
                              onTap: apiSettings.activeUser == e
                                  ? null
                                  : () {
                                      ref
                                          .read(apiSettingsProvider.notifier)
                                          .updateState(
                                            apiSettings.copyWith(
                                              activeUser: e,
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
                                        title: const Text('Delete User'),
                                        content: const Text(
                                          'Are you sure you want to delete this user?',
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
                                                    authenticatedUserProvider
                                                        .notifier,
                                                  )
                                                  .removeUser(e);
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
                            ),
                          )
                          .nonNulls
                          .toList()

                        // add buttons of delete server and add user to server at the end
                        ..addAll([
                          ListTile(
                            leading: const Icon(Icons.person_add),
                            title: const Text('Add User'),
                            onTap: () async {
                              // open a dialog to add a new user with username and password or another method using only auth token
                              final addedUser = await showDialog(
                                context: context,
                                builder: (context) {
                                  return _AddUserDialog(
                                    server: registeredServer,
                                  );
                                },
                              );

                              // if (addedUser != null) {
                              //   // show a snackbar that the user has been added and ask if change to this user
                              //   ScaffoldMessenger.of(context).showSnackBar(
                              //     SnackBar(
                              //       content: const Text(
                              //         'User added successfully, do you want to switch to this user?',
                              //       ),
                              //       action: SnackBarAction(
                              //         label: 'Switch',
                              //         onPressed: () {
                              //           // set the active user
                              //           ref
                              //               .read(apiSettingsProvider.notifier)
                              //               .updateState(
                              //                 apiSettings.copyWith(
                              //                   activeUser: addedUser,
                              //                 ),
                              //               );

                              //           context.goNamed(Routes.home.name);
                              //         },
                              //       ),
                              //     ),
                              //   );
                              // }
                            },
                          ),
                          ListTile(
                            leading: const Icon(Icons.delete),
                            title: const Text('Delete Server'),
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text('Delete Server'),
                                    content: const Text(
                                      'Are you sure you want to delete this server and all its users?',
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
                                                audiobookShelfServerProvider
                                                    .notifier,
                                              )
                                              .removeServer(
                                                registeredServer,
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
                          ),
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
                        ref
                            .read(audiobookShelfServerProvider.notifier)
                            .addServer(
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
            ],
          ),
        ),
      ),
    );
  }
}

class _AddUserDialog extends HookConsumerWidget {
  const _AddUserDialog({
    super.key,
    required this.server,
  });

  final model.AudiobookShelfServer server;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usernameController = useTextEditingController();
    final passwordController = useTextEditingController();
    final authTokensController = useTextEditingController();
    final isPasswordVisible = useState(false);
    final apiSettings = ref.watch(apiSettingsProvider);
    final isMethodAuth = useState(false);
    final api = ref.watch(audiobookshelfApiProvider(server.serverUrl));

    final formKey = GlobalKey<FormState>();

    final serverErrorResponse = ErrorResponseHandler();

    /// Login to the server and save the user
    Future<model.AuthenticatedUser?> loginAndSave() async {
      model.AuthenticatedUser? authenticatedUser;
      if (isMethodAuth.value) {
        api.token = authTokensController.text;
        final success = await api.misc.authorize(
          responseErrorHandler: serverErrorResponse.storeError,
        );
        if (success != null) {
          authenticatedUser = model.AuthenticatedUser(
            server: server,
            id: success.user.id,
            username: success.user.username,
            authToken: api.token!,
          );
        }
      } else {
        final username = usernameController.text;
        final password = passwordController.text;
        final success = await api.login(
          username: username,
          password: password,
          responseErrorHandler: serverErrorResponse.storeError,
        );
        if (success != null) {
          authenticatedUser = model.AuthenticatedUser(
            server: server,
            id: success.user.id,
            username: username,
            authToken: api.token!,
          );
        }
      }
      // add the user to the list of users
      if (authenticatedUser != null) {
        ref.read(authenticatedUserProvider.notifier).addUser(authenticatedUser);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Login failed. Got response: ${serverErrorResponse.response.body} (${serverErrorResponse.response.statusCode})',
            ),
          ),
        );
      }
      return authenticatedUser;
    }

    return AlertDialog(
      // title: Text('Add User for ${server.serverUrl}'),
      title: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: 'Add User for ',
              style: Theme.of(context).textTheme.labelLarge,
            ),
            TextSpan(
              text: server.serverUrl.toString(),
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
          ],
        ),
      ),
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 8.0,
              children: [
                ChoiceChip(
                  label: const Text('Username/Password'),
                  selected: !isMethodAuth.value,
                  onSelected: (selected) {
                    isMethodAuth.value = !selected;
                  },
                ),
                ChoiceChip(
                  label: const Text('Auth Token'),
                  selected: isMethodAuth.value,
                  onSelected: (selected) {
                    isMethodAuth.value = selected;
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (isMethodAuth.value)
              TextFormField(
                controller: authTokensController,
                decoration: const InputDecoration(labelText: 'Auth Token'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an auth token';
                  }
                  return null;
                },
              )
            else ...[
              TextFormField(
                controller: usernameController,
                decoration: const InputDecoration(labelText: 'Username'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a username';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  suffixIcon: IconButton(
                    icon: Icon(
                      isPasswordVisible.value
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      isPasswordVisible.value = !isPasswordVisible.value;
                    },
                  ),
                ),
                obscureText: !isPasswordVisible.value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                  return null;
                },
              ),
            ],
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
        ElevatedButton(
          onPressed: () async {
            if (formKey.currentState!.validate()) {
              final addedUser = await loginAndSave();
              if (addedUser != null) {
                Navigator.of(context).pop(addedUser);
              }
            }
          },
          child: const Text('Add User'),
        ),
      ],
    );
  }
}
