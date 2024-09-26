import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_settings_ui/flutter_settings_ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vaani/settings/app_settings_provider.dart';
import 'package:vaani/settings/view/buttons.dart';
import 'package:vaani/settings/view/simple_settings_page.dart';
import 'package:vaani/shared/extensions/duration_format.dart';

class PlayerSettingsPage extends HookConsumerWidget {
  const PlayerSettingsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appSettings = ref.watch(appSettingsProvider);
    final playerSettings = appSettings.playerSettings;

    return SimpleSettingsPage(
      title: const Text('Player Settings'),
      sections: [
        SettingsSection(
          margin: const EdgeInsetsDirectional.symmetric(
            horizontal: 16.0,
            vertical: 8.0,
          ),
          tiles: [
            // preferred settings for every book
            SettingsTile.switchTile(
              title: const Text('Remember Player Settings for Every Book'),
              leading: const Icon(Icons.settings_applications),
              description: const Text(
                'Settings like speed, loudness, etc. will be remembered for every book',
              ),
              initialValue: playerSettings.configurePlayerForEveryBook,
              onToggle: (value) {
                ref.read(appSettingsProvider.notifier).update(
                      appSettings.copyWith.playerSettings(
                        configurePlayerForEveryBook: value,
                      ),
                    );
              },
            ),

            // preferred default speed
            SettingsTile(
              title: const Text('Default Speed'),
              description: Text('${playerSettings.preferredDefaultSpeed}x'),
              leading: const Icon(Icons.speed),
              onPressed: (context) async {
                final newSpeed = await showDialog(
                  context: context,
                  builder: (context) => SpeedPicker(
                    initialValue: playerSettings.preferredDefaultSpeed,
                  ),
                );
                if (newSpeed != null) {
                  ref.read(appSettingsProvider.notifier).update(
                        appSettings.copyWith.playerSettings(
                          preferredDefaultSpeed: newSpeed,
                        ),
                      );
                }
              },
            ),
            // preferred speed options
            SettingsTile(
              title: const Text('Speed Options'),
              description: Text(
                playerSettings.speedOptions.map((e) => '${e}x').join(', '),
              ),
              leading: const Icon(Icons.speed),
              onPressed: (context) async {
                final newSpeedOptions = await showDialog<List<double>?>(
                  context: context,
                  builder: (context) => SpeedOptionsPicker(
                    initialValue: playerSettings.speedOptions,
                  ),
                );
                if (newSpeedOptions != null) {
                  ref.read(appSettingsProvider.notifier).update(
                        appSettings.copyWith.playerSettings(
                          speedOptions: newSpeedOptions..sort(),
                        ),
                      );
                }
              },
            ),
          ],
        ),

        // Playback Reporting
        SettingsSection(
          title: const Text('Playback Reporting'),
          tiles: [
            SettingsTile(
              title: const Text('Minimum Position to Report'),
              description: Text.rich(
                TextSpan(
                  text: 'Do not report playback for the first ',
                  children: [
                    TextSpan(
                      text: playerSettings
                          .minimumPositionForReporting.smartBinaryFormat,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const TextSpan(text: ' of the book'),
                  ],
                ),
              ),
              leading: const Icon(Icons.timer),
              onPressed: (context) async {
                final newDuration = await showDialog(
                  context: context,
                  builder: (context) {
                    return TimeDurationSelector(
                      title: const Text('Ignore Playback Position Less Than'),
                      baseUnit: BaseUnit.second,
                      initialValue: playerSettings.minimumPositionForReporting,
                    );
                  },
                );
                if (newDuration != null) {
                  ref.read(appSettingsProvider.notifier).update(
                        appSettings.copyWith.playerSettings(
                          minimumPositionForReporting: newDuration,
                        ),
                      );
                }
              },
            ),
            // when to mark complete
            SettingsTile(
              title: const Text('Mark Complete When Time Left'),
              description: Text.rich(
                TextSpan(
                  text: 'Mark complete when less than ',
                  children: [
                    TextSpan(
                      text: playerSettings
                          .markCompleteWhenTimeLeft.smartBinaryFormat,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const TextSpan(text: ' left in the book'),
                  ],
                ),
              ),
              leading: const Icon(Icons.cloud_done),
              onPressed: (context) async {
                final newDuration = await showDialog(
                  context: context,
                  builder: (context) {
                    return TimeDurationSelector(
                      title: const Text('Mark Complete When Time Left'),
                      baseUnit: BaseUnit.second,
                      initialValue: playerSettings.markCompleteWhenTimeLeft,
                    );
                  },
                );
                if (newDuration != null) {
                  ref.read(appSettingsProvider.notifier).update(
                        appSettings.copyWith.playerSettings(
                          markCompleteWhenTimeLeft: newDuration,
                        ),
                      );
                }
              },
            ),
            // playback report interval
            SettingsTile(
              title: const Text('Playback Report Interval'),
              description: Text.rich(
                TextSpan(
                  text: 'Report progress every ',
                  children: [
                    TextSpan(
                      text: playerSettings
                          .playbackReportInterval.smartBinaryFormat,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const TextSpan(text: ' to the server'),
                  ],
                ),
              ),
              leading: const Icon(Icons.change_circle_outlined),
              onPressed: (context) async {
                final newDuration = await showDialog(
                  context: context,
                  builder: (context) {
                    return TimeDurationSelector(
                      title: const Text('Playback Report Interval'),
                      baseUnit: BaseUnit.second,
                      initialValue: playerSettings.playbackReportInterval,
                    );
                  },
                );
                if (newDuration != null) {
                  ref.read(appSettingsProvider.notifier).update(
                        appSettings.copyWith.playerSettings(
                          playbackReportInterval: newDuration,
                        ),
                      );
                }
              },
            ),
          ],
        ),
        // Display Settings
        SettingsSection(
          title: const Text('Display Settings'),
          tiles: [
            // show total progress
            SettingsTile.switchTile(
              title: const Text('Show Total Progress'),
              leading: const Icon(Icons.show_chart),
              description: const Text(
                'Show the total progress of the book in the player',
              ),
              initialValue:
                  playerSettings.expandedPlayerSettings.showTotalProgress,
              onToggle: (value) {
                ref.read(appSettingsProvider.notifier).update(
                      appSettings.copyWith.playerSettings
                          .expandedPlayerSettings(showTotalProgress: value),
                    );
              },
            ),
            // show chapter progress
            SettingsTile.switchTile(
              title: const Text('Show Chapter Progress'),
              leading: const Icon(Icons.show_chart),
              description: const Text(
                'Show the progress of the current chapter in the player',
              ),
              initialValue:
                  playerSettings.expandedPlayerSettings.showChapterProgress,
              onToggle: (value) {
                ref.read(appSettingsProvider.notifier).update(
                      appSettings.copyWith.playerSettings(
                        expandedPlayerSettings: playerSettings
                            .expandedPlayerSettings
                            .copyWith(showChapterProgress: value),
                      ),
                    );
              },
            ),
          ],
        ),
      ],
    );
  }
}

class TimeDurationSelector extends HookConsumerWidget {
  const TimeDurationSelector({
    super.key,
    this.title = const Text('Select Duration'),
    this.baseUnit = BaseUnit.second,
    this.initialValue = Duration.zero,
  });

  final Widget title;
  final BaseUnit baseUnit;
  final Duration initialValue;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final duration = useState(initialValue);
    return AlertDialog(
      title: title,
      content: DurationPicker(
        duration: duration.value,
        baseUnit: baseUnit,
        onChange: (value) {
          duration.value = value;
        },
      ),
      actions: [
        const CancelButton(),
        OkButton(
          onPressed: () {
            Navigator.of(context).pop(duration.value);
          },
        ),
      ],
    );
  }
}

class SpeedPicker extends HookConsumerWidget {
  const SpeedPicker({
    super.key,
    this.initialValue = 1,
  });

