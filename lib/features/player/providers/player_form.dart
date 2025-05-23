// this provider is used to manage the player form state
// it will inform about the percentage of the player expanded

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vaani/features/player/providers/audiobook_player.dart';

part 'player_form.g.dart';

/// The height of the player when it is minimized
const double playerMinHeight = 70;
// const miniplayerPercentageDeclaration = 0.2;

extension on Ref {
  // We can move the previous logic to a Ref extension.
  // This enables reusing the logic between providers
  T disposeAndListenChangeNotifier<T extends ChangeNotifier>(T notifier) {
    onDispose(notifier.dispose);
    notifier.addListener(notifyListeners);
    // We return the notifier to ease the usage a bit
    return notifier;
  }
}

@Riverpod(keepAlive: true)
Raw<ValueNotifier<double>> playerExpandProgressNotifier(
  Ref ref,
) {
  final ValueNotifier<double> playerExpandProgress =
      ValueNotifier(playerMinHeight);

  return ref.disposeAndListenChangeNotifier(playerExpandProgress);
}

// @Riverpod(keepAlive: true)
// Raw<ValueNotifier<double>> dragDownPercentageNotifier(
//   DragDownPercentageNotifierRef ref,
// ) {
//   final ValueNotifier<double> notifier = ValueNotifier(0);

//   return ref.disposeAndListenChangeNotifier(notifier);
// }

// a provider that will listen to the playerExpandProgressNotifier and return the percentage of the player expanded
@Riverpod(keepAlive: true)
double playerHeight(
  Ref ref,
) {
  final playerExpandProgress = ref.watch(playerExpandProgressNotifierProvider);

  // on change of the playerExpandProgress invalidate
  playerExpandProgress.addListener(() {
    ref.invalidateSelf();
  });

  // listen to the playerExpandProgressNotifier and return the value
  return playerExpandProgress.value;
}

final audioBookMiniplayerController = MiniplayerController();

@Riverpod(keepAlive: true)
bool isPlayerActive(
  Ref ref,
) {
  try {
    final player = ref.watch(audiobookPlayerProvider);
    if (player.book != null) {
      return true;
    } else {
      final playerHeight = ref.watch(playerHeightProvider);
      return playerHeight < playerMinHeight;
    }
  } catch (e) {
    return false;
  }
}
