import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shelfsdk/audiobookshelf_api.dart';
import 'package:whispering_pages/features/player/core/audiobook_player.dart';

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
  final _stopwatch = Stopwatch();

  /// subscriptions
  final List<StreamSubscription> _subscriptions = [];

  Duration _reportingInterval;

  /// the duration to wait before reporting
  Duration get reportingInterval => _reportingInterval;
  set reportingInterval(Duration value) {
    _reportingInterval = value;
    _cancelReportTimer();
    _setReportTimer();
    debugPrint('PlaybackReporter set interval: $value');
  }

  /// the minimum duration to report
  final Duration reportingDurationThreshold;

  /// timer to report every 10 seconds
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
  }) : _reportingInterval = reportingInterval {
    // initial conditions
    if (player.playing) {
      _stopwatch.start();
      _setReportTimer();
      debugPrint('PlaybackReporter starting stopwatch');
    } else {
      debugPrint('PlaybackReporter not starting stopwatch');
    }

    _subscriptions.add(
      player.playerStateStream.listen((state) async {
        // set timer if any book is playing and cancel if not
        if (player.book != null && _reportTimer == null) {
          _setReportTimer();
        } else if (player.book == null && _reportTimer != null) {
          debugPrint('PlaybackReporter book is null, closing session');
          await closeSession();
          _cancelReportTimer();
        }

        // start or stop the stopwatch based on the playing state
        if (state.playing) {
          _stopwatch.start();
          debugPrint(
            'PlaybackReporter player state observed, starting stopwatch at ${_stopwatch.elapsed}',
          );
        } else if (!state.playing) {
          _stopwatch.stop();
          debugPrint(
            'PlaybackReporter player state observed, stopping stopwatch at ${_stopwatch.elapsed}',
          );
          await syncCurrentPosition();
        }
      }),
    );

    debugPrint(
      'PlaybackReporter initialized with interval: $reportingInterval, threshold: $reportingDurationThreshold',
    );
    debugPrint(
      'PlaybackReporter initialized with deviceModel: $deviceModel, deviceSdkVersion: $deviceSdkVersion, deviceClientName: $deviceClientName, deviceClientVersion: $deviceClientVersion, deviceManufacturer: $deviceManufacturer',
    );
  }

  void tryReportPlayback(_) async {
    debugPrint(
      'PlaybackReporter callback called when elapsed ${_stopwatch.elapsed}',
    );
    if (_stopwatch.elapsed > reportingDurationThreshold) {
      debugPrint(
        'PlaybackReporter reporting now with elapsed ${_stopwatch.elapsed} > threshold $reportingDurationThreshold',
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

    debugPrint('PlaybackReporter disposed');
  }

  /// current sessionId
  /// this is used to report the playback
  String? sessionId;

  Future<String?> startSession() async {
    if (sessionId != null) {
      return sessionId!;
    }
    if (player.book == null) {
      throw NoAudiobookPlayingError();
    }
    final session = await authenticatedApi.items.play(
      libraryItemId: player.book!.libraryItemId,
      parameters: PlayItemReqParams(
        deviceInfo: await _getDeviceInfo(),
        forceDirectPlay: false,
        forceTranscode: false,
      ),
      responseErrorHandler: _responseErrorHandler,
    );
    sessionId = session!.id;
    debugPrint('PlaybackReporter Started session: $sessionId');
    return sessionId;
  }

  Future<void> syncCurrentPosition() async {
    try {
      sessionId ??= await startSession();
    } on NoAudiobookPlayingError {
      debugPrint('PlaybackReporter No audiobook playing to sync position');
      return;
    }
    final currentPosition = player.position;

    await authenticatedApi.sessions.syncOpen(
      sessionId: sessionId!,
      parameters: _getSyncData(),
      responseErrorHandler: _responseErrorHandler,
    );

    debugPrint(
      'PlaybackReporter Synced position: $currentPosition with timeListened: ${_stopwatch.elapsed} for session: $sessionId',
    );

    // reset the stopwatch
    _stopwatch.reset();
  }

  Future<void> closeSession() async {
    if (sessionId == null) {
      debugPrint('PlaybackReporter No session to close');
      return;
    }

    await authenticatedApi.sessions.closeOpen(
      sessionId: sessionId!,
      parameters: _getSyncData(),
      responseErrorHandler: _responseErrorHandler,
    );
    sessionId = null;
    debugPrint('PlaybackReporter Closed session');
  }

  void _setReportTimer() {
    _reportTimer = Timer.periodic(_reportingInterval, tryReportPlayback);
    debugPrint('PlaybackReporter set timer with interval: $_reportingInterval');
  }

  void _cancelReportTimer() {
    _reportTimer?.cancel();
    _reportTimer = null;
    debugPrint('PlaybackReporter cancelled timer');
  }

  void _responseErrorHandler(response, [error]) {
    if (response.statusCode != 200) {
      debugPrint('PlaybackReporter Error with api: $response, $error');
      throw PlaybackSyncError(
        'Error syncing position: ${response.body}, $error',
      );
    }
  }

  SyncSessionReqParams _getSyncData() {
    return SyncSessionReqParams(
      currentTime: player.position,
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