  final double initialValue;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final speedController =
        useTextEditingController(text: initialValue.toString());
    final speed = useState<double?>(initialValue);
    return AlertDialog(
      title: const Text('Select Speed'),
      content: TextField(
        controller: speedController,
        onChanged: (value) => speed.value = double.tryParse(value),
        onSubmitted: (value) {
          Navigator.of(context).pop(speed.value);
        },
        autofocus: true,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          labelText: 'Speed',
          helper: Text(
            'Enter the speed you want to set when playing for the first time',
          ),
        ),
      ),
      actions: [
        const CancelButton(),
        OkButton(
          onPressed: () {
            Navigator.of(context).pop(speed.value);
          },
        ),
      ],
    );
  }
}

class SpeedOptionsPicker extends HookConsumerWidget {
  const SpeedOptionsPicker({
    super.key,
    this.initialValue = const [0.75, 1, 1.25, 1.5, 1.75, 2],
  });

  final List<double> initialValue;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final speedOptionAddController = useTextEditingController();
    final speedOptions = useState<List<double>>(initialValue);
    final focusNode = useFocusNode();
    return AlertDialog(
      title: const Text('Select Speed Options'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: speedOptions.value
                .map(
                  (speed) => Chip(
                    label: Text('${speed}x'),
                    onDeleted: speed == 1
                        ? null
                        : () {
                            speedOptions.value =
                                speedOptions.value.where((element) {
                              // speed option 1 can't be removed
                              return element != speed;
                            }).toList();
                          },
                  ),
                )
                .toList()
              ..sort((a, b) {
                // if (a.label == const Text('1x')) {
                //   return -1;
                // } else if (b.label == const Text('1x')) {
                //   return 1;
                // }
                return a.label.toString().compareTo(b.label.toString());
              }),
          ),
          TextField(
            focusNode: focusNode,
            autofocus: true,
            controller: speedOptionAddController,
            onSubmitted: (value) {
              final newSpeed = double.tryParse(value);
              if (newSpeed != null && !speedOptions.value.contains(newSpeed)) {
                speedOptions.value = [...speedOptions.value, newSpeed];
              }
              speedOptionAddController.clear();
              focusNode.requestFocus();
            },
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Add Speed Option',
              helper: Text('Enter a new speed option to add'),
            ),
          ),
        ],
      ),
      actions: [
        const CancelButton(),
        OkButton(
          onPressed: () {
            Navigator.of(context).pop(speedOptions.value);
          },
        ),
      ],
    );
  }
}
