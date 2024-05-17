import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:whispering_pages/api/image_provider.dart';
import 'package:whispering_pages/api/library_item_provider.dart';
import 'package:whispering_pages/features/player/providers/audiobook_player.dart';
import 'package:whispering_pages/features/player/providers/currently_playing_provider.dart';
import 'package:whispering_pages/features/player/providers/player_form.dart';
import 'package:whispering_pages/shared/widgets/shelves/book_shelf.dart';
import 'package:whispering_pages/theme/theme_from_cover_provider.dart';

import 'player_when_expanded.dart';
import 'player_when_minimized.dart';

double valueFromPercentageInRange({
  required final double min,
  max,
  percentage,
}) {
  return percentage * (max - min) + min;
}

double percentageFromValueInRange({required final double min, max, value}) {
  return (value - min) / (max - min);
}



class AudiobookPlayer extends HookConsumerWidget {
  const AudiobookPlayer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentBook = ref.watch(currentlyPlayingBookProvider);
    if (currentBook == null) {
      return const SizedBox.shrink();
    }
    final itemBeingPlayed =
        ref.watch(libraryItemProvider(currentBook.libraryItemId));
    final player = ref.watch(audiobookPlayerProvider);
    final imageOfItemBeingPlayed = itemBeingPlayed.valueOrNull != null
        ? ref.watch(
            coverImageProvider(itemBeingPlayed.valueOrNull!),
          )
        : null;
    final imgWidget = imageOfItemBeingPlayed?.valueOrNull != null
        ? Image.memory(
            imageOfItemBeingPlayed!.valueOrNull!,
            fit: BoxFit.cover,
          )
        : const BookCoverSkeleton();

    final playPauseController = useAnimationController(
      duration: const Duration(milliseconds: 200),
      initialValue: 1,
    );

    // add controller to the player state listener
    player.playerStateStream.listen((state) {
      if (state.playing) {
        playPauseController.forward();
      } else {
        playPauseController.reverse();
      }
    });

    final playPauseButton = AudiobookPlayerPlayPauseButton(
      playPauseController: playPauseController,
    );

    const progressBar = AudiobookTotalProgressBar();

    // theme from image
    final imageTheme = ref.watch(
      themeOfLibraryItemProvider(
        itemBeingPlayed.valueOrNull,
        brightness: Theme.of(context).brightness,
      ),
    );

    // max height of the player is the height of the screen
    final playerMaxHeight = MediaQuery.of(context).size.height;


    return Theme(
      data: ThemeData(
        colorScheme: imageTheme.valueOrNull ?? Theme.of(context).colorScheme,
      ),
      child: Miniplayer(
        valueNotifier: ref.watch(playerExpandProgressNotifierProvider),
        minHeight: playerMinHeight,
        maxHeight: playerMaxHeight,
        controller: ref.watch(miniplayerControllerProvider),
        elevation: 4,
        onDismissed: () {
          player.setSourceAudioBook(null);
        },
        curve: Curves.easeOut,
        builder: (height, percentage) {
          // return SafeArea(
          //   child: Text(
          //     'percentage: ${percentage.toStringAsFixed(2)}, height: ${height.toStringAsFixed(2)}',
          //   ),
          // );
          final bool isFormMiniplayer =
              percentage < miniplayerPercentageDeclaration;
          final double availWidth = MediaQuery.of(context).size.width;
          final maxImgSize = availWidth * 0.4;
      
          final bookTitle = Text(player.book?.metadata.title ?? '');
      
          //Declare additional widgets (eg. SkipButton) and variables
          if (!isFormMiniplayer) {
            var percentageExpandedPlayer = percentageFromValueInRange(
              min: playerMaxHeight * miniplayerPercentageDeclaration +
                  playerMinHeight,
              max: playerMaxHeight,
              value: height,
            );
            if (percentageExpandedPlayer < 0) percentageExpandedPlayer = 0;
            final paddingVertical = valueFromPercentageInRange(
              min: 0,
              max: 16,
              percentage: percentageExpandedPlayer,
            );
            final double heightWithoutPadding = height - paddingVertical * 2;
            final double imageSize = heightWithoutPadding > maxImgSize
                ? maxImgSize
                : heightWithoutPadding;
            final paddingLeft = valueFromPercentageInRange(
                  min: 0,
                  max: availWidth - imageSize,
                  percentage: percentageExpandedPlayer,
                ) /
                2;
      
            const buttonSkipForward = IconButton(
              icon: Icon(Icons.forward_30),
              iconSize: 33,
              onPressed: onTap,
            );
            const buttonSkipBackwards = IconButton(
              icon: Icon(Icons.replay_10),
              iconSize: 33,
              onPressed: onTap,
            );
            return PlayerWhenExpanded(
              imgPaddingLeft: paddingLeft,
              imgPaddingVertical: paddingVertical,
              imageSize: imageSize,
              img: imgWidget,
              percentageExpandedPlayer: percentageExpandedPlayer,
              text: bookTitle,
              buttonSkipBackwards: buttonSkipBackwards,
              playPauseButton: playPauseButton,
              buttonSkipForward: buttonSkipForward,
              progressIndicator: progressBar,
            );
          }
      
          //Miniplayer
          final percentageMiniplayer = percentageFromValueInRange(
            min: playerMinHeight,
            max: playerMaxHeight * miniplayerPercentageDeclaration +
                playerMinHeight,
            value: height,
          );
      
          final elementOpacity = 1 - 1 * percentageMiniplayer;
      
          return PlayerWhenMinimized(
            maxImgSize: maxImgSize,
            imgWidget: imgWidget,
            elementOpacity: elementOpacity,
            playPauseButton: playPauseButton,
            progressIndicator: progressBar,
          );
        },
      ),
    );
  }
}

