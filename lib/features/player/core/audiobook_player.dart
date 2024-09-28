/// a wrapper around the audioplayers package to manage the audio player instance
///
/// this is needed as audiobook can be a list of audio files instead of a single file
library;

import 'package:collection/collection.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:logging/logging.dart';
import 'package:shelfsdk/audiobookshelf_api.dart';
import 'package:vaani/settings/app_settings_provider.dart';
import 'package:vaani/settings/models/app_settings.dart';
import 'package:vaani/shared/extensions/model_conversions.dart';

final _logger = Logger('AudiobookPlayer');

/// returns the sum of the duration of all the previous tracks before the [index]
Duration sumOfTracks(BookExpanded book, int? index) {
  // return 0 if index is less than 0
  if (index == null || index < 0) {
    return Duration.zero;
  }
  return book.tracks.sublist(0, index).fold<Duration>(Duration.zero,
      (previousValue, element) {
    return previousValue + element.duration;
  });
}

/// returns the [AudioTrack] to play based on the [position] in the [book]
AudioTrack getTrackToPlay(BookExpanded book, Duration position) {
  // var totalDuration = Duration.zero;
  // for (var track in book.tracks) {
  //   totalDuration += track.duration;
  //   if (totalDuration >= position) {
  //     return track;
  //   }
  // }
  // return book.tracks.last;
  return book.tracks.firstWhere(
    (element) {
      return element.startOffset <= position &&
          (element.startOffset + element.duration) >= position;
    },
    orElse: () => book.tracks.last,
  );
}

/// will manage the audio player instance
class AudiobookPlayer extends AudioPlayer {
  // constructor which takes in the BookExpanded object
  AudiobookPlayer(this.token, this.baseUrl) : super() {
    // set the source of the player to the first track in the book
  }

  /// the [BookExpanded] being played
  BookExpanded? _book;

  // /// the [BookExpanded] trying to be played
  // BookExpanded? _intended_book;

  /// the [BookExpanded] being played
  ///
  /// to set the book, use [setSourceAudiobook]
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
  Future<void> setSourceAudiobook(
    BookExpanded? book, {
    bool preload = true,
    // int? initialIndex,
    Duration? initialPosition,
    List<Uri>? downloadedUris,
    Uri? artworkUri,
  }) async {
    final appSettings = loadOrCreateAppSettings();
    // if the book is null, stop the player
    if (book == null) {
      _book = null;
      _logger.info('Book is null, stopping player');
      return stop();
    }

    // see if the book is the same as the current book
    if (_book == book) {
      _logger.info('Book is the same, doing nothing');
      return;
    }
    // first stop the player and clear the source
    await stop();

    _book = book;

    // some calculations to set the initial index and position
    // initialPosition is of the entire book not just the current track
    // hence first we need to calculate the current track which will be used to set the initial position
    // then we set the initial index to the current track index and position as the remaining duration from the position
    // after subtracting the duration of all the previous tracks
    // initialPosition ;
    final trackToPlay = getTrackToPlay(book, initialPosition ?? Duration.zero);
    final initialIndex = book.tracks.indexOf(trackToPlay);
    final initialPositionInTrack = initialPosition != null
        ? initialPosition - trackToPlay.startOffset
        : null;

    await setAudioSource(
      preload: preload,
      initialIndex: initialIndex,
      initialPosition: initialPositionInTrack,
      ConcatenatingAudioSource(
        useLazyPreparation: true,
        children: book.tracks.map((track) {
          final retrievedUri =
              _getUri(track, downloadedUris, baseUrl: baseUrl, token: token);
          _logger.fine(
            'Setting source for track: ${track.title}, URI: $retrievedUri',
          );
          return AudioSource.uri(
            retrievedUri,
            tag: MediaItem(
              // Specify a unique ID for each media item:
              id: book.libraryItemId + track.index.toString(),
              // Metadata to display in the notification:
              title: appSettings.notificationSettings.primaryTitle
                  .formatNotificationTitle(book),
              album: appSettings.notificationSettings.secondaryTitle
                  .formatNotificationTitle(book),
              artUri: artworkUri ??
                  Uri.parse(
                    '$baseUrl/api/items/${book.libraryItemId}/cover?token=$token&width=800',
                  ),
            ),
          );
        }).toList(),
      ),
    ).catchError((error) {
      _logger.shout('Error: $error');
    });
  }

  /// toggles the player between play and pause
  Future<void> togglePlayPause() {
    // check if book is set
    if (_book == null) {
      throw StateError('No book is set');
    }

    // TODO refactor this to cover all the states
    return switch (playerState) {
      PlayerState(playing: var isPlaying) => isPlaying ? pause() : play(),
    };
  }

