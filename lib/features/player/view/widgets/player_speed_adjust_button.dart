import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:vaani/features/player/providers/audiobook_player.dart';
import 'package:vaani/features/player/view/player_when_expanded.dart';
import 'package:vaani/features/player/view/widgets/speed_selector.dart';

final _logger = Logger('PlayerSpeedAdjustButton');

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
      onPressed: () async {
        pendingPlayerModals++;
        _logger.fine('opening speed selector');
        await showModalBottomSheet<bool>(
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
        pendingPlayerModals--;
        _logger.fine('Closing speed selector');
      },
    );
  }
}
