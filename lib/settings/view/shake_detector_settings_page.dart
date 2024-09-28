import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_settings_ui/flutter_settings_ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vaani/settings/app_settings_provider.dart';
import 'package:vaani/settings/models/app_settings.dart';
import 'package:vaani/settings/view/buttons.dart';
import 'package:vaani/settings/view/simple_settings_page.dart';
import 'package:vaani/shared/extensions/enum.dart';

class ShakeDetectorSettingsPage extends HookConsumerWidget {
  const ShakeDetectorSettingsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appSettings = ref.watch(appSettingsProvider);
    final shakeDetectionSettings = appSettings.shakeDetectionSettings;
    final isShakeDetectionEnabled = shakeDetectionSettings.isEnabled;
    final selectedValueColor = isShakeDetectionEnabled
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).disabledColor;

    return SimpleSettingsPage(
      title: const Text('Shake Detector Settings'),
      sections: [
        SettingsSection(
          margin: const EdgeInsetsDirectional.symmetric(
            horizontal: 16.0,
            vertical: 8.0,
          ),
          tiles: [
            SettingsTile.switchTile(
              leading: shakeDetectionSettings.isEnabled
                  ? const Icon(Icons.vibration)
                  : const Icon(Icons.not_interested),
              title: const Text('Enable Shake Detection'),
              description: const Text(
                'Enable shake detection to do various actions',
              ),
              initialValue: shakeDetectionSettings.isEnabled,
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

        // Shake Detection Settings
        SettingsSection(
          tiles: [
            SettingsTile(
              enabled: isShakeDetectionEnabled,
              leading: const Icon(Icons.flag_circle),
              title: const Text('Shake Activation Threshold'),
              description: const Text(
                'The higher the threshold, the harder you need to shake',
              ),
              trailing: Text(
                '${shakeDetectionSettings.threshold} m/s²',
                style: TextStyle(
                  color: selectedValueColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: (context) async {
                final newThreshold = await showDialog<double>(
                  context: context,
                  builder: (context) => ShakeForceSelector(
                    initialValue: shakeDetectionSettings.threshold,
                  ),
                );

                if (newThreshold != null) {
                  ref.read(appSettingsProvider.notifier).update(
                        appSettings.copyWith.shakeDetectionSettings(
                          threshold: newThreshold,
                        ),
                      );
                }
              },
            ),

            // shake action
            SettingsTile(
              enabled: isShakeDetectionEnabled,
              leading: const Icon(Icons.directions_run),
              title: const Text('Shake Action'),
              description: const Text(
                'The action to perform when a shake is detected',
              ),
              trailing: Icon(
                shakeDetectionSettings.shakeAction.icon,
                color: selectedValueColor,
              ),
              onPressed: (context) async {
                final newShakeAction = await showDialog<ShakeAction>(
                  context: context,
                  builder: (context) => ShakeActionSelector(
                    initialValue: shakeDetectionSettings.shakeAction,
                  ),
                );

                if (newShakeAction != null) {
                  ref.read(appSettingsProvider.notifier).update(
                        appSettings.copyWith.shakeDetectionSettings(
                          shakeAction: newShakeAction,
                        ),
                      );
                }
              },
            ),

            // shake feedback
            SettingsTile(
              enabled: isShakeDetectionEnabled,
              leading: const Icon(Icons.feedback),
              title: const Text('Shake Feedback'),
              description: const Text(
                'The feedback to give when a shake is detected',
              ),
              trailing: shakeDetectionSettings.feedback.isEmpty
                  ? Icon(
                      Icons.not_interested,
                      color: Theme.of(context).disabledColor,
                    )
                  : Wrap(
                      spacing: 8.0,
                      children: shakeDetectionSettings.feedback.map(
                        (feedback) {
                          return Icon(
                            feedback.icon,
                            color: selectedValueColor,
                          );
                        },
                      ).toList(),
                    ),
              onPressed: (context) async {
                final newFeedback =
                    await showDialog<Set<ShakeDetectedFeedback>>(
                  context: context,
                  builder: (context) => ShakeFeedbackSelector(
                    initialValue: shakeDetectionSettings.feedback,
                  ),
                );

                if (newFeedback != null) {
                  ref.read(appSettingsProvider.notifier).update(
                        appSettings.copyWith.shakeDetectionSettings(
                          feedback: newFeedback,
                        ),
                      );
                }
              },
            ),
          ],
        ),
      ],
    );
  }
}

class ShakeFeedbackSelector extends HookConsumerWidget {
  const ShakeFeedbackSelector({
    super.key,
    this.initialValue = const {ShakeDetectedFeedback.vibrate},
  });

  final Set<ShakeDetectedFeedback> initialValue;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final feedback = useState(initialValue);
    return AlertDialog(
      title: const Text('Select Shake Feedback'),
      content: Wrap(
        spacing: 8.0,
        runSpacing: 8.0,
        children: ShakeDetectedFeedback.values
            .map(
              (feedbackType) => ChoiceChip(
                avatar: Icon(feedbackType.icon),
                label: Text(feedbackType.pascalCase),
                tooltip: feedbackType.description,
                onSelected: (val) {
                  if (feedback.value.contains(feedbackType)) {
                    feedback.value = feedback.value
                        .where((element) => element != feedbackType)
                        .toSet();
                  } else {
                    feedback.value = {...feedback.value, feedbackType};
                  }
                },
                selected: feedback.value.contains(feedbackType),
              ),
            )
            .toList(),
      ),
      actions: [
        const CancelButton(),
        OkButton(
          onPressed: () {
            Navigator.of(context).pop(feedback.value);
          },
        ),
      ],
    );
  }
}

class ShakeActionSelector extends HookConsumerWidget {
  const ShakeActionSelector({
    super.key,
    this.initialValue = ShakeAction.resetSleepTimer,
  });

  final ShakeAction initialValue;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shakeAction = useState(initialValue);
    return AlertDialog(
      title: const Text('Select Shake Action'),
      content: Wrap(
        spacing: 8.0,
        runSpacing: 8.0,
        children: ShakeAction.values
            .map(
              // chips with radio buttons as one of the options can be selected
              (action) => ChoiceChip(
                avatar: Icon(action.icon),
                label: Text(action.pascalCase),
                onSelected: (val) {
                  shakeAction.value = action;
                },
                selected: shakeAction.value == action,
              ),
            )
            .toList(),
      ),
      actions: [
        const CancelButton(),
        OkButton(
          onPressed: () {
            Navigator.of(context).pop(shakeAction.value);
          },
        ),
      ],
    );
  }
}

class ShakeForceSelector extends HookConsumerWidget {
  const ShakeForceSelector({
    super.key,
    this.initialValue = 6,
  });

  final double initialValue;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shakeForce = useState(initialValue);
    final controller = useTextEditingController(text: initialValue.toString());
    return AlertDialog(
      title: const Text('Select Shake Activation Threshold'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            autofocus: true,
            controller: controller,
            onChanged: (value) {
              final newThreshold = double.tryParse(value);
              if (newThreshold != null) {
                shakeForce.value = newThreshold;
              }
            },
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              // clear button
              suffix: IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  controller.clear();
                  shakeForce.value = 0;
                },
              ),
              helper: const Text(
                'Enter a number to set the threshold in m/s²',
              ),
            ),
          ),
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: ShakeForce.values
                .map(
                  (force) => ChoiceChip(
                    label: Text(force.pascalCase),
                    onSelected: (val) {
                      controller.text = force.threshold.toString();
                      shakeForce.value = force.threshold;
                    },
                    selected: shakeForce.value == force.threshold,
                  ),
                )
                .toList(),
          ),
        ],
      ),
      actions: [
        const CancelButton(),
        OkButton(
          onPressed: () {
            Navigator.of(context).pop(shakeForce.value);
          },
        ),
      ],
    );
  }
}

