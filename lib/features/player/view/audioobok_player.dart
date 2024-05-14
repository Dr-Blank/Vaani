import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:whispering_pages/api/image_provider.dart';
import 'package:whispering_pages/api/library_item_provider.dart';
import 'package:whispering_pages/features/player/providers/audiobook_player_provider.dart';
import 'package:whispering_pages/features/player/providers/currently_playing_provider.dart';
import 'package:whispering_pages/shared/widgets/shelves/book_shelf.dart';

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
const double playerMaxHeight = 370;
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
    final item = ref.watch(libraryItemProvider(currentBook.libraryItemId));
    final player = ref.watch(audiobookPlayerProvider);
    final image = item.valueOrNull != null
        ? ref.watch(
            coverImageProvider(item.valueOrNull!),
          )
        : null;
    final imgWidget = image?.valueOrNull != null
        ? Image.memory(
            image!.valueOrNull!,
            fit: BoxFit.cover,
          )
        : const BookCoverSkeleton();
    return Miniplayer(
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

        final text = Text(player.book?.metadata.title ?? '');
        const buttonPlay = IconButton(
          icon: Icon(Icons.pause),
          onPressed: onTap,
        );
        const progressIndicator = LinearProgressIndicator(value: 0.3);

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
            max: 10,
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

          return Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: paddingLeft,
                    top: paddingVertical,
                    bottom: paddingVertical,
                  ),
                  child: SizedBox(
                    height: imageSize,
                    child: imgWidget,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 33),
                  child: Opacity(
                    opacity: percentageExpandedPlayer,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Flexible(child: text),
                        const Flexible(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              buttonSkipBackwards,
                              buttonPlayExpanded,
                              buttonSkipForward,
                            ],
                          ),
                        ),
                        const Flexible(child: progressIndicator),
                        Container(),
                        Container(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
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

        return Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: maxImgSize),
                    child: imgWidget,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Opacity(
                        opacity: elementOpacity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              player.book?.metadata.title ?? '',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(fontSize: 16),
                            ),
                            Text(
                              'audioObject.subtitle',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .color!
                                        .withOpacity(0.55),
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.fullscreen),
                    onPressed: () {
                      controller.animateToHeight(state: PanelState.MAX);
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 3),
                    child: Opacity(
                      opacity: elementOpacity,
                      child: buttonPlay,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: progressIndicatorHeight,
              child: Opacity(
                opacity: elementOpacity,
                child: progressIndicator,
              ),
            ),
          ],
        );
      },
    );
  }
}

void onTap() {}
