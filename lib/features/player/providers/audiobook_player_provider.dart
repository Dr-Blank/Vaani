import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:whispering_pages/api/api_provider.dart';
import 'package:whispering_pages/features/player/core/audiobook_payer.dart' as abp;

part 'audiobook_player_provider.g.dart';

// @Riverpod(keepAlive: true)
// abp.AudiobookPlayer audiobookPlayer(
//   AudiobookPlayerRef ref,
// ) {
//   final api = ref.watch(authenticatedApiProvider);
//   final player = abp.AudiobookPlayer(api.token!, api.baseUrl);

//   ref.onDispose(player.dispose);

//   return player;
// }

const playerId = 'audiobook_player';

@Riverpod(keepAlive: true)
class AudiobookPlayer extends _$AudiobookPlayer {
  @override
  abp.AudiobookPlayer build() {
    final api = ref.watch(authenticatedApiProvider);
    final player =
        abp.AudiobookPlayer(api.token!, api.baseUrl, playerId: playerId);

    ref.onDispose(player.dispose);

    // bind notify listeners to the player
    player.onPlayerStateChanged.listen((_) {
      notifyListeners();
    });

    return player;
  }

  void notifyListeners() {
    ref.notifyListeners();
  }
}
