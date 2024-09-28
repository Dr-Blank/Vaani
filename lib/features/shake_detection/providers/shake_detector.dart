import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:logging/logging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vaani/features/player/providers/audiobook_player.dart'
    show audiobookPlayerProvider, simpleAudiobookPlayerProvider;
import 'package:vaani/features/sleep_timer/providers/sleep_timer_provider.dart'
    show sleepTimerProvider;
import 'package:vaani/settings/app_settings_provider.dart'
    show appSettingsProvider;
import 'package:vaani/settings/models/app_settings.dart';
import 'package:vibration/vibration.dart';

import '../core/shake_detector.dart' as core;

part 'shake_detector.g.dart';

Logger _logger = Logger('ShakeDetector');

@riverpod
class ShakeDetector extends _$ShakeDetector {
  @override
  core.ShakeDetector? build() {
    final appSettings = ref.watch(appSettingsProvider);
    final shakeDetectionSettings = appSettings.shakeDetectionSettings;

    if (!shakeDetectionSettings.isEnabled) {
      _logger.fine('Shake detection is disabled');
      return null;
    }
    final player = ref.watch(audiobookPlayerProvider);
    if (!player.playing && !shakeDetectionSettings.isActiveWhenPaused) {
      _logger.fine(
        'Shake detection is disabled when paused and player is not playing',
      );
      return null;
    }
    // if sleep timer is not enabled, shake detection should not be enabled
    final sleepTimer = ref.watch(sleepTimerProvider);
    if (!shakeDetectionSettings.isPlaybackManagementEnabled &&
        sleepTimer == null) {
      _logger.fine('No playback management is enabled and sleep timer is off, '
          'so shake detection is disabled');
      return null;
    }

    _logger.fine('Creating shake detector');
    final detector = core.ShakeDetector(
      shakeDetectionSettings,
      () {
        doShakeAction(
          shakeDetectionSettings.shakeAction,
          ref: ref,
        );
        shakeDetectionSettings.feedback.forEach(postShakeFeedback);
      },
    );
    ref.onDispose(detector.dispose);
    return detector;
  }

  void doShakeAction(
    ShakeAction shakeAction, {
    required Ref ref,
  }) {
    final player = ref.watch(simpleAudiobookPlayerProvider);
    switch (shakeAction) {
      case ShakeAction.sleepTimerReset:
        _logger.fine('Resetting sleep timer');
        ref.read(sleepTimerProvider.notifier).restartTimer();
        break;
      case ShakeAction.fastForward:
        _logger.fine('Fast forwarding');
        player.seek(player.position + const Duration(seconds: 30));
        break;
      case ShakeAction.rewind:
        _logger.fine('Rewinding');
        player.seek(player.position - const Duration(seconds: 30));
        break;
      case ShakeAction.playPause:
        if (player.book == null) {
          _logger.warning('No book is loaded');
          break;
        }
        player.togglePlayPause();
        break;
      default:
        break;
    }
  }

  Future<void> postShakeFeedback(ShakeDetectedFeedback feedback) async {
    switch (feedback) {
      case ShakeDetectedFeedback.vibrate:
        _logger.fine('Vibrating');

        if (await Vibration.hasAmplitudeControl() ?? false) {
          Vibration.vibrate(amplitude: 128, duration: 200);
          break;
        }

        if (await Vibration.hasVibrator() ?? false) {
          Vibration.vibrate();
          break;
        }

        _logger.warning('No vibration support');

        break;
      case ShakeDetectedFeedback.beep:
        _logger.fine('Beeping');
        final player = AudioPlayer();
        await player.setAsset('assets/sounds/beep.mp3');
        await player.setVolume(0.5);
        await player.play();
        await player.dispose();
        break;
      default:
        break;
    }
  }
}

extension on ShakeDetectionSettings {
  bool get isActiveWhenPaused {
    // If the shake action is play/pause, it should be required when not playing
    return shakeAction == ShakeAction.playPause;
  }

  bool get isPlaybackManagementEnabled {
    return {ShakeAction.playPause, ShakeAction.fastForward, ShakeAction.rewind}
        .contains(shakeAction);
  }

  bool get shouldActOnSleepTimer {
    return {ShakeAction.sleepTimerReset}.contains(shakeAction);
  }
}
