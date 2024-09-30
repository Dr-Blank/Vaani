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
  bool wasPlayerLoaded = false;

  @override
  core.ShakeDetector? build() {
    final appSettings = ref.watch(appSettingsProvider);
    final shakeDetectionSettings = appSettings.shakeDetectionSettings;

    if (!shakeDetectionSettings.isEnabled) {
      _logger.config('Shake detection is disabled');
      return null;
    }

    // if no book is loaded, shake detection should not be enabled
    final player = ref.watch(simpleAudiobookPlayerProvider);
    player.playerStateStream.listen((event) {
      if (event.processingState == ProcessingState.idle && wasPlayerLoaded) {
        _logger.config('Player is now not loaded, invalidating');
        wasPlayerLoaded = false;
        ref.invalidateSelf();
      }
      if (event.processingState != ProcessingState.idle && !wasPlayerLoaded) {
        _logger.config('Player is now loaded, invalidating');
        wasPlayerLoaded = true;
        ref.invalidateSelf();
      }
    });

    if (player.book == null) {
      _logger.config('No book is loaded, disabling shake detection');
      wasPlayerLoaded = false;
      return null;
    } else {
      _logger.finer('Book is loaded, marking player as loaded');
      wasPlayerLoaded = true;
    }

    // if sleep timer is not enabled, shake detection should not be enabled
    final sleepTimer = ref.watch(sleepTimerProvider);
    if (!shakeDetectionSettings.shakeAction.isPlaybackManagementEnabled &&
        sleepTimer == null) {
      _logger
          .config('No playback management is enabled and sleep timer is off, '
              'so shake detection is disabled');
      return null;
    }

    _logger.config('Creating shake detector');
    final detector = core.ShakeDetector(
      shakeDetectionSettings,
      () {
        final wasActionComplete = doShakeAction(
          shakeDetectionSettings.shakeAction,
          ref: ref,
        );
        if (wasActionComplete) {
          shakeDetectionSettings.feedback.forEach(postShakeFeedback);
        }
      },
    );
    ref.onDispose(detector.dispose);
    return detector;
  }

  /// Perform the shake action and return whether the action was successful
  bool doShakeAction(
    ShakeAction shakeAction, {
    required Ref ref,
  }) {
    final player = ref.read(simpleAudiobookPlayerProvider);
    if (player.book == null && shakeAction.isPlaybackManagementEnabled) {
      _logger.warning('No book is loaded');
      return false;
    }
    switch (shakeAction) {
      case ShakeAction.resetSleepTimer:
        _logger.fine('Resetting sleep timer');
        var sleepTimer = ref.read(sleepTimerProvider);
        if (sleepTimer == null || !sleepTimer.isActive) {
          _logger.warning('No sleep timer is running');
          return false;
        }
        sleepTimer.restartTimer();
        return true;
      case ShakeAction.fastForward:
        _logger.fine('Fast forwarding');
        if (!player.playing) {
          _logger.warning('Player is not playing');
          return false;
        }
        player.seek(player.position + const Duration(seconds: 30));
        return true;
      case ShakeAction.rewind:
        _logger.fine('Rewinding');
        if (!player.playing) {
          _logger.warning('Player is not playing');
          return false;
        }
        player.seek(player.position - const Duration(seconds: 30));
        return true;
      case ShakeAction.playPause:
        _logger.fine('Toggling play/pause');
        player.togglePlayPause();
        return true;
      default:
        return false;
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

extension on ShakeAction {
  bool get isActiveWhenPaused {
    // If the shake action is play/pause, it should be required when not playing
    return this == ShakeAction.playPause;
  }

  bool get isPlaybackManagementEnabled {
    return {ShakeAction.playPause, ShakeAction.fastForward, ShakeAction.rewind}
        .contains(this);
  }

  bool get shouldActOnSleepTimer {
    return {ShakeAction.resetSleepTimer}.contains(this);
  }
}
