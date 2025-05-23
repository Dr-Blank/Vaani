import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shelfsdk/audiobookshelf_api.dart';
import 'package:vaani/features/player/providers/audiobook_player.dart';
import 'package:vaani/shared/extensions/model_conversions.dart';

part 'currently_playing_provider.g.dart';

final _logger = Logger('CurrentlyPlayingProvider');

@riverpod
BookExpanded? currentlyPlayingBook(Ref ref) {
  try {
    final player = ref.watch(audiobookPlayerProvider);
    return player.book;
  } catch (e) {
    _logger.warning('Error getting currently playing book: $e');
    return null;
  }
}

/// provided the current chapter of the book being played
@riverpod
BookChapter? currentPlayingChapter(Ref ref) {
  final player = ref.watch(audiobookPlayerProvider);
  player.slowPositionStream.listen((_) {
    ref.invalidateSelf();
  });

  return player.currentChapter;
}

/// provides the book metadata of the currently playing book
@riverpod
BookMetadataExpanded? currentBookMetadata(Ref ref) {
  final player = ref.watch(audiobookPlayerProvider);
  if (player.book == null) return null;
  return player.book!.metadata.asBookMetadataExpanded;
}

// /// volume of the player [0, 1]
// @riverpod
// double currentVolume(CurrentVolumeRef ref) {
//   return 1;
// }
