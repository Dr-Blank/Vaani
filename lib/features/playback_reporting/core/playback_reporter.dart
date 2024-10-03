import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:shelfsdk/audiobookshelf_api.dart';
import 'package:vaani/features/player/core/audiobook_player.dart';
import 'package:vaani/shared/extensions/obfuscation.dart';

final _logger = Logger('PlaybackReporter');

/// this playback reporter will watch the player and report to the server
///
/// it will by default report every 10 seconds
/// and also report when the player is paused/stopped/finished/playing
class PlaybackReporter {
  /// The player to watch
  final AudiobookPlayer player;

  /// the api to report to
  final AudiobookshelfApi authenticatedApi;

  /// The stopwatch to keep track of the time since the last report
  ///
  /// this should only run when media is playing
  final _stopwatch = Stopwatch();

  /// subscriptions to listen and then cancel when disposing
  final List<StreamSubscription> _subscriptions = [];

  Duration _reportingInterval;

  /// the duration to wait before reporting
  Duration get reportingInterval => _reportingInterval;
  set reportingInterval(Duration value) {
    _reportingInterval = value;
    _cancelReportTimer();
    _setReportTimerIfNotAlready();
    _logger.info('set interval: $value');
  }

  /// the minimum duration to report
  final Duration reportingDurationThreshold;

  /// the duration to wait before starting the reporting
  /// this is to ignore the initial duration in case user is browsing
  final Duration? minimumPositionForReporting;

  /// the duration to mark the book as complete when the time left is less than this
  final Duration markCompleteWhenTimeLeft;

  /// timer to report every 10 seconds
  /// tracking the time since the last report
  Timer? _reportTimer;

  /// metadata to report
  String? deviceName;
  String? deviceModel;
  String? deviceSdkVersion;
  String? deviceClientName;
  String? deviceClientVersion;
  String? deviceManufacturer;

  PlaybackReporter(
    this.player,
    this.authenticatedApi, {
    this.deviceName,
    this.deviceModel,
    this.deviceSdkVersion,
    this.deviceClientName,
    this.deviceClientVersion,
    this.deviceManufacturer,
    this.reportingDurationThreshold = const Duration(seconds: 1),
    Duration reportingInterval = const Duration(seconds: 10),
    this.minimumPositionForReporting,
    this.markCompleteWhenTimeLeft = const Duration(seconds: 5),
  }) : _reportingInterval = reportingInterval {
    // initial conditions
    if (player.playing) {
      _stopwatch.start();
      _setReportTimerIfNotAlready();
      _logger.fine('starting stopwatch');
    } else {
      _logger.fine('not starting stopwatch');
    }

    _subscriptions.add(
      player.playerStateStream.listen((state) async {
        // set timer if any book is playing and cancel if not
        if (player.book != null) {
          if (state.playing) {
            _setReportTimerIfNotAlready();
          } else {
            _cancelReportTimer();
          }
        } else if (player.book == null && _reportTimer != null) {
          _logger.info('book is null, closing session');
          await closeSession();
          _cancelReportTimer();
        }

        // start or stop the stopwatch based on the playing state
        if (state.playing) {
          _stopwatch.start();
          _logger.fine(
            'player state observed, starting stopwatch at ${_stopwatch.elapsed}',
          );
        } else if (!state.playing) {
          _stopwatch.stop();
          _logger.fine(
            'player state observed, stopping stopwatch at ${_stopwatch.elapsed}',
          );
          await tryReportPlayback(null);
        }
      }),
    );

    _logger.fine(
      'initialized with reportingInterval: $reportingInterval, reportingDurationThreshold: $reportingDurationThreshold',
    );
    _logger.fine(
      'initialized with minimumPositionForReporting: $minimumPositionForReporting, markCompleteWhenTimeLeft: $markCompleteWhenTimeLeft',
    );
    _logger.fine(
      'initialized with deviceModel: $deviceModel, deviceSdkVersion: $deviceSdkVersion, deviceClientName: $deviceClientName, deviceClientVersion: $deviceClientVersion, deviceManufacturer: $deviceManufacturer',
    );
  }

  Future<void> tryReportPlayback(_) async {
    _logger.fine(
      'callback called when elapsed ${_stopwatch.elapsed}',
    );
    if (player.book != null &&
        player.positionInBook >=
            player.book!.duration - markCompleteWhenTimeLeft) {
      _logger.info(
        'marking complete as time left is less than $markCompleteWhenTimeLeft',
      );
      await markComplete();
      return;
    }
    if (_stopwatch.elapsed > reportingDurationThreshold) {
      _logger.fine(
        'reporting now with elapsed ${_stopwatch.elapsed} > threshold $reportingDurationThreshold',
      );
      await syncCurrentPosition();
    }
  }

  /// dispose the timer
  Future<void> dispose() async {
    for (var sub in _subscriptions) {
      sub.cancel();
    }
    await closeSession();
    _stopwatch.stop();
    _reportTimer?.cancel();

    _logger.fine('disposed');
  }

