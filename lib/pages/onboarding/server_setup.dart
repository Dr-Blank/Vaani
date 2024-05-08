import 'package:coast/coast.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:whispering_pages/api/server_provider.dart';
import 'package:whispering_pages/settings/models/audiobookshelf_server.dart' as model;
import 'package:whispering_pages/settings/api_settings_provider.dart';
import 'package:whispering_pages/widgets/add_new_server.dart';

class FirstTimeServerSetupPage extends HookConsumerWidget {
  const FirstTimeServerSetupPage({
    super.key,
    required this.controller,
    required this.heroServerTag,
  });
  final TextEditingController controller;
  final String heroServerTag;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final apiSettings = ref.watch(apiSettingsProvider);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Welcome to Whispering Pages'),
          Crab(
            tag: heroServerTag,
            child: AddNewServer(
              controller: controller,
              allowEmpty: true,
              onPressed: () {
                var newServer = controller.text.isEmpty
                    ? null
                    : model.AudiobookShelfServer(
                        serverUrl: Uri.parse(controller.text),
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
              },
            ),
          ),
        ],
      ),
    );
  }
}
