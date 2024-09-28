import 'dart:async';

import 'package:flutter_animate/flutter_animate.dart';
import 'package:just_audio/just_audio.dart';
import 'package:logging/logging.dart';
import 'package:vaani/features/player/core/audiobook_player.dart';

/// this timer pauses the music player after a certain duration
///
/// watches the state of the music player and pauses it when the timer is up
/// timer is cancelled when the music player is paused or stopped
class SleepTimer {
  final _logger = Logger('SleepTimer');

  /// The duration after which the music player will be paused
  Duration _duration;

  Duration get duration => _duration;

  set duration(Duration value) {
    _duration = value;
    clearCountDownTimer();
  }

  /// The player to be paused
  final AudiobookPlayer player;

  /// The timer that will pause the player
  Timer? timer;

  /// for internal use only
  /// when the timer was started
  DateTime? startedAt;

  /// subscriptions
  final List<StreamSubscription> _subscriptions = [];

  SleepTimer({required duration, required this.player}) : _duration = duration {
    _subscriptions.add(
      player.playbackEventStream.listen((event) {
        if (event.processingState == ProcessingState.completed ||
            event.processingState == ProcessingState.idle) {
          clearCountDownTimer();
        }
      }),
    );

    /// pause the player when the timer is up
    _subscriptions.add(
      player.playerStateStream.listen((state) {
        if (state.playing && timer == null) {
          startCountDown();
        } else if (!state.playing) {
          clearCountDownTimer();
        }
      }),
    );

    _logger.fine('created with duration: $duration');
  }

  /// resets the timer and stops it
  void clearCountDownTimer() {
    if (timer != null) {
      timer!.cancel();
      _logger.fine(
        'cancelled timer, remaining time: $remainingTime, duration: $duration',
      );
      timer = null;
    }
  }

  /// refills the timer with the default duration and starts it if the player is playing
  /// if the player is not playing, the timer is stopped
  void restartTimer() {
    clearCountDownTimer();
    if (player.playing) {
      startCountDown();
    }
    _logger.fine('restarted timer');
  }

  /// starts the timer with the given duration or the default duration
  void startCountDown([
    Duration? forDuration,
  ]) {
    clearCountDownTimer();
    duration = forDuration ?? duration;
    timer = Timer(duration, () {
      player.pause();
      clearCountDownTimer();
      _logger.fine('paused player after $duration');
    });
    startedAt = DateTime.now();
    _logger.fine('started for $duration at $startedAt');
  }

  Duration get remainingTime {
    if (timer == null) {
      return Duration.zero;
    }
    final elapsed = DateTime.now().difference(startedAt!);
    return duration - elapsed;
  }

  /// a stream that emits the remaining time every second
  Stream<Duration> get remainingTimeStream async* {
    while (timer != null) {
      yield remainingTime;
      await Future.delayed(0.5.seconds);
    }
  }

  /// dispose the timer
  void dispose() {
    clearCountDownTimer();
    for (var sub in _subscriptions) {
      sub.cancel();
    }
    _logger.fine('disposed');
  }
}
