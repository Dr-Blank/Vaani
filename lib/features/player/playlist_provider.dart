import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shelfsdk/audiobookshelf_api.dart';
import 'package:vaani/features/player/playlist.dart';

part 'playlist_provider.g.dart';

@riverpod
class Playlist extends _$Playlist {
  @override
  AudiobookPlaylist build() {
    return AudiobookPlaylist();
  }

  void add(BookExpanded item) {
    state.add(item);
    ref.notifyListeners();
  }
}
