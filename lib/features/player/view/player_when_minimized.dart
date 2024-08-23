import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vaani/constants/sizes.dart';
import 'package:vaani/features/player/providers/audiobook_player.dart';
import 'package:vaani/features/player/providers/currently_playing_provider.dart';
import 'package:vaani/features/player/view/audiobook_player.dart';
import 'package:vaani/router/router.dart';

class PlayerWhenMinimized extends HookConsumerWidget {
  const PlayerWhenMinimized({
    super.key,
    required this.availWidth,
    required this.maxImgSize,
    required this.imgWidget,
    required this.playPauseController,
    required this.percentageMiniplayer,
  });

  final double availWidth;
  final double maxImgSize;
  final Widget imgWidget;
  final AnimationController playPauseController;

  /// 0 - 1, from minimized to when switched to expanded player
  ///
  /// by the time 1 is reached only image should be visible in the center of the widget
  final double percentageMiniplayer;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final player = ref.watch(audiobookPlayerProvider);
    final vanishingPercentage = 1 - percentageMiniplayer;
    final progress =
        useStream(player.slowPositionStream, initialData: Duration.zero);

    final bookMetaExpanded = ref.watch(currentBookMetadataProvider);

    var barHeight = vanishingPercentage * 3;
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Row(
          children: [
            // image
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal:
                    ((availWidth - maxImgSize) / 2) * percentageMiniplayer,
              ),
              child: InkWell(
                onTap: () {
                  // navigate to item page
                  context.pushNamed(
                    Routes.libraryItem.name,
                    pathParameters: {
                      Routes.libraryItem.pathParamName!:
                          player.book!.libraryItemId,
                    },
                  );
                },
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: maxImgSize,
                  ),
                  child: imgWidget,
                ),
              ),
            ),
            // author and title of the book
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // AutoScrollText(
                    Text(
                      bookMetaExpanded?.title ?? '',
                      maxLines: 1, overflow: TextOverflow.ellipsis,
                      // velocity:
                      //     const Velocity(pixelsPerSecond: Offset(16, 0)),
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Text(
                      bookMetaExpanded?.authorName ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withOpacity(0.7),
                          ),
                    ),
                  ],
                ),
              ),
            ),
            // IconButton(
            //   icon: const Icon(Icons.fullscreen),
            //   onPressed: () {
            //     controller.animateToHeight(state: PanelState.MAX);
            //   },
            // ),
            // rewind button
            Opacity(
              opacity: vanishingPercentage,
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: IconButton(
                  icon: const Icon(
                    Icons.replay_30,
                    size: AppElementSizes.iconSizeSmall,
                  ),
                  onPressed: () {},
                ),
              ),
            ),
            // play/pause button
            Opacity(
              opacity: vanishingPercentage,
              child: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: AudiobookPlayerPlayPauseButton(
                  playPauseController: playPauseController,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: barHeight,
          child: LinearProgressIndicator(
            value: (progress.data ?? Duration.zero).inSeconds /
                player.book!.duration.inSeconds,
            color: Theme.of(context).colorScheme.onPrimaryContainer,
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          ),
        ),
      ],
    );
  }
}
