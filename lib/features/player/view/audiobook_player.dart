import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:whispering_pages/api/image_provider.dart';
import 'package:whispering_pages/api/library_item_provider.dart';
import 'package:whispering_pages/features/player/providers/audiobook_player.dart';
import 'package:whispering_pages/features/player/providers/currently_playing_provider.dart';
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

const double playerMinHeight = 70;
const double playerMaxHeight = 500;
const miniplayerPercentageDeclaration = 0.2;
final ValueNotifier<double> playerExpandProgress =
    ValueNotifier(playerMinHeight);

final MiniplayerController controller = MiniplayerController();

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
    player.onPlayerStateChanged.listen((state) {
      if (state == PlayerState.playing) {
        playPauseController.reverse();
      } else {
        playPauseController.forward();
      }
    });

    final playPauseButton = IconButton(
      onPressed: () async {
        await player.togglePlayPause();
      },
      icon: AnimatedIcon(
        icon: AnimatedIcons.pause_play,
        progress: playPauseController,
        size: 50,
      ),
    );
    // player.onPositionChanged.listen((event) {
    //   currentProgress.value = event.inSeconds.toDouble();
    // });

    // final progressStream = TimerPositionUpdater(
    //   getPosition: player.getCurrentPosition,
    //   interval: const Duration(milliseconds: 500),
    // ).positionStream;
    // // a debug that will print the current position of the player
    // progressStream.listen((event) {
    //   debugPrint('Current position: ${event.inSeconds}');
    // });

    // the widget that will be displayed when the player is expanded
    const progressBar = PlayerProgressBar();

    // theme from image
    final imageTheme = ref.watch(
      themeOfLibraryItemProvider(
        itemBeingPlayed.valueOrNull,
        brightness: Theme.of(context).brightness,
      ),
    );
    return Theme(
      // get the theme from imageThemeProvider

      data: ThemeData(
        colorScheme: imageTheme.valueOrNull ?? Theme.of(context).colorScheme,
      ),
      child: Miniplayer(
        valueNotifier: playerExpandProgress,
        minHeight: playerMinHeight,
        maxHeight: playerMaxHeight,
        controller: controller,
        elevation: 4,
        onDismissed: () {
          player.setSourceAudioBook(null);
        },
        curve: Curves.easeOut,
        builder: (height, percentage) {
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
            const buttonPlayExpanded = IconButton(
              icon: Icon(Icons.pause_circle_filled),
              iconSize: 50,
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
              buttonPlayExpanded: playPauseButton,
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
          final progressIndicatorHeight = 4 - 4 * percentageMiniplayer;

          return PlayerWhenMinimized(
            maxImgSize: maxImgSize,
            imgWidget: imgWidget,
            elementOpacity: elementOpacity,
            playPauseButton: playPauseButton,
            progressIndicatorHeight: progressIndicatorHeight,
            progressIndicator: progressBar,
          );
        },
      ),
    );
  }
}

class PlayerProgressBar extends HookConsumerWidget {
  const PlayerProgressBar({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final player = ref.watch(audiobookPlayerProvider);
    final playerState = useState(player.state);
    // add a listener to the player state
    player.onPlayerStateChanged.listen((state) {
      playerState.value = state;
    });
    return StreamBuilder<Duration>(
      stream: player.onPositionChanged,
      builder: (context, snapshot) {
        return ProgressBar(
          progress: snapshot.data ?? const Duration(seconds: 0),
          total: player.book?.duration ?? const Duration(seconds: 0),
          onSeek: player.seek,
          thumbRadius: 8,
          // thumbColor: Theme.of(context).colorScheme.secondary,
          thumbGlowColor: Theme.of(context).colorScheme.secondary,
          thumbGlowRadius: playerState.value == PlayerState.playing ? 10 : 0,
        );
      },
    );
  }
}

void onTap() {}
