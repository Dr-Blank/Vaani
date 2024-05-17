/// a wrapper around the audioplayers package to manage the audio player instance
///
/// this is needed as audiobook can be a list of audio files instead of a single file
library;

import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:shelfsdk/audiobookshelf_api.dart';

/// will manage the audio player instance
class AudiobookPlayer extends AudioPlayer {
  // constructor which takes in the BookExpanded object
  AudiobookPlayer(this.token, this.baseUrl) : super() {
    // set the source of the player to the first track in the book
  }

  /// the [BookExpanded] being played
  BookExpanded? _book;

  /// the [BookExpanded] being played
  ///
  /// to set the book, use [setSourceAudioBook]
  BookExpanded? get book => _book;

  /// the authentication token to access the [AudioTrack.contentUrl]
  final String token;

  /// the base url for the audio files
  final Uri baseUrl;

  // the current index of the audio file in the [book]
  // final int _currentIndex = 0;

  // available audio tracks
  int? get availableTracks => _book?.tracks.length;

  /// sets the current [AudioTrack] as the source of the player
  Future<void> setSourceAudioBook(BookExpanded? book) async {
    // if the book is null, stop the player
    if (book == null) {
      _book = null;
      return stop();
    }

    // see if the book is the same as the current book
    if (_book == book) {
      // if the book is the same, do nothing
      return;
    }
    // first stop the player and clear the source
    await stop();

    await setAudioSource(
      ConcatenatingAudioSource(
        useLazyPreparation: true,
        children: book.tracks.map((track) {
          return AudioSource.uri(
            Uri.parse('$baseUrl${track.contentUrl}?token=$token'),
            tag: MediaItem(
              // Specify a unique ID for each media item:
              id: book.libraryItemId + track.index.toString(),
              // Metadata to display in the notification:
              album: book.metadata.title,
              title: book.metadata.title ?? track.title,
              artUri: Uri.parse(
                '$baseUrl/api/items/${book.libraryItemId}/cover?token=$token&width=800',
              ),
            ),
          );
        }).toList(),
      ),
    ).catchError((error) {
      debugPrint('Error: $error');
    });

    _book = book;
  }

  /// toggles the player between play and pause
  Future<void> togglePlayPause() {
    // check if book is set
    if (_book == null) {
      throw StateError('No book is set');
    }

    // ! refactor this
    return switch (playerState) {
      PlayerState(playing: var isPlaying) => isPlaying ? pause() : play(),
    };
  }

  /// need to override getDuration and getCurrentPosition to return according to the book instead of the current track
  /// this is because the book can be a list of audio files and the player is only aware of the current track
  /// so we need to calculate the duration and current position based on the book
  // @override
  // Future<Duration?> getDuration() async {
  //   if (_book == null) {
  //     return null;
  //   }
  //   return _book!.tracks.fold<Duration>(
  //     Duration.zero,
  //     (previousValue, element) => previousValue + element.duration,
  //   );
// }

  // @override
  // Future<Duration?> getCurrentPosition() async {
  //   if (_book == null) {
  //     return null;
  //   }
  //   var currentTrack = _book!.tracks[_currentIndex];
  //   var currentTrackDuration = currentTrack.duration;
  //   var currentTrackPosition = await super.getCurrentPosition();
  //   return currentTrackPosition != null
  //       ? currentTrackPosition + currentTrackDuration
  //       : null;
  // }
}
