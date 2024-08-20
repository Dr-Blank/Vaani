import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:whispering_pages/constants/sizes.dart';
import 'package:whispering_pages/features/player/providers/currently_playing_provider.dart';
import 'package:whispering_pages/features/player/providers/player_form.dart';
import 'package:whispering_pages/features/player/view/audiobook_player.dart';
import 'package:whispering_pages/features/sleep_timer/core/sleep_timer.dart';
import 'package:whispering_pages/features/sleep_timer/providers/sleep_timer_provider.dart'
    show sleepTimerProvider;
import 'package:whispering_pages/settings/app_settings_provider.dart';
import 'package:whispering_pages/shared/extensions/inverse_lerp.dart';
import 'package:whispering_pages/shared/widgets/not_implemented.dart';

import 'widgets/audiobook_player_seek_button.dart';
import 'widgets/audiobook_player_seek_chapter_button.dart';
import 'widgets/chapter_selection_button.dart';
import 'widgets/player_speed_adjust_button.dart';

var pendingPlayerModals = 0;

class PlayerWhenExpanded extends HookConsumerWidget {
  const PlayerWhenExpanded({
    super.key,
    required this.imageSize,
    required this.img,
    required this.percentageExpandedPlayer,
    required this.playPauseController,
  });

  /// padding values control the position of the image
  final double imageSize;
  final Widget img;
  final double percentageExpandedPlayer;
  final AnimationController playPauseController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// all the properties that help in building the widget are calculated from the [percentageExpandedPlayer]
    /// however, some properties need to start later than 0% and end before 100%
    const lateStart = 0.4;
    const earlyEnd = 1;
    final earlyPercentage = percentageExpandedPlayer
        .inverseLerp(
          lateStart,
          earlyEnd,
        )
        .clamp(0.0, 1.0);
    final currentChapter = ref.watch(currentPlayingChapterProvider);
    final currentBookMetadata = ref.watch(currentBookMetadataProvider);

