import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:whispering_pages/features/player/providers/audiobook_player.dart';
import 'package:whispering_pages/features/sleep_timer/core/sleep_timer.dart';
import 'package:whispering_pages/settings/app_settings_provider.dart';

part 'sleep_timer_provider.g.dart';

@Riverpod(keepAlive: true)
SleepTimer? sleepTimer(SleepTimerRef ref) {
  final appSettings = ref.watch(appSettingsProvider);
  final sleepTimerSettings = appSettings.playerSettings.sleepTimerSettings;
  var sleepTimer = SleepTimer(
    // duration: sleepTimerSettings.defaultDuration,
    duration: const Duration(seconds: 5),
    player: ref.watch(simpleAudiobookPlayerProvider),
  );
  ref.onDispose(sleepTimer.dispose);
  return sleepTimer;
}
