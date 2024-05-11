import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_settings_ui/flutter_settings_ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:whispering_pages/api/authenticated_user_provider.dart';
import 'package:whispering_pages/api/server_provider.dart';
import 'package:whispering_pages/settings/app_settings_provider.dart';

class AppSettingsPage extends HookConsumerWidget {
  const AppSettingsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appSettings = ref.watch(appSettingsProvider);
    final registeredServers = ref.watch(audiobookShelfServerProvider);
    final registeredServersAsList = registeredServers.toList();
    final availableUsers = ref.watch(authenticatedUserProvider);
    final serverURIController = useTextEditingController();
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('App Settings'),
      ),
      body: SettingsList(
        sections: [
          SettingsSection(
            title: const Text('Appearance'),
            tiles: [
              SettingsTile.switchTile(
                initialValue: appSettings.isDarkMode,
                title: const Text('Dark Mode'),
                leading: appSettings.isDarkMode
                    ? const Icon(Icons.dark_mode)
                    : const Icon(Icons.light_mode),
                onToggle: (value) {
                  ref.read(appSettingsProvider.notifier).toggleDarkMode();
                },
              ),
              SettingsTile.switchTile(
                initialValue: appSettings.useMaterialThemeOnItemPage,
                title: const Text('Use Material Theming on Item Page'),
                leading: const Icon(Icons.dynamic_form_outlined),
                onToggle: (value) {
                  ref.read(appSettingsProvider.notifier).updateState(
                        appSettings.copyWith(
                          useMaterialThemeOnItemPage: value,
                        ),
                      );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
