import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:shelfsdk/audiobookshelf_api.dart';
import 'package:whispering_pages/constants/sizes.dart';
import 'package:whispering_pages/features/player/providers/audiobook_player.dart';
import 'package:whispering_pages/features/player/providers/currently_playing_provider.dart';
import 'package:whispering_pages/features/player/providers/player_form.dart';
import 'package:whispering_pages/features/player/view/audiobook_player.dart';
import 'package:whispering_pages/settings/app_settings_provider.dart';
import 'package:whispering_pages/shared/extensions/inverse_lerp.dart';

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
    final currentBook = ref.watch(currentlyPlayingBookProvider);
    final currentChapter = ref.watch(currentPlayingChapterProvider);
    final currentBookMetadata = ref.watch(currentBookMetadataProvider);

    return Column(
      children: [
        // sized box for system status bar
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
                      ref.read(miniplayerControllerProvider).animateToHeight(
                            state: PanelState.MIN,
                          );
                    },
                  ),

                  // the pill shaped container
                  // SizedBox(
                  //   height: 6,
                  //   width: 32,
                  //   child: Container(
                  //     decoration: BoxDecoration(
                  //       color: Theme.of(context).colorScheme.secondary,
                  //       borderRadius: BorderRadius.circular(32),
                  //     ),
                  //   ),
                  // ),
                  // the cast button
                  IconButton(
                    icon: const Icon(Icons.cast),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ),
        // the image
        Padding(
          padding: EdgeInsets.only(top: 8.0 * earlyPercentage),
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
                        .onBackground
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
                IconButton(
                  icon: const Icon(Icons.timer),
                  onPressed: () {},
                ),
                // chapter list
                IconButton(
                  icon: const Icon(Icons.menu_book_rounded),
                  onPressed: () {},
                ),
                // settings
                IconButton(
                  icon: const Icon(Icons.more_horiz),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class PlayerSpeedAdjustButton extends HookConsumerWidget {
  const PlayerSpeedAdjustButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final player = ref.watch(audiobookPlayerProvider);
    return TextButton(
      child: Text('${player.speed}x'),
      // icon: const Icon(Icons.speed),
      onPressed: () {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return SpeedSelector(
              onSpeedSelected: (speed) {
                player.setSpeed(speed);
                Navigator.of(context).pop();
              },
            );
          },
        );
      },
    );
  }
}

class SpeedSelector extends HookConsumerWidget {
  const SpeedSelector({
    super.key,
    required this.onSpeedSelected,
  });

  final void Function(double speed) onSpeedSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appSettings = ref.watch(appSettingsProvider);
    final speeds = appSettings.playerSettings.speedOptions;
    final currentSpeed = ref.watch(audiobookPlayerProvider).speed;
    return SizedBox(
      child: ListView.builder(
        itemCount: speeds.length,
        itemBuilder: (context, index) {
          final speed = speeds[index];
          return ListTile(
            title: Text(speed.toString()),
            onTap: () {
              onSpeedSelected(speed);
            },
            trailing: currentSpeed == speed ? const Icon(Icons.check) : null,
          );
        },
      ),
    );
  }
}

class AudiobookPlayerSeekButton extends HookConsumerWidget {
  const AudiobookPlayerSeekButton({
    super.key,
    required this.isForward,
  });

  /// if true, the button seeks forward, else it seeks backwards
  final bool isForward;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final player = ref.watch(audiobookPlayerProvider);
    return IconButton(
      icon: Icon(
        isForward ? Icons.forward_30 : Icons.replay_30,
        size: AppElementSizes.iconSizeSmall,
      ),
      onPressed: () {
        if (isForward) {
          player.seek(player.positionInBook + const Duration(seconds: 30));
        } else {
          player.seek(player.positionInBook - const Duration(seconds: 30));
        }
      },
    );
  }
}

class AudiobookPlayerSeekChapterButton extends HookConsumerWidget {
  const AudiobookPlayerSeekChapterButton({
    super.key,
    required this.isForward,
  });

  /// if true, the button seeks forward, else it seeks backwards
  final bool isForward;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final player = ref.watch(audiobookPlayerProvider);

    // add a small offset so the display does not show the previous chapter for a split second
    const offset = Duration(milliseconds: 10);

    /// time into the current chapter to determine if we should go to the previous chapter or the start of the current chapter
    const doNotSeekBackIfLessThan = Duration(seconds: 5);

    /// seek forward to the next chapter
    void seekForward() {
      final index = player.book!.chapters.indexOf(player.currentChapter!);
      if (index < player.book!.chapters.length - 1) {
        player.seek(
          player.book!.chapters[index + 1].start + offset,
        );
      } else {
        player.seek(player.currentChapter!.end);
      }
    }

    /// seek backward to the previous chapter or the start of the current chapter
    void seekBackward() {
      final currentPlayingChapterIndex =
          player.book!.chapters.indexOf(player.currentChapter!);
      final chapterPosition =
          player.positionInBook - player.currentChapter!.start;
      BookChapter chapterToSeekTo;
      // if player position is less than 5 seconds into the chapter, go to the previous chapter
      if (chapterPosition < doNotSeekBackIfLessThan &&
          currentPlayingChapterIndex > 0) {
        chapterToSeekTo = player.book!.chapters[currentPlayingChapterIndex - 1];
      } else {
        chapterToSeekTo = player.currentChapter!;
      }
      player.seek(
        chapterToSeekTo.start + offset,
      );
    }

    return IconButton(
      icon: Icon(
        isForward ? Icons.skip_next : Icons.skip_previous,
        size: AppElementSizes.iconSizeSmall,
      ),
      onPressed: () {
        if (player.book == null) {
          return;
        }
        // if chapter does not exist, go to the start or end of the book
        if (player.currentChapter == null) {
          player.seek(isForward ? player.book!.duration : Duration.zero);
          return;
        }
        if (isForward) {
          seekForward();
        } else {
          seekBackward();
        }
      },
    );
  }
}