class AudiobookPlayerPlayPauseButton extends HookConsumerWidget {
  const AudiobookPlayerPlayPauseButton({
    super.key,
    required this.playPauseController,
  });

  final AnimationController playPauseController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final player = ref.watch(audiobookPlayerProvider);
    return switch (player.processingState) {
      ProcessingState.loading ||
      ProcessingState.buffering =>
        const CircularProgressIndicator(),
      ProcessingState.completed => IconButton(
          onPressed: () async {
            await player.seek(const Duration(seconds: 0));
            await player.play();
          },
          icon: const Icon(Icons.replay),
        ),
      ProcessingState.ready => IconButton(
          onPressed: () async {
            await player.togglePlayPause();
          },
          icon: AnimatedIcon(
            icon: AnimatedIcons.play_pause,
            progress: playPauseController,
            size: 50,
          ),
        ),
      ProcessingState.idle => const SizedBox.shrink(),
    };
  }
}

/// A progress bar that shows the total progress of the audiobook
///
/// for chapter progress, use [AudiobookChapterProgressBar]
class AudiobookTotalProgressBar extends HookConsumerWidget {
  const AudiobookTotalProgressBar({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final player = ref.watch(audiobookPlayerProvider);
    // final playerState = useState(player.processingState);
    // add a listener to the player state
    // player.processingStateStream.listen((state) {
    //   playerState.value = state;
    // });
    return StreamBuilder(
      stream: player.currentIndexStream,
      builder: (context, currentTrackIndex) {
        return StreamBuilder(
          stream: player.positionStream,
          builder: (context, progress) {
            // totalProgress is the sum of the duration of all the tracks before the current track + the current track position
            final totalProgress =
                player.book?.tracks.sublist(0, currentTrackIndex.data).fold(
                          const Duration(seconds: 0),
                          (previousValue, element) =>
                              previousValue + element.duration,
                        ) ??
                    const Duration(seconds: 0) +
                        (progress.data ?? const Duration(seconds: 0));

            return StreamBuilder(
              stream: player.bufferedPositionStream,
              builder: (context, buffered) {
                final totalBuffered =
                    player.book?.tracks.sublist(0, currentTrackIndex.data).fold(
                              const Duration(seconds: 0),
                              (previousValue, element) =>
                                  previousValue + element.duration,
                            ) ??
                        const Duration(seconds: 0) +
                            (buffered.data ?? const Duration(seconds: 0));
                return ProgressBar(
                  progress: totalProgress,
                  total: player.book?.duration ?? const Duration(seconds: 0),
                  onSeek: player.seek,
                  thumbRadius: 8,
                  buffered: totalBuffered,
                  bufferedBarColor: Theme.of(context).colorScheme.secondary,
                );
              },
            );
          },
        );
      },
    );
  }
}

// ! TODO remove onTap
void onTap() {}
