import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:whispering_pages/api/api_provider.dart';
import 'package:whispering_pages/features/player/core/audiobook_player.dart'
    as core;

part 'audiobook_player.g.dart';

// @Riverpod(keepAlive: true)
// core.AudiobookPlayer audiobookPlayer(
//   AudiobookPlayerRef ref,
// ) {
//   final api = ref.watch(authenticatedApiProvider);
//   final player = core.AudiobookPlayer(api.token!, api.baseUrl);

//   ref.onDispose(player.dispose);

//   return player;
// }

const playerId = 'audiobook_player';

/// Simple because it doesn't rebuild when the player state changes
/// it only rebuilds when the token changes
@Riverpod(keepAlive: true)
class SimpleAudiobookPlayer extends _$SimpleAudiobookPlayer {
  @override
  core.AudiobookPlayer build() {
    final api = ref.watch(authenticatedApiProvider);
    final player = core.AudiobookPlayer(
      api.token!,
      api.baseUrl,
    );

    ref.onDispose(player.dispose);

    return player;
  }
}

@Riverpod(keepAlive: true)
class AudiobookPlayer extends _$AudiobookPlayer {
  @override
  core.AudiobookPlayer build() {
    final player = ref.watch(simpleAudiobookPlayerProvider);

    ref.onDispose(player.dispose);

    // bind notify listeners to the player
    player.playerStateStream.listen((_) {
      notifyListeners();
    });

    return player;
  }

  void notifyListeners() {
    ref.notifyListeners();
  }

  Future<void> setSpeed(double speed) async {
    await state.setSpeed(speed);
    notifyListeners();
  }
}
