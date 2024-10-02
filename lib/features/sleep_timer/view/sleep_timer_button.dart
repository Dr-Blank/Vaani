import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:list_wheel_scroll_view_nls/list_wheel_scroll_view_nls.dart';
import 'package:vaani/features/player/view/player_when_expanded.dart';
import 'package:vaani/features/player/view/widgets/speed_selector.dart';
import 'package:vaani/features/sleep_timer/core/sleep_timer.dart';
import 'package:vaani/features/sleep_timer/providers/sleep_timer_provider.dart'
    show sleepTimerProvider;
import 'package:vaani/main.dart';
import 'package:vaani/settings/app_settings_provider.dart';
import 'package:vaani/shared/extensions/duration_format.dart';
import 'package:vaani/shared/hooks.dart';

class SleepTimerButton extends HookConsumerWidget {
  const SleepTimerButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sleepTimer = ref.watch(sleepTimerProvider);
    final durationState = useState(sleepTimer?.duration);

    // if sleep timer is not active, show the button with the sleep timer icon
    // if the sleep timer is active, show the remaining time in a pill shaped container
    return Tooltip(
      message: 'Sleep Timer',
      child: InkWell(
        onTap: () async {
          appLogger.fine('Sleep Timer button pressed');
          pendingPlayerModals++;
          // show the sleep timer dialog
          await showModalBottomSheet<Duration?>(
            context: context,
            barrierLabel: 'Sleep Timer',
            builder: (context) {
              return SleepTimerBottomSheet(
                onDurationSelected: (duration) {
                  durationState.value = duration;
                  // ref
                  //     .read(sleepTimerProvider.notifier)
                  //     .setTimer(duration, notifyListeners: false);
                },
              );
            },
          );
          pendingPlayerModals--;
          ref.read(sleepTimerProvider.notifier).setTimer(durationState.value);
          appLogger
              .fine('Sleep Timer dialog closed with ${durationState.value}');
        },
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: sleepTimer == null
              ? Icon(
                  Icons.timer_rounded,
                  color: Theme.of(context).colorScheme.onSurface,
                )
              : RemainingSleepTimeDisplay(
                  timer: sleepTimer,
                ),
        ),
      ),
    );
  }
}

class SleepTimerBottomSheet extends HookConsumerWidget {
  const SleepTimerBottomSheet({
    super.key,
    this.onDurationSelected,
  });

  final void Function(Duration?)? onDurationSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sleepTimer = ref.watch(sleepTimerProvider);
    final sleepTimerSettings = ref.watch(sleepTimerSettingsProvider);

    final durationOptions = sleepTimerSettings.presetDurations;
    final minDuration = Duration.zero;
    final maxDuration = <Duration>[
      ...durationOptions,
      sleepTimerSettings.maxDuration,
    ].reduce((a, b) => a > b ? a : b);
    final incrementStep = Duration(minutes: 1);
    final allPossibleDurations = [
      for (var i = minDuration; i <= maxDuration; i += incrementStep) i,
    ];

    final scrollController = useFixedExtentScrollController(
      initialItem:
          allPossibleDurations.indexOf(sleepTimer?.duration ?? minDuration),
    );

    final durationState = useState<Duration>(
      sleepTimer?.duration ?? minDuration,
    );

    // useEffect to rebuild the sleep timer when the duration changes
    useEffect(
      () {
        onDurationSelected?.call(durationState.value);
        return null;
      },
      [durationState.value],
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // the title
        Padding(
          padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
          child: Center(
            child: Text(
              'Sleep Timer',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
        ),

        // a inverted triangle to indicate the speed selector
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Icon(
            Icons.arrow_drop_down,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),

        // the speed selector
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0, right: 8.0, left: 8.0),
          child: SizedBox(
            height: 80,
            child: SleepTimerWheel(
              durationState: durationState,
              availableDurations: allPossibleDurations,
              scrollController: scrollController,
            ),
          ),
        ),

        // a cancel button to cancel the sleep timer
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: TextButton.icon(
            onPressed: () {
              ref.read(sleepTimerProvider.notifier).cancelTimer();
              onDurationSelected?.call(null);
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.cancel),
            label: const Text('Cancel Sleep Timer'),
          ),
        ),

