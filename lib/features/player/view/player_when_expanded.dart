import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:list_wheel_scroll_view_nls/list_wheel_scroll_view_nls.dart';
import 'package:shelfsdk/audiobookshelf_api.dart';
import 'package:whispering_pages/constants/sizes.dart';
import 'package:whispering_pages/features/player/providers/audiobook_player.dart';
import 'package:whispering_pages/features/player/providers/currently_playing_provider.dart';
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
        // sized box for system status bar; not needed as not full screen
        // SizedBox(
        //   height: MediaQuery.of(context).padding.top * earlyPercentage,
        // ),

        // a row with a down arrow to minimize the player, a pill shaped container to drag the player, and a cast button
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
    final notifier = ref.watch(audiobookPlayerProvider.notifier);
    return TextButton(
      child: Text('${player.speed}x'),
      onPressed: () {
        showModalBottomSheet(
          context: context,
          barrierLabel: 'Select Speed',
          constraints: const BoxConstraints(
            maxHeight: 225,
          ),
          builder: (context) {
            return SpeedSelector(
              onSpeedSelected: (speed) {
                notifier.setSpeed(speed);
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
    final speedState = useState(currentSpeed);

    // hook the onSpeedSelected function to the state
    useEffect(
      () {
        onSpeedSelected(speedState.value);
        return null;
      },
      [speedState.value],
    );

    // the speed options
    const minSpeed = 0.1;
    const maxSpeed = 4.0;
    const speedIncrement = 0.05;
    final availableSpeeds = ((maxSpeed - minSpeed) / speedIncrement).ceil();
    final availableSpeedsList = List.generate(
      availableSpeeds,
      (index) {
        // need to round to 2 decimal place to avoid floating point errors
        return double.parse(
          (minSpeed + index * speedIncrement).toStringAsFixed(2),
        );
      },
    );

    final scrollController = FixedExtentScrollController(
      initialItem: availableSpeedsList.indexOf(currentSpeed),
    );
    const double itemExtent = 25;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  'Playback Speed: ${speedState.value}x',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ),
          ),
          Flexible(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // a minus button to decrease the speed
                IconButton.filledTonal(
                  icon: const Icon(Icons.remove),
                  onPressed: () {
                    // animate to index - 1
                    final index = availableSpeedsList.indexOf(speedState.value);
                    if (index > 0) {
                      scrollController.animateToItem(
                        index - 1,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                ),
                Expanded(
                  child: ListWheelScrollViewX(
                    controller: scrollController,
                    scrollDirection: Axis.horizontal,
                    itemExtent: itemExtent,
                    diameterRatio: 1.5, squeeze: 1.2,
                    // useMagnifier: true,
                    // magnification: 1.5,
                    physics: const FixedExtentScrollPhysics(),
                    children: availableSpeedsList
                        .map(
                          (speed) => Column(
                            children: [
                              // a vertical line
                              Container(
                                height: itemExtent * 2,
                                // thick if multiple of 1, thin if multiple of 0.5 and transparent if multiple of 0.05
                                width: speed % 0.5 == 0
                                    ? 3
                                    : speed % 0.25 == 0
                                        ? 2
                                        : 0.5,
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                              ),
                              // the speed text but only at .5 increments of speed
                              if (speed % 0.25 == 0)
                                Text(
                                  speed.toString(),
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground,
                                  ),
                                ),
                            ],
                          ),
                        )
                        .toList(),
                    onSelectedItemChanged: (index) {
                      speedState.value = availableSpeedsList[index];
                      // onSpeedSelected(availableSpeedsList[index]);
                      // call after 500ms to avoid the scrollview from scrolling to the selected speed
                      // Future.delayed(
                      //   const Duration(milliseconds: 100),
                      //   () => onSpeedSelected(availableSpeedsList[index]),
                      // );
                    },
                  ),
                ),
                // a plus button to increase the speed
                IconButton.filledTonal(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    // animate to index + 1
                    final index = availableSpeedsList.indexOf(speedState.value);
                    if (index < availableSpeedsList.length - 1) {
                      scrollController.animateToItem(
                        index + 1,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: speeds
                .map(
                  (speed) => Flexible(
                    // the text button should be highlighted if the speed is selected
                    child: TextButton(
                      style: speed == speedState.value
                          ? TextButton.styleFrom(
                              backgroundColor: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                              foregroundColor: Theme.of(context)
                                  .colorScheme
                                  .onPrimaryContainer,
                            )
                          : null,
                      onPressed: () async {
                        // animate the wheel to the selected speed
                        var index = availableSpeedsList.indexOf(speed);
                        // if the speed is not in the list
                        if (index == -1) {
                          // find the nearest speed
                          final nearestSpeed = availableSpeedsList.firstWhere(
                            (element) => element > speed,
                            orElse: () => availableSpeedsList.last,
                          );
                          index = availableSpeedsList.indexOf(nearestSpeed);
                        }
                        await scrollController.animateToItem(
                          index,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );

                        // call the onSpeedSelected function
                        speedState.value = speed;
                      },
                      child: Text('$speed'),
                    ),
                  ),
                )
                .toList(),
          ),
          const SizedBox(
            height: 8,
          ),
        ],
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
