import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:whispering_pages/features/player/providers/audiobook_player.dart';
import 'package:whispering_pages/features/sleep_timer/core/sleep_timer.dart'
    as core;
import 'package:whispering_pages/settings/app_settings_provider.dart';
import 'package:whispering_pages/shared/extensions/time_of_day.dart';

part 'sleep_timer_provider.g.dart';

@Riverpod(keepAlive: true)
class SleepTimer extends _$SleepTimer {
  @override
  core.SleepTimer? build() {
    final appSettings = ref.watch(appSettingsProvider);
    final sleepTimerSettings = appSettings.playerSettings.sleepTimerSettings;
    bool isEnabled = sleepTimerSettings.autoTurnOnTimer;
    if (!isEnabled) {
      return null;
    }

    if ((!sleepTimerSettings.alwaysAutoTurnOnTimer) &&
        (sleepTimerSettings.autoTurnOnTime
                .toTimeOfDay()
                .isAfter(TimeOfDay.now()) &&
            sleepTimerSettings.autoTurnOffTime
                .toTimeOfDay()
                .isBefore(TimeOfDay.now()))) {
      return null;
    }

    var sleepTimer = core.SleepTimer(
      // duration: sleepTimerSettings.defaultDuration,
      duration: const Duration(seconds: 5),
      player: ref.watch(simpleAudiobookPlayerProvider),
    );
    ref.onDispose(sleepTimer.dispose);
    return sleepTimer;
  }

  void setTimer(Duration resultingDuration) {
    if (state != null) {
      state!.duration = resultingDuration;
      ref.notifyListeners();
    } else {
      final timer = core.SleepTimer(
        duration: resultingDuration,
        player: ref.watch(simpleAudiobookPlayerProvider),
      );
      ref.onDispose(timer.dispose);
      state = timer;
    }
  }

  void cancelTimer() {
    state?.dispose();
    state = null;
  }
}
