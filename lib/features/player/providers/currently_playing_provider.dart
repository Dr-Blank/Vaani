import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shelfsdk/audiobookshelf_api.dart';
import 'package:whispering_pages/features/player/providers/audiobook_player.dart';

part 'currently_playing_provider.g.dart';

@riverpod
BookExpanded? currentlyPlayingBook(CurrentlyPlayingBookRef ref) {
  final player = ref.watch(audiobookPlayerProvider);
  return player.book;
}

/// provided the current chapter of the book being played
@riverpod
BookChapter? currentPlayingChapter(CurrentPlayingChapterRef ref) {
  final player = ref.watch(audiobookPlayerProvider);
  player.slowPositionStream.listen((_) {
    ref.invalidateSelf();
  });

  return player.currentChapter;
}

/// provides the book metadata of the currently playing book
@riverpod
BookMetadataExpanded? currentBookMetadata(CurrentBookMetadataRef ref) {
  final player = ref.watch(audiobookPlayerProvider);
  if (player.book == null) return null;
  return BookMetadataExpanded.fromJson(player.book!.metadata.toJson());
}

// /// volume of the player [0, 1]
// @riverpod
// double currentVolume(CurrentVolumeRef ref) {
//   return 1;
// }