enum ShakeForce {
  whisper(0.5),
  low(2.5),
  medium(5),
  high(7.5),
  storm(10),
  hurricane(15),
  earthquake(20),
  meteorShower(30),
  supernova(40),
  blackHole(50);

  const ShakeForce(this.threshold);

  final double threshold;
}

extension ShakeActionIcon on ShakeAction {
  IconData? get icon {
    switch (this) {
      case ShakeAction.none:
        return Icons.not_interested;
      case ShakeAction.resetSleepTimer:
        return Icons.timer;
      case ShakeAction.playPause:
        return Icons.play_arrow;
      // case ShakeAction.nextChapter:
      //   return Icons.skip_next;
      // case ShakeAction.previousChapter:
      //   return Icons.skip_previous;
      // case ShakeAction.volumeUp:
      //   return Icons.volume_up;
      // case ShakeAction.volumeDown:
      //   return Icons.volume_down;
      case ShakeAction.fastForward:
        return Icons.fast_forward;
      case ShakeAction.rewind:
        return Icons.fast_rewind;
      default:
        return Icons.question_mark;
    }
  }
}

extension on ShakeDetectedFeedback {
  IconData? get icon {
    switch (this) {
      case ShakeDetectedFeedback.vibrate:
        return Icons.vibration;
      case ShakeDetectedFeedback.beep:
        return Icons.volume_up;
      default:
        return Icons.question_mark;
    }
  }

  String get description {
    switch (this) {
      case ShakeDetectedFeedback.vibrate:
        return 'Vibrate the device';
      case ShakeDetectedFeedback.beep:
        return 'Play a beep sound';
      default:
        return 'Unknown';
    }
  }
}
