import 'package:flutter/material.dart';
import 'package:flutter_settings_ui/flutter_settings_ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:vaani/settings/app_settings_provider.dart';
import 'package:vaani/settings/view/simple_settings_page.dart';
import 'package:vaani/shared/extensions/time_of_day.dart';

class AutoSleepTimerSettingsPage extends HookConsumerWidget {
  const AutoSleepTimerSettingsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appSettings = ref.watch(appSettingsProvider);
    final sleepTimerSettings = appSettings.sleepTimerSettings;

    var enabled = sleepTimerSettings.autoTurnOnTimer &&
        !sleepTimerSettings.alwaysAutoTurnOnTimer;
    final selectedValueColor = enabled
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).disabledColor;
    return SimpleSettingsPage(
      title: const Text('Auto Sleep Timer Settings'),
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
                  ? const Icon(Symbols.time_auto)
                  : const Icon(Symbols.timer_off),
              onToggle: (value) {
                ref.read(appSettingsProvider.notifier).update(
                      appSettings.copyWith.sleepTimerSettings(
                        autoTurnOnTimer: value,
                      ),
                    );
              },
              initialValue: sleepTimerSettings.autoTurnOnTimer,
            ),
            // auto turn on time settings, enabled only when autoTurnOnTimer is enabled
            SettingsTile.navigation(
              enabled: enabled,
              leading: const Icon(Symbols.timer_play),
              title: const Text('From'),
              description: const Text(
                'Turn on the sleep timer at the specified time',
              ),
              onPressed: (context) async {
                // navigate to the time picker
                final selected = await showTimePicker(
                  context: context,
                  initialTime: sleepTimerSettings.autoTurnOnTime.toTimeOfDay(),
                );
                if (selected != null) {
                  ref.read(appSettingsProvider.notifier).update(
                        appSettings.copyWith.sleepTimerSettings(
                          autoTurnOnTime: selected.toDuration(),
                        ),
                      );
                }
              },
              trailing: Text(
                sleepTimerSettings.autoTurnOnTime.toTimeOfDay().format(context),
                style: TextStyle(color: selectedValueColor),
              ),
            ),
            SettingsTile.navigation(
              enabled: enabled,
              leading: const Icon(Symbols.timer_pause),
              title: const Text('Until'),
              description: const Text(
                'Turn off the sleep timer at the specified time',
              ),
              onPressed: (context) async {
                // navigate to the time picker
                final selected = await showTimePicker(
                  context: context,
                  initialTime: sleepTimerSettings.autoTurnOffTime.toTimeOfDay(),
                );
                if (selected != null) {
                  ref.read(appSettingsProvider.notifier).update(
                        appSettings.copyWith.sleepTimerSettings(
                          autoTurnOffTime: selected.toDuration(),
                        ),
                      );
                }
              },
              trailing: Text(
                sleepTimerSettings.autoTurnOffTime
                    .toTimeOfDay()
                    .format(context),
                style: TextStyle(color: selectedValueColor),
              ),
            ),

            // switch tile for always auto turn on timer no matter what
            SettingsTile.switchTile(
              leading: const Icon(Symbols.all_inclusive),
              title: const Text('Always Auto Turn On Timer'),
              description: const Text(
                'Always turn on the sleep timer, no matter what',
              ),
              onToggle: (value) {
                ref.read(appSettingsProvider.notifier).update(
                      appSettings.copyWith.sleepTimerSettings(
                        alwaysAutoTurnOnTimer: value,
                      ),
                    );
              },
              enabled: sleepTimerSettings.autoTurnOnTimer,
              initialValue: sleepTimerSettings.alwaysAutoTurnOnTimer,
            ),
          ],
        ),
      ],
    );
  }
}
