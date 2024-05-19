// this provider is used to manage the player form state
// it will inform about the percentage of the player expanded

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'player_form.g.dart';

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
  PlayerExpandProgressNotifierRef ref,
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
  PlayerHeightRef ref,
) {
  final playerExpandProgress = ref.watch(playerExpandProgressNotifierProvider);

  // on change of the playerExpandProgress invalidate
  playerExpandProgress.addListener(() {
    ref.invalidateSelf();
  });

  // listen to the playerExpandProgressNotifier and return the value
  return playerExpandProgress.value;
}

// a final MiniplayerController controller = MiniplayerController();
@Riverpod(keepAlive: true)
MiniplayerController miniplayerController(
  MiniplayerControllerRef ref,
) {
  return MiniplayerController();
}