  /// current sessionId
  /// this is used to report the playback
  PlaybackSession? _session;
  String? get sessionId => _session?.id;

  Future<PlaybackSession?> startSession() async {
    if (_session != null) {
      return _session!;
    }
    if (player.book == null) {
      _logger.warning('No audiobook playing to start session');
      return null;
    }
    _session = await authenticatedApi.items.play(
      libraryItemId: player.book!.libraryItemId,
      parameters: PlayItemReqParams(
        deviceInfo: await _getDeviceInfo(),
        forceDirectPlay: false,
        forceTranscode: false,
      ),
      responseErrorHandler: _responseErrorHandler,
    );
    _logger.info('Started session: $sessionId');
    return _session;
  }

  Future<void> markComplete() async {
    if (player.book == null) {
      throw NoAudiobookPlayingError();
    }
    await authenticatedApi.me.createUpdateMediaProgress(
      libraryItemId: player.book!.libraryItemId,
      parameters: CreateUpdateProgressReqParams(
        isFinished: true,
        currentTime: player.positionInBook,
        duration: player.book!.duration,
      ),
      responseErrorHandler: _responseErrorHandler,
    );
    _logger.info('Marked complete for book: ${player.book!.libraryItemId}');
  }

  Future<void> syncCurrentPosition() async {
    final data = _getSyncData();
    if (data == null) {
      await closeSession();
    }
    try {
      _session ??= await startSession();
    } on Error catch (e) {
      _logger.warning('Error starting session: $e');
    }
    if (_session == null) {
      _logger.warning('No session to sync position');
      return;
    }
    final currentPosition = player.positionInBook;

    await authenticatedApi.sessions.syncOpen(
      sessionId: sessionId!,
      parameters: _getSyncData()!,
      responseErrorHandler: _responseErrorHandler,
    );

    _logger.fine(
      'Synced position: $currentPosition with timeListened: ${_stopwatch.elapsed} for session: $sessionId',
    );

    // reset the stopwatch
    _stopwatch.reset();
  }

  Future<void> closeSession() async {
    if (sessionId == null) {
      _logger.warning('No session to close');
      return;
    }

    await authenticatedApi.sessions.closeOpen(
      sessionId: sessionId!,
      parameters: _getSyncData(),
      responseErrorHandler: _responseErrorHandler,
    );
    _session = null;
    _logger.info('Closed session');
  }

  void _setReportTimerIfNotAlready() {
    if (_reportTimer != null) return;
    _reportTimer = Timer.periodic(_reportingInterval, tryReportPlayback);
    _logger.fine('set timer with interval: $_reportingInterval');
  }

  void _cancelReportTimer() {
    _reportTimer?.cancel();
    _reportTimer = null;
    _logger.fine('cancelled timer');
  }

  void _responseErrorHandler(http.Response response, [error]) {
    if (response.statusCode != 200) {
      _logger.severe('Error with api: ${response.obfuscate()}, $error');
      throw PlaybackSyncError(
        'Error syncing position: ${response.body}, $error',
      );
    }
  }

  SyncSessionReqParams? _getSyncData() {
    if (player.book?.libraryItemId != _session?.libraryItemId) {
      _logger.info(
        'Book changed, not syncing position for session: $sessionId',
      );
      return null;
    }

    // if in the ignore duration, don't sync
    if (minimumPositionForReporting != null &&
        player.positionInBook < minimumPositionForReporting!) {
      // but if elapsed time is more than the minimumPositionForReporting, sync
      if (_stopwatch.elapsed > minimumPositionForReporting!) {
        _logger.info(
          'Syncing position despite being less than minimumPositionForReporting as elapsed time is more: ${_stopwatch.elapsed}',
        );
      } else {
        _logger.info(
          'Ignoring sync for position: ${player.positionInBook} < $minimumPositionForReporting',
        );
        return null;
      }
    }

    return SyncSessionReqParams(
      currentTime: player.positionInBook,
      timeListened: _stopwatch.elapsed,
      duration: player.book?.duration ?? Duration.zero,
    );
  }

  Future<DeviceInfoReqParams> _getDeviceInfo() async {
    return DeviceInfoReqParams(
      clientVersion: deviceClientVersion,
      manufacturer: deviceManufacturer,
      model: deviceModel,
      sdkVersion: deviceSdkVersion,
      clientName: deviceClientName,
      deviceName: deviceName,
    );
  }
}

class PlaybackSyncError implements Exception {
  String message;

  PlaybackSyncError([this.message = 'Error syncing playback']);

  @override
  String toString() {
    return 'PlaybackSyncError: $message';
  }
}

class NoAudiobookPlayingError implements Exception {
  String message;

  NoAudiobookPlayingError([this.message = 'No audiobook is playing']);

  @override
  String toString() {
    return 'NoAudiobookPlayingError: $message';
  }
}
