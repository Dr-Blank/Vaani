/// a wrapper around the audioplayers package to manage the audio player instance
///
/// this is needed as audiobook can be a list of audio files instead of a single file
library;

import 'package:audioplayers/audioplayers.dart';
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
  final int _currentIndex = 0;

  /// sets the current [AudioTrack] as the source of the player
  Future<void> setSourceAudioBook(BookExpanded book) async {
    // see if the book is the same as the current book
    if (_book == book) {
      // if the book is the same, do nothing
      return;
    }

    var track = book.tracks[_currentIndex];
    var url = '$baseUrl${track.contentUrl}?token=$token';
    await setSourceUrl(
      url,
      // '${track.contentUrl}?token=$token',
      mimeType: track.mimeType,
    );
    _book = book;
  }

  /// toggles the player between play and pause
  Future<void> togglePlayPause() {
    // check if book is set
    if (_book == null) {
      throw StateError('No book is set');
    }
    return switch (state) {
      PlayerState.playing => pause(),
      PlayerState.paused ||
      PlayerState.stopped ||
      PlayerState.completed =>
        resume(),
      // do nothing if the player is disposed
      PlayerState.disposed => throw StateError('Player is disposed'),
    };
  }
}

void main(List<String> args) {
  final AudiobookPlayer abPlayer = AudiobookPlayer('', Uri.parse(''));
  print(abPlayer.resume());
}
