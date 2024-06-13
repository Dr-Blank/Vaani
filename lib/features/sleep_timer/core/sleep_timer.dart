import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:just_audio/just_audio.dart';
import 'package:whispering_pages/features/player/core/audiobook_player.dart';

/// this timer pauses the music player after a certain duration
///
/// watches the state of the music player and pauses it when the timer is up
/// timer is cancelled when the music player is paused or stopped
class SleepTimer {
  /// The duration after which the music player will be paused
  Duration _duration;

  Duration get duration => _duration;

  set duration(Duration value) {
    _duration = value;
    reset();
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
          reset();
        }
      }),
    );

    /// pause the player when the timer is up
    _subscriptions.add(
      player.playerStateStream.listen((state) {
        if (state.playing && timer == null) {
          startTimer();
        } else if (!state.playing) {
          reset();
        }
      }),
    );

    debugPrint('SleepTimer created with duration: $duration');
  }

  /// resets the timer
  void reset() {
    if (timer != null) {
      timer!.cancel();
      debugPrint(
        'SleepTimer cancelled timer, remaining time: $remainingTime, duration: $duration',
      );
      timer = null;
    }
  }

  /// starts the timer with the given duration or the default duration
  void startTimer([
    Duration? forDuration,
  ]) {
    reset();
    duration = forDuration ?? duration;
    timer = Timer(duration, () {
      player.pause();
      reset();
      debugPrint('SleepTimer paused player after $duration');
    });
    startedAt = DateTime.now();
    debugPrint('SleepTimer started for $duration at $startedAt');
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
    reset();
    for (var sub in _subscriptions) {
      sub.cancel();
    }
    debugPrint('SleepTimer disposed');
  }
}
