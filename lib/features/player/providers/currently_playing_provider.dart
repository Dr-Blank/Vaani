import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shelfsdk/audiobookshelf_api.dart';
import 'package:whispering_pages/features/player/providers/audiobook_player_provider.dart';

part 'currently_playing_provider.g.dart';

@riverpod
BookExpanded? currentlyPlayingBook(CurrentlyPlayingBookRef ref) {
  final player = ref.watch(audiobookPlayerProvider);
  return player.book;
}
