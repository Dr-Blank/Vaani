import 'package:flutter/material.dart';
import 'package:flutter_settings_ui/flutter_settings_ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:whispering_pages/settings/app_settings_provider.dart';
import 'package:whispering_pages/shared/extensions/time_of_day.dart';

class AutoSleepTimerSettingsPage extends HookConsumerWidget {
  const AutoSleepTimerSettingsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appSettings = ref.watch(appSettingsProvider);
    final sleepTimerSettings = appSettings.playerSettings.sleepTimerSettings;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Auto Sleep Timer Settings'),
      ),
      body: SettingsList(
        sections: [
          SettingsSection(
            margin: const EdgeInsetsDirectional.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            tiles: [
              SettingsTile.switchTile(
                // initialValue: sleepTimerSettings.autoTurnOnTimer,
                title: const Text('Auto Turn On Timer'),
                description: const Text(
                  'Automatically turn on the sleep timer based on the time of day',
                ),
                leading: sleepTimerSettings.autoTurnOnTimer
                    ? const Icon(Icons.timer)
                    : const Icon(Icons.timer_off),
                onToggle: (value) {
                  ref.read(appSettingsProvider.notifier).updateState(
                        appSettings.copyWith.playerSettings.sleepTimerSettings(
                          autoTurnOnTimer: value,
                        ),
                      );
                },
                initialValue: sleepTimerSettings.autoTurnOnTimer,
              ),
              // auto turn on time settings, enabled only when autoTurnOnTimer is enabled
              SettingsTile.navigation(
                enabled: sleepTimerSettings.autoTurnOnTimer,
                title: const Text('Auto Turn On Time'),
                description: const Text(
                  'Turn on the sleep timer at the specified time',
                ),
                onPressed: (context) async {
                  // navigate to the time picker
                  final selected = await showTimePicker(
                    context: context,
                    initialTime:
                        sleepTimerSettings.autoTurnOnTime.toTimeOfDay(),
                  );
                  if (selected != null) {
                    ref.read(appSettingsProvider.notifier).updateState(
                          appSettings.copyWith.playerSettings
                              .sleepTimerSettings(
                            autoTurnOnTime: selected.toDuration(),
                          ),
                        );
                  }
                },
                value: Text(
                  sleepTimerSettings.autoTurnOnTime
                      .toTimeOfDay()
                      .format(context),
                ),
              ),
              SettingsTile.navigation(
                title: const Text('Auto Turn Off Time'),
                description: const Text(
                  'Turn off the sleep timer at the specified time',
                ),
                enabled: sleepTimerSettings.autoTurnOnTimer,
                onPressed: (context) async {
                  // navigate to the time picker
                  final selected = await showTimePicker(
                    context: context,
                    initialTime:
                        sleepTimerSettings.autoTurnOffTime.toTimeOfDay(),
                  );
                  if (selected != null) {
                    ref.read(appSettingsProvider.notifier).updateState(
                          appSettings.copyWith.playerSettings
                              .sleepTimerSettings(
                            autoTurnOffTime: selected.toDuration(),
                          ),
                        );
                  }
                },
                value: Text(
                  sleepTimerSettings.autoTurnOffTime
                      .toTimeOfDay()
                      .format(context),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
