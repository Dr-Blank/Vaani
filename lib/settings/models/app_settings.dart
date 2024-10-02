// a freezed class to store the settings of the app

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_settings.freezed.dart';
part 'app_settings.g.dart';

/// stores the settings of the app
///
/// only the visual settings are stored here
@freezed
class AppSettings with _$AppSettings {
  const factory AppSettings({
    @Default(ThemeSettings()) ThemeSettings themeSettings,
    @Default(PlayerSettings()) PlayerSettings playerSettings,
    @Default(SleepTimerSettings()) SleepTimerSettings sleepTimerSettings,
    @Default(DownloadSettings()) DownloadSettings downloadSettings,
    @Default(NotificationSettings()) NotificationSettings notificationSettings,
    @Default(ShakeDetectionSettings())
    ShakeDetectionSettings shakeDetectionSettings,
  }) = _AppSettings;

  factory AppSettings.fromJson(Map<String, dynamic> json) =>
      _$AppSettingsFromJson(json);
}

@freezed
class ThemeSettings with _$ThemeSettings {
  const factory ThemeSettings({
    @Default(true) bool isDarkMode,
    @Default(true) bool useMaterialThemeOnItemPage,
    @Default(true) bool useCurrentPlayerThemeThroughoutApp,
  }) = _ThemeSettings;

  factory ThemeSettings.fromJson(Map<String, dynamic> json) =>
      _$ThemeSettingsFromJson(json);
}

@freezed
class PlayerSettings with _$PlayerSettings {
  const factory PlayerSettings({
    @Default(MinimizedPlayerSettings())
    MinimizedPlayerSettings miniPlayerSettings,
    @Default(ExpandedPlayerSettings())
    ExpandedPlayerSettings expandedPlayerSettings,
    @Default(1) double preferredDefaultVolume,
    @Default(1) double preferredDefaultSpeed,
    @Default([1, 1.25, 1.5, 1.75, 2]) List<double> speedOptions,
    @Default(0.05) double speedIncrement,
    @Default(0.1) double minSpeed,
    @Default(4) double maxSpeed,
    @Default(Duration(seconds: 10)) Duration minimumPositionForReporting,
    @Default(Duration(seconds: 10)) Duration playbackReportInterval,
    @Default(Duration(seconds: 15)) Duration markCompleteWhenTimeLeft,
    @Default(true) bool configurePlayerForEveryBook,
  }) = _PlayerSettings;

  factory PlayerSettings.fromJson(Map<String, dynamic> json) =>
      _$PlayerSettingsFromJson(json);
}

@freezed
class ExpandedPlayerSettings with _$ExpandedPlayerSettings {
  const factory ExpandedPlayerSettings({
    @Default(false) bool showTotalProgress,
    @Default(true) bool showChapterProgress,
  }) = _ExpandedPlayerSettings;

  factory ExpandedPlayerSettings.fromJson(Map<String, dynamic> json) =>
      _$ExpandedPlayerSettingsFromJson(json);
}

@freezed
class MinimizedPlayerSettings with _$MinimizedPlayerSettings {
  const factory MinimizedPlayerSettings({
    @Default(false) bool useChapterInfo,
  }) = _MinimizedPlayerSettings;

  factory MinimizedPlayerSettings.fromJson(Map<String, dynamic> json) =>
      _$MinimizedPlayerSettingsFromJson(json);
}

