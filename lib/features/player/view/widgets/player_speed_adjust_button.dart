import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:whispering_pages/features/player/providers/audiobook_player.dart';
import 'package:whispering_pages/features/player/view/widgets/speed_selector.dart';

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
