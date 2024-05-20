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
import 'package:whispering_pages/settings/app_settings_provider.dart';
import 'package:whispering_pages/shared/extensions/inverse_lerp.dart';
import 'package:whispering_pages/shared/widgets/shelves/book_shelf.dart';
import 'package:whispering_pages/theme/theme_from_cover_provider.dart';

import 'player_when_expanded.dart';
import 'player_when_minimized.dart';

class AudiobookPlayer extends HookConsumerWidget {
  const AudiobookPlayer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appSettings = ref.watch(appSettingsProvider);
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

    // theme from image
    final imageTheme = ref.watch(
      themeOfLibraryItemProvider(
        itemBeingPlayed.valueOrNull,
        brightness: Theme.of(context).brightness,
      ),
    );

    // max height of the player is the height of the screen
    final playerMaxHeight = MediaQuery.of(context).size.height;

    final availWidth = MediaQuery.of(context).size.width;

    // the image width when the player is expanded
    final maxImgSize = availWidth * 0.9;

    final preferredVolume = appSettings.playerSettings.preferredVolume;
    return Theme(
      data: ThemeData(
        colorScheme: imageTheme.valueOrNull ?? Theme.of(context).colorScheme,
      ),
      child: Miniplayer(
        valueNotifier: ref.watch(playerExpandProgressNotifierProvider),
        onDragDown: (percentage) async {
          // preferred volume
          // set volume to 0 when dragging down
          await player.setVolume(preferredVolume * (1 - percentage));
        },
        minHeight: playerMinHeight,
        // subtract the height of notches and other system UI
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
          //     'percentage: ${percentage.toStringAsFixed(2)}, height: ${height.toStringAsFixed(2)} volume: ${player.volume.toStringAsFixed(2)}',
          //   ),
          // );

          // at what point should the player switch from miniplayer to expanded player
          // at this point the image should be at its max size and in the center of the player
          final miniplayerPercentageDeclaration =
              (maxImgSize - playerMinHeight) /
                  (playerMaxHeight - playerMinHeight);
          final bool isFormMiniplayer =
              percentage < miniplayerPercentageDeclaration;

          if (!isFormMiniplayer) {
            // this calculation needs a refactor
            var percentageExpandedPlayer = percentage
                .inverseLerp(
                  miniplayerPercentageDeclaration,
                  1,
                )
                .clamp(0.0, 1.0);

            return PlayerWhenExpanded(
              imageSize: maxImgSize,
              img: imgWidget,
              percentageExpandedPlayer: percentageExpandedPlayer,
              playPauseController: playPauseController,
            );
          }

          //Miniplayer
          final percentageMiniplayer = percentage.inverseLerp(
            0,
            miniplayerPercentageDeclaration,
          );

          return PlayerWhenMinimized(
            maxImgSize: maxImgSize,
            availWidth: availWidth,
            imgWidget: imgWidget,
            playPauseController: playPauseController,
            percentageMiniplayer: percentageMiniplayer,
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
    this.iconSize = 48.0,
  });

  final double iconSize;
  final AnimationController playPauseController;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final player = ref.watch(audiobookPlayerProvider);

    return switch (player.processingState) {
      ProcessingState.loading || ProcessingState.buffering => const Padding(
          padding: EdgeInsets.all(8.0),
          child: CircularProgressIndicator(),
        ),
      ProcessingState.completed => IconButton(
          onPressed: () async {
            await player.seek(const Duration(seconds: 0));
            await player.play();
          },
          icon: const Icon(
            Icons.replay,
          ),
        ),
      ProcessingState.ready => IconButton(
          onPressed: () async {
            await player.togglePlayPause();
          },
          iconSize: iconSize,
          icon: AnimatedIcon(
            icon: AnimatedIcons.play_pause,
            progress: playPauseController,
          ),
        ),
      ProcessingState.idle => const SizedBox.shrink(),
    };
  }
}

class AudiobookChapterProgressBar extends HookConsumerWidget {
  const AudiobookChapterProgressBar({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final player = ref.watch(audiobookPlayerProvider);
    final currentChapter = ref.watch(currentPlayingChapterProvider);
    final position = useStream(
      player.positionStream,
      initialData: const Duration(seconds: 0),
    );
    final buffered = useStream(
      player.bufferedPositionStream,
      initialData: const Duration(seconds: 0),
    );

    // now find the chapter that corresponds to the current time
    // and calculate the progress of the current chapter
    final currentChapterProgress = currentChapter == null
        ? null
        : (player.positionInBook - currentChapter.start);

    final currentChapterBuffered = currentChapter == null
        ? null
        : (player.bufferedPositionInBook - currentChapter.start);

    return ProgressBar(
      progress:
          currentChapterProgress ?? position.data ?? const Duration(seconds: 0),
      total: currentChapter == null
          ? player.book?.duration ?? const Duration(seconds: 0)
          : currentChapter.end - currentChapter.start,
      // ! TODO add onSeek
      onSeek: (duration) {
        player.seek(
          duration + (currentChapter?.start ?? const Duration(seconds: 0)),
        );
      },
      thumbRadius: 8,
      buffered:
          currentChapterBuffered ?? buffered.data ?? const Duration(seconds: 0),
      bufferedBarColor: Theme.of(context).colorScheme.secondary,
      timeLabelType: TimeLabelType.remainingTime,
      timeLabelLocation: TimeLabelLocation.below,
    );
  }
}

// ! TODO remove onTap
void onTap() {}
