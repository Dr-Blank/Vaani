/// a wrapper around the audioplayers package to manage the audio player instance
///
/// this is needed as audiobook can be a list of audio files instead of a single file
library;

import 'package:audioplayers/audioplayers.dart';
import 'package:shelfsdk/audiobookshelf_api.dart';

/// will manage the audio player instance
class AudiobookPlayer extends AudioPlayer {
  // constructor which takes in the BookExpanded object
  AudiobookPlayer(this.token, this.baseUrl, {super.playerId}) : super() {
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
    // first stop the player
    await stop();

    var track = book.tracks[_currentIndex];
    var url = '$baseUrl${track.contentUrl}?token=$token';
    await setSourceUrl(
      url,
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

  /// override resume to set the source if the book is not set
  @override
  Future<void> resume() async {
    if (_book == null) {
      throw StateError('No book is set');
    }
    return super.resume();
  }

  /// a convenience stream for onPositionEveryXSeconds
  Stream<Duration> onPositionEvery(Duration duration) => TimerPositionUpdater(
        getPosition: getCurrentPosition,
        interval: duration,
      ).positionStream;

  /// need to override getDuration and getCurrentPosition to return according to the book instead of the current track
  /// this is because the book can be a list of audio files and the player is only aware of the current track
  /// so we need to calculate the duration and current position based on the book
  @override
  Future<Duration?> getDuration() async {
    if (_book == null) {
      return null;
    }
    return _book!.tracks.fold<Duration>(
      Duration.zero,
      (previousValue, element) => previousValue + element.duration,
    );
  }

  @override
  Future<Duration?> getCurrentPosition() async {
    if (_book == null) {
      return null;
    }
    var currentTrack = _book!.tracks[_currentIndex];
    var currentTrackDuration = currentTrack.duration;
    var currentTrackPosition = await super.getCurrentPosition();
    return currentTrackPosition != null
        ? currentTrackPosition + currentTrackDuration
        : null;
  }
}