    return Column(
      children: [
        // sized box for system status bar; not needed as not full screen
        SizedBox(
          height: MediaQuery.of(context).padding.top * earlyPercentage,
        ),

        // a row with a down arrow to minimize the player, a pill shaped container to drag the player, and a cast button
        ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: 100 * earlyPercentage,
          ),
          child: Opacity(
            opacity: earlyPercentage,
            child: Padding(
              padding: EdgeInsets.only(top: 8.0 * earlyPercentage),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // the down arrow
                  IconButton(
                    iconSize: 30,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    onPressed: () {
                      // minimize the player
                      audioBookMiniplayerController.animateToHeight(
                        state: PanelState.MIN,
                      );
                    },
                  ),

                  // the cast button
                  IconButton(
                    icon: const Icon(Icons.cast),
                    onPressed: () {
                      showNotImplementedToast(context);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),

        // the image
        Padding(
          padding: EdgeInsets.only(
            top: AppElementSizes.paddingLarge * earlyPercentage,
          ),
          child: Align(
            alignment: Alignment.center,
            // add a shadow to the image elevation hovering effect
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    blurRadius: 32 * earlyPercentage,
                    spreadRadius: 8 * earlyPercentage,
                    // offset: Offset(0, 16 * earlyPercentage),
                  ),
                ],
              ),
              child: SizedBox(
                height: imageSize,
                child: InkWell(
                  onTap: () {},
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      AppElementSizes.borderRadiusRegular * earlyPercentage,
                    ),
                    child: img,
                  ),
                ),
              ),
            ),
          ),
        ),

        // the chapter title
        Opacity(
          opacity: earlyPercentage,
          child: Padding(
            padding: EdgeInsets.only(
              top: AppElementSizes.paddingRegular * 4 * earlyPercentage,
              // horizontal: 16.0,
            ),
            // child: SizedBox(
            // same as the image width
            // width: imageSize,
            child: currentChapter == null
                ? const SizedBox()
                : Text(
                    currentChapter.title,
                    style: Theme.of(context).textTheme.titleLarge,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
            // ),
          ),
        ),

        // the book name and author
        Opacity(
          opacity: earlyPercentage,
          child: Padding(
            padding: EdgeInsets.only(
              bottom: AppElementSizes.paddingRegular * earlyPercentage,
              // horizontal: 16.0,
            ),
            // child: SizedBox(
            // same as the image width
            // width: imageSize,
            child: Text(
              [
                currentBookMetadata?.title ?? '',
                currentBookMetadata?.authorName ?? '',
              ].join(' - '),
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(0.7),
                  ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            // ),
          ),
        ),

        const Spacer(),
        // the progress bar
        Opacity(
          opacity: earlyPercentage,
          child: SizedBox(
            width: imageSize,
            child: Padding(
              padding: EdgeInsets.only(
                top: AppElementSizes.paddingRegular * earlyPercentage,
                left: AppElementSizes.paddingRegular * earlyPercentage,
                right: AppElementSizes.paddingRegular * earlyPercentage,
              ),
              child: const AudiobookChapterProgressBar(),
            ),
          ),
        ),
        const Spacer(),

        // the chapter skip buttons, seek 30 seconds back and forward, and play/pause button
        Opacity(
          opacity: earlyPercentage,
          child: SizedBox(
            width: imageSize,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // previous chapter
                const AudiobookPlayerSeekChapterButton(isForward: false),
                // buttonSkipBackwards
                const AudiobookPlayerSeekButton(isForward: false),
                AudiobookPlayerPlayPauseButton(
                  playPauseController: playPauseController,
                ),
                // buttonSkipForwards
                const AudiobookPlayerSeekButton(isForward: true),
                // next chapter
                const AudiobookPlayerSeekChapterButton(isForward: true),
              ],
            ),
          ),
        ),
        const Spacer(),

        // speed control, sleep timer, chapter list, and settings
        Opacity(
          opacity: earlyPercentage,
          child: Padding(
            padding: EdgeInsets.only(
              bottom: AppElementSizes.paddingRegular * 4 * earlyPercentage,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // speed control
                const PlayerSpeedAdjustButton(),
                // sleep timer
                const SleepTimerButton(),
                // chapter list
                const ChapterSelectionButton(),
                // settings
                IconButton(
                  icon: const Icon(Icons.more_horiz),
                  onPressed: () {
                    // show toast
                    showNotImplementedToast(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class SleepTimerButton extends HookConsumerWidget {
  const SleepTimerButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sleepTimer = ref.watch(sleepTimerProvider);
    // if sleep timer is not active, show the button with the sleep timer icon
    // if the sleep timer is active, show the remaining time in a pill shaped container
    return Tooltip(
      message: 'Sleep Timer',
      child: InkWell(
        onTap: () async {
          pendingPlayerModals++;
          // show the sleep timer dialog
          final resultingDuration = await showDurationPicker(
            context: context,
            initialTime: ref
                .watch(appSettingsProvider)
                .playerSettings
                .sleepTimerSettings
                .defaultDuration,
          );
          pendingPlayerModals--;
          if (resultingDuration != null) {
            // if 0 is selected, cancel the timer
            if (resultingDuration.inSeconds == 0) {
              ref.read(sleepTimerProvider.notifier).cancelTimer();
            } else {
              ref.read(sleepTimerProvider.notifier).setTimer(resultingDuration);
            }
          }
        },
        child: sleepTimer == null
            ? Icon(
                Icons.timer_rounded,
                color: Theme.of(context).colorScheme.onSurface,
              )
            : RemainingSleepTimeDisplay(
                timer: sleepTimer,
              ),
      ),
    );
  }
}

class SleepTimerDialog extends HookConsumerWidget {
  const SleepTimerDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sleepTimer = ref.watch(sleepTimerProvider);
    final sleepTimerSettings =
        ref.watch(appSettingsProvider).playerSettings.sleepTimerSettings;
    final timerDurationController = useTextEditingController(
      text: sleepTimerSettings.defaultDuration.inMinutes.toString(),
    );

    return AlertDialog(
      title: const Text('Sleep Timer'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Set the duration for the sleep timer'),
          TextField(
            controller: timerDurationController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Duration in minutes',
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            // sleepTimer.setTimer(
            //   Duration(
            //     minutes: int.tryParse(timerDurationController.text) ?? 0,
            //   ),
            // );
            Navigator.of(context).pop();
          },
          child: const Text('Set Timer'),
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
            ? timer.duration.formatSingleLargestUnit()
            : remainingTime?.formatSingleLargestUnit() ?? '',
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
      ),
    );
  }
}

extension DurationFormat on Duration {
  /// will return a number followed by h, m, or s depending on the duration
  /// only the largest unit will be shown
  String formatSingleLargestUnit() {
    if (inHours > 0) {
      return '${inHours}h';
    } else if (inMinutes > 0) {
      return '${inMinutes}m';
    } else {
      return '${inSeconds}s';
    }
  }
}