  /// need to override getDuration and getCurrentPosition to return according to the book instead of the current track
  /// this is because the book can be a list of audio files and the player is only aware of the current track
  /// so we need to calculate the duration and current position based on the book

  @override
  Future<void> seek(Duration? positionInBook, {int? index}) async {
    if (_book == null) {
      return;
    }
    if (positionInBook == null) {
      return;
    }
    final tracks = _book!.tracks;
    final trackToPlay = getTrackToPlay(_book!, positionInBook);
    final index = tracks.indexOf(trackToPlay);
    final positionInTrack = positionInBook - trackToPlay.startOffset;
    return super.seek(positionInTrack, index: index);
  }

  /// a convenience method to get position in the book instead of the current track position
  Duration get positionInBook {
    if (_book == null) {
      return Duration.zero;
    }
    return position + _book!.tracks[sequenceState!.currentIndex].startOffset;
  }

  /// a convenience method to get the buffered position in the book instead of the current track position
  Duration get bufferedPositionInBook {
    if (_book == null) {
      return Duration.zero;
    }
    return bufferedPosition +
        _book!.tracks[sequenceState!.currentIndex].startOffset;
  }

  /// streams to override to suit the book instead of the current track
  // - positionStream
  // - bufferedPositionStream

  @override
  Stream<Duration> get positionStream {
    // return the positionInBook stream
    return super.positionStream.map((position) {
      if (_book == null) {
        return Duration.zero;
      }
      return position + _book!.tracks[sequenceState!.currentIndex].startOffset;
    });
  }

  @override
  Stream<Duration> get bufferedPositionStream {
    return super.bufferedPositionStream.map((position) {
      if (_book == null) {
        return Duration.zero;
      }
      return position + _book!.tracks[sequenceState!.currentIndex].startOffset;
    });
  }

  /// a convenience getter for slow position stream
  Stream<Duration> get slowPositionStream {
    final superPositionStream = createPositionStream(
      steps: 100,
      minPeriod: const Duration(milliseconds: 500),
      maxPeriod: const Duration(seconds: 1),
    );
    // now we need to map the position to the book instead of the current track
    return superPositionStream.map((position) {
      if (_book == null) {
        return Duration.zero;
      }
      return position + _book!.tracks[sequenceState!.currentIndex].startOffset;
    });
  }

  /// get current chapter
  BookChapter? get currentChapter {
    if (_book == null) {
      return null;
    }
    // if the list is empty, return null
    if (_book!.chapters.isEmpty) {
      return null;
    }
    return _book!.chapters.firstWhere(
      (element) {
        return element.start <= positionInBook && element.end >= positionInBook;
      },
      orElse: () => _book!.chapters.first,
    );
  }
}

Uri _getUri(
  AudioTrack track,
  List<Uri>? downloadedUris, {
  required Uri baseUrl,
  required String token,
}) {
  // check if the track is in the downloadedUris
  final uri = downloadedUris?.firstWhereOrNull(
    (element) {
      return element.pathSegments.last == track.metadata?.filename;
    },
  );

  return uri ??
      Uri.parse('${baseUrl.toString()}${track.contentUrl}?token=$token');
}

extension FormatNotificationTitle on String {
  String formatNotificationTitle(BookExpanded book) {
    return replaceAllMapped(
      RegExp(r'\$(\w+)'),
      (match) {
        final type = match.group(1);
        return NotificationTitleType.values
                .firstWhere((element) => element.name == type)
                .extractFrom(book) ??
            match.group(0) ??
            '';
      },
    );
  }
}

extension NotificationTitleUtils on NotificationTitleType {
  String? extractFrom(BookExpanded book) {
    var bookMetadataExpanded = book.metadata.asBookMetadataExpanded;
    switch (this) {
      case NotificationTitleType.bookTitle:
        return bookMetadataExpanded.title;
      case NotificationTitleType.chapterTitle:
        // TODO: implement chapter title; depends on https://github.com/Dr-Blank/Vaani/issues/2
        return bookMetadataExpanded.title;
      case NotificationTitleType.author:
        return bookMetadataExpanded.authorName;
      case NotificationTitleType.narrator:
        return bookMetadataExpanded.narratorName;
      case NotificationTitleType.series:
        return bookMetadataExpanded.seriesName;
      case NotificationTitleType.subtitle:
        return bookMetadataExpanded.subtitle;
      case NotificationTitleType.year:
        return bookMetadataExpanded.publishedYear;
    }
  }
}