        // the speed buttons
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Wrap(
            spacing: 8.0,
            alignment: WrapAlignment.center,
            runAlignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: durationOptions
                .map(
                  (timerDuration) => TextButton(
                    style: timerDuration == durationState.value
                        ? TextButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.primaryContainer,
                            foregroundColor: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
                          )
                        // border if not selected
                        : TextButton.styleFrom(
                            side: BorderSide(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                            ),
                          ),
                    onPressed: () async {
                      // animate the wheel to the selected speed
                      var index = allPossibleDurations.indexOf(timerDuration);
                      // if the speed is not in the list
                      if (index == -1) {
                        // find the nearest speed
                        final nearestDuration = allPossibleDurations.firstWhere(
                          (element) => element > timerDuration,
                          orElse: () => allPossibleDurations.last,
                        );
                        index = allPossibleDurations.indexOf(nearestDuration);
                      }
                      await scrollController.animateToItem(
                        index,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: Text(timerDuration.smartBinaryFormat),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}

class RemainingSleepTimeDisplay extends HookConsumerWidget {
  const RemainingSleepTimeDisplay({
    super.key,
    required this.timer,
  });

  final SleepTimer timer;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final remainingTime = useStream(timer.remainingTimeStream).data;
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      child: Text(
        timer.timer == null
            ? timer.duration.smartBinaryFormat
            : remainingTime?.smartBinaryFormat ?? '',
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
      ),
    );
  }
}

class SleepTimerWheel extends StatelessWidget {
  const SleepTimerWheel({
    super.key,
    required this.availableDurations,
    required this.scrollController,
    required this.durationState,
    this.showIncrementButtons = true,
  });

  final List<Duration> availableDurations;
  final ValueNotifier<Duration?> durationState;
  final FixedExtentScrollController scrollController;
  final bool showIncrementButtons;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // a minus button to decrease the speed
        if (showIncrementButtons)
          IconButton.filledTonal(
            icon: const Icon(Icons.remove),
            onPressed: () {
              // animate to index - 1
              final index = availableDurations
                  .indexOf(durationState.value ?? Duration.zero);
              if (index > 0) {
                scrollController.animateToItem(
                  index - 1,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              }
            },
          ),
        // the speed selector wheel
        Flexible(
          child: ListWheelScrollViewX(
            controller: scrollController,
            scrollDirection: Axis.horizontal,
            itemExtent: itemExtent,
            diameterRatio: 1.5, squeeze: 1.2,
            // useMagnifier: true,
            // magnification: 1.5,
            physics: const FixedExtentScrollPhysics(),
            children: availableDurations
                .map(
                  (duration) => DurationLine(duration: duration),
                )
                .toList(),
            onSelectedItemChanged: (index) {
              durationState.value = availableDurations[index];
            },
          ),
        ),

        if (showIncrementButtons)
          // a plus button to increase the speed
          IconButton.filledTonal(
            icon: const Icon(Icons.add),
            onPressed: () {
              // animate to index + 1
              final index = availableDurations
                  .indexOf(durationState.value ?? Duration.zero);
              if (index < availableDurations.length - 1) {
                scrollController.animateToItem(
                  index + 1,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              }
            },
          ),
      ],
    );
  }
}

class DurationLine extends StatelessWidget {
  const DurationLine({
    super.key,
    required this.duration,
  });

  final Duration duration;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // a vertical line
        Expanded(
          child: Container(
            // thick if multiple of 1, thin if multiple of 0.5 and transparent if multiple of 0.05
            width: duration.inMinutes % 5 == 0
                ? 3
                : duration.inMinutes % 2.5 == 0
                    ? 2
                    : 0.5,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        Opacity(
          opacity: duration.inMinutes % 2.5 == 0 ? 1 : 0,
          child: Text(
            '${duration.inMinutes}m',
            style: TextStyle(
              fontSize: Theme.of(context).textTheme.labelSmall?.fontSize,
            ),
          ),
        ),
      ],
    );
  }
}
