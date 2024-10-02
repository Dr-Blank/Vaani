import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_settings_ui/flutter_settings_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:vaani/api/authenticated_user_provider.dart';
import 'package:vaani/api/server_provider.dart';
import 'package:vaani/router/router.dart';
import 'package:vaani/settings/app_settings_provider.dart';
import 'package:vaani/settings/models/app_settings.dart' as model;
import 'package:vaani/settings/view/simple_settings_page.dart';
import 'package:vaani/settings/view/widgets/navigation_with_switch_tile.dart';

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
    final sleepTimerSettings = appSettings.sleepTimerSettings;

    return SimpleSettingsPage(
      title: const Text('App Settings'),
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
              initialValue: appSettings.themeSettings.isDarkMode,
              title: const Text('Dark Mode'),
              description: const Text('we all know dark mode is better'),
              leading: appSettings.themeSettings.isDarkMode
                  ? const Icon(Icons.dark_mode)
                  : const Icon(Icons.light_mode),
              onToggle: (value) {
                ref.read(appSettingsProvider.notifier).toggleDarkMode();
              },
            ),
            SettingsTile.switchTile(
              initialValue:
                  appSettings.themeSettings.useMaterialThemeOnItemPage,
              title: const Text('Adaptive Theme on Item Page'),
              description: const Text(
                'get fancy with the colors on the item page at the cost of some performance',
              ),
              leading: appSettings.themeSettings.useMaterialThemeOnItemPage
                  ? const Icon(Icons.auto_fix_high)
                  : const Icon(Icons.auto_fix_off),
              onToggle: (value) {
                ref.read(appSettingsProvider.notifier).update(
                      appSettings.copyWith.themeSettings(
                        useMaterialThemeOnItemPage: value,
                      ),
                    );
              },
            ),
          ],
        ),

        // General section
        SettingsSection(
          margin: const EdgeInsetsDirectional.symmetric(
            horizontal: 16.0,
            vertical: 8.0,
          ),
          title: Text(
            'General',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          tiles: [
            NavigationWithSwitchTile(
              title: const Text('Auto Turn On Sleep Timer'),
              description: const Text(
                'Automatically turn on the sleep timer based on the time of day',
              ),
              leading: sleepTimerSettings.autoTurnOnTimer
                  ? const Icon(Symbols.time_auto, fill: 1)
                  : const Icon(Symbols.timer_off, fill: 1),
              onPressed: (context) {
                context.pushNamed(Routes.autoSleepTimerSettings.name);
              },
              value: sleepTimerSettings.autoTurnOnTimer,
              onToggle: (value) {
                ref.read(appSettingsProvider.notifier).update(
                      appSettings.copyWith.sleepTimerSettings(
                        autoTurnOnTimer: value,
                      ),
                    );
              },
            ),
            SettingsTile(
              title: const Text('Notification Media Player'),
              leading: const Icon(Icons.play_lesson),
              description: const Text(
                'Customize the media player in notifications',
              ),
              onPressed: (context) {
                context.pushNamed(Routes.notificationSettings.name);
              },
            ),
            SettingsTile(
              title: const Text('Player Settings'),
              leading: const Icon(Icons.play_arrow),
              description: const Text(
                'Customize the player settings',
              ),
              onPressed: (context) {
                context.pushNamed(Routes.playerSettings.name);
              },
            ),
            NavigationWithSwitchTile(
              title: const Text('Shake Detector'),
              leading: const Icon(Icons.vibration),
              description: const Text(
                'Customize the shake detector settings',
              ),
              value: appSettings.shakeDetectionSettings.isEnabled,
              onPressed: (context) {
                context.pushNamed(Routes.shakeDetectorSettings.name);
              },
              onToggle: (value) {
                ref.read(appSettingsProvider.notifier).update(
                      appSettings.copyWith.shakeDetectionSettings(
                        isEnabled: value,
                      ),
                    );
              },
            ),
          ],
        ),
        // Backup and Restore section
        SettingsSection(
          margin: const EdgeInsetsDirectional.symmetric(
            horizontal: 16.0,
            vertical: 8.0,
          ),
          title: Text(
            'Backup and Restore',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          tiles: [
            SettingsTile(
              title: const Text('Copy to Clipboard'),
              leading: const Icon(Icons.copy),
              description: const Text(
                'Copy the app settings to the clipboard',
              ),
              onPressed: (context) async {
                // copy to clipboard
                await Clipboard.setData(
                  ClipboardData(
                    text: jsonEncode(appSettings.toJson()),
                  ),
                );
                // show toast
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Settings copied to clipboard'),
                  ),
                );
              },
            ),
            SettingsTile(
              title: const Text('Restore'),
              leading: const Icon(Icons.restore),
              description: const Text(
                'Restore the app settings from the backup',
              ),
              onPressed: (context) {
                final formKey = GlobalKey<FormState>();
                // show a dialog to get the backup
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Restore Backup'),
                      content: Form(
                        key: formKey,
                        child: TextFormField(
                          controller: serverURIController,
                          decoration: const InputDecoration(
                            labelText: 'Backup',
                            hintText: 'Paste the backup here',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please paste the backup here';
                            }
                            return null;
                          },
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
                            if (formKey.currentState!.validate()) {
                              final backup = serverURIController.text;
                              final newSettings = model.AppSettings.fromJson(
                                // decode the backup as json
                                jsonDecode(backup),
                              );
                              ref
                                  .read(appSettingsProvider.notifier)
                                  .update(newSettings);
                              Navigator.of(context).pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Settings restored'),
                                ),
                              );
                              // clear the backup
                              serverURIController.clear();
                            }
                          },
                          child: const Text('Restore'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),

            // a button to reset the app settings
            SettingsTile(
              title: const Text('Reset App Settings'),
              leading: const Icon(Icons.settings_backup_restore),
              description: const Text(
                'Reset the app settings to the default values',
              ),
              onPressed: (context) async {
                // confirm the reset
                final res = await showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Reset App Settings'),
                      content: const Text(
                        'Are you sure you want to reset the app settings?',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(false);
                          },
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(true);
                          },
                          child: const Text('Reset'),
                        ),
                      ],
                    );
                  },
                );

                // if the user confirms the reset
                if (res == true) {
                  ref.read(appSettingsProvider.notifier).reset();
                }
              },
            ),
          ],
        ),
      ],
    );
  }
}