@freezed
class SleepTimerSettings with _$SleepTimerSettings {
  const factory SleepTimerSettings({
    @Default(Duration(minutes: 15)) Duration defaultDuration,
    @Default(
      [
        Duration(minutes: 5),
        Duration(minutes: 10),
        Duration(minutes: 15),
        Duration(minutes: 20),
        Duration(minutes: 30),
      ],
    )
    List<Duration> presetDurations,
    @Default(Duration(minutes: 100)) Duration maxDuration,
    @Default(false) bool fadeOutAudio,
    @Default(Duration(seconds: 20)) Duration fadeOutDuration,

    /// if true, the player will automatically rewind the audio when the sleep timer is stopped
    @Default(false) bool autoRewindWhenStopped,

    /// the key is the duration in minutes
    @Default({
      5: Duration(seconds: 10),
      15: Duration(seconds: 30),
      45: Duration(seconds: 45),
      60: Duration(minutes: 1),
      120: Duration(minutes: 2),
    })
    Map<int, Duration> autoRewindDurations,

    /// auto turn on timer settings
    @Default(false) bool autoTurnOnTimer,

    /// always auto turn on timer settings or during specific times
    @Default(false) bool alwaysAutoTurnOnTimer,

    /// auto timer settings, only used if [alwaysAutoTurnOnTimer] is false
    ///
    /// duration is the time from 00:00
    @Default(Duration(hours: 22, minutes: 0)) Duration autoTurnOnTime,
    @Default(Duration(hours: 6, minutes: 0)) Duration autoTurnOffTime,
  }) = _SleepTimerSettings;

  factory SleepTimerSettings.fromJson(Map<String, dynamic> json) =>
      _$SleepTimerSettingsFromJson(json);
}

@freezed
class DownloadSettings with _$DownloadSettings {
  const factory DownloadSettings({
    @Default(true) bool requiresWiFi,
    @Default(3) int retries,
    @Default(true) bool allowPause,
    @Default(3) int maxConcurrent,
    @Default(3) int maxConcurrentByHost,
    @Default(3) int maxConcurrentByGroup,
  }) = _DownloadSettings;

  factory DownloadSettings.fromJson(Map<String, dynamic> json) =>
      _$DownloadSettingsFromJson(json);
}

@freezed
class NotificationSettings with _$NotificationSettings {
  const factory NotificationSettings({
    @Default(Duration(seconds: 30)) Duration fastForwardInterval,
    @Default(Duration(seconds: 10)) Duration rewindInterval,
    @Default(true) bool progressBarIsChapterProgress,
    @Default('\$bookTitle') String primaryTitle,
    @Default('\$author') String secondaryTitle,
    @Default(
      [
        NotificationMediaControl.rewind,
        NotificationMediaControl.fastForward,
        NotificationMediaControl.skipToPreviousChapter,
        NotificationMediaControl.skipToNextChapter,
      ],
    )
    List<NotificationMediaControl> mediaControls,
  }) = _NotificationSettings;

  factory NotificationSettings.fromJson(Map<String, dynamic> json) =>
      _$NotificationSettingsFromJson(json);
}

enum NotificationTitleType {
  chapterTitle,
  bookTitle,
  author,
  subtitle,
  series,
  narrator,
  year,
}

enum NotificationMediaControl {
  fastForward(Icons.fast_forward),
  rewind(Icons.fast_rewind),
  speedToggle(Icons.speed),
  stop(Icons.stop),
  skipToNextChapter(Icons.skip_next),
  skipToPreviousChapter(Icons.skip_previous);

  const NotificationMediaControl(this.icon);

  final IconData icon;
}

/// Shake Detection Settings
@freezed
class ShakeDetectionSettings with _$ShakeDetectionSettings {
  const factory ShakeDetectionSettings({
    @Default(true) bool isEnabled,
    @Default(ShakeDirection.horizontal) ShakeDirection direction,
    @Default(5) double threshold,
    @Default(ShakeAction.resetSleepTimer) ShakeAction shakeAction,
    @Default({ShakeDetectedFeedback.vibrate})
    Set<ShakeDetectedFeedback> feedback,
    @Default(0.5) double beepVolume,

    /// the duration to wait before the shake detection is enabled again
    @Default(Duration(seconds: 2)) Duration shakeTriggerCoolDown,

    /// the number of shakes required to trigger the action
    @Default(2) int shakeTriggerCount,

    /// acceleration sampling interval
    @Default(Duration(milliseconds: 100)) Duration samplingPeriod,
  }) = _ShakeDetectionSettings;

  factory ShakeDetectionSettings.fromJson(Map<String, dynamic> json) =>
      _$ShakeDetectionSettingsFromJson(json);
}

enum ShakeDirection { horizontal, vertical }

enum ShakeAction {
  none,
  playPause,
  resetSleepTimer,
  fastForward,
  rewind,
}

enum ShakeDetectedFeedback { vibrate, beep }
