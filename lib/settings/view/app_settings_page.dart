import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_settings_ui/flutter_settings_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:whispering_pages/api/authenticated_user_provider.dart';
import 'package:whispering_pages/api/server_provider.dart';
import 'package:whispering_pages/router/router.dart';
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
    final sleepTimerSettings = appSettings.playerSettings.sleepTimerSettings;

    return Scaffold(
      appBar: AppBar(
        title: const Text('App Settings'),
      ),
      body: SettingsList(
        sections: [
          // Appearance section
          SettingsSection(
            margin: const EdgeInsetsDirectional.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            title: Text(
              'Appearance',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            tiles: [
              SettingsTile.switchTile(
                initialValue: appSettings.isDarkMode,
                title: const Text('Dark Mode'),
                description: const Text('we all know dark mode is better'),
                leading: appSettings.isDarkMode
                    ? const Icon(Icons.dark_mode)
                    : const Icon(Icons.light_mode),
                onToggle: (value) {
                  ref.read(appSettingsProvider.notifier).toggleDarkMode();
                },
              ),
              SettingsTile.switchTile(
                initialValue: appSettings.useMaterialThemeOnItemPage,
                title: const Text('Adaptive Theme on Item Page'),
                description: const Text(
                  'get fancy with the colors on the item page at the cost of some performance',
                ),
                leading: appSettings.useMaterialThemeOnItemPage
                    ? const Icon(Icons.auto_fix_high)
                    : const Icon(Icons.auto_fix_off),
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

          // Sleep Timer section
          SettingsSection(
            margin: const EdgeInsetsDirectional.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            title: Text(
              'Sleep Timer',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            tiles: [
              SettingsTile.navigation(
                // initialValue: sleepTimerSettings.autoTurnOnTimer,
                title: const Text('Auto Turn On Timer'),
                description: const Text(
                  'Automatically turn on the sleep timer based on the time of day',
                ),
                leading: sleepTimerSettings.autoTurnOnTimer
                    ? const Icon(Icons.timer)
                    : const Icon(Icons.timer_off),
                onPressed: (context) {
                  // push the sleep timer settings page
                  context.pushNamed(Routes.autoSleepTimerSettings.name);
                },
                // a switch to enable or disable the auto turn off time
                trailing: IntrinsicHeight(
                  child: Row(
                    children: [
                      VerticalDivider(
                        color: Theme.of(context).dividerColor.withOpacity(0.5),
                        indent: 8.0,
                        endIndent: 8.0,
                        // width: 8.0,
                        // thickness: 2.0,
                        // height: 24.0,
                      ),
                      Switch(
                        value: sleepTimerSettings.autoTurnOnTimer,
                        onChanged: (value) {
                          ref.read(appSettingsProvider.notifier).updateState(
                                appSettings.copyWith.playerSettings
                                    .sleepTimerSettings(
                                  autoTurnOnTimer: value,
                                ),
                              );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}