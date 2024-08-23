import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vaani/constants/sizes.dart';
import 'package:vaani/features/player/providers/audiobook_player.dart';

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
