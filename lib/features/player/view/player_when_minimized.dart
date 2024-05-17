import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:whispering_pages/features/player/providers/audiobook_player.dart';
import 'package:whispering_pages/features/player/providers/player_form.dart';

class PlayerWhenMinimized extends HookConsumerWidget {
  const PlayerWhenMinimized({
    super.key,
    required this.maxImgSize,
    required this.imgWidget,
    required this.elementOpacity,
    required this.playPauseButton,
    required this.progressIndicator,
  });

  final double maxImgSize;
  final Widget imgWidget;
  final double elementOpacity;
  final Widget playPauseButton;
  final Widget progressIndicator;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final player = ref.watch(audiobookPlayerProvider);
    final controller = ref.watch(miniplayerControllerProvider);
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
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
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
              // IconButton(
              //   icon: const Icon(Icons.fullscreen),
              //   onPressed: () {
              //     controller.animateToHeight(state: PanelState.MAX);
              //   },
              // ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Opacity(
                  opacity: elementOpacity,
                  child: playPauseButton,
                ),
              ),
            ],
          ),
        ),
        // SizedBox(
        //   height: progressIndicatorHeight,
        //   child: Opacity(
        //     opacity: elementOpacity,
        //     child: progressIndicator,
        //   ),
        // ),
      ],
    );
  }
}
