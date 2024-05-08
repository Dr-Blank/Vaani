import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:whispering_pages/api/authenticated_user_provider.dart';
import 'package:whispering_pages/api/server_provider.dart';
import 'package:whispering_pages/settings/models/audiobookshelf_server.dart' as model;
import 'package:whispering_pages/settings/api_settings_provider.dart';
import 'package:whispering_pages/widgets/add_new_server.dart';

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
        title: const Text('Setup Servers'),
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
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        // delete the server from the list of servers
                        onPressed: () {
                          ref
                              .read(audiobookShelfServerProvider.notifier)
                              .removeServer(registeredServer);
                        },
                      ),
                      // children are list of users of this server
                      children: availableUsers
                          .where(
                            (element) => element.server == registeredServer,
                          )
                          .map(
                            (e) => ListTile(
                              title: Text(e.username ?? 'Anonymous'),
                              subtitle: Text(e.authToken),
                              trailing: IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  ref
                                      .read(authenticatedUserProvider.notifier)
                                      .removeUser(e);
                                },
                              ),
                            ),
                          )
                          .nonNulls
                          .toList(),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              Form(
                key: formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: AddNewServer(
                  controller: serverURIController,
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      try {
                        final newServer = model.AudiobookShelfServer(
                          serverUrl: Uri.parse(serverURIController.text),
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
