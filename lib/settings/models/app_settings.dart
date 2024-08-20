// a freezed class to store the settings of the app

import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_settings.freezed.dart';
part 'app_settings.g.dart';

/// stores the settings of the app
///
/// only the visual settings are stored here
@freezed
class AppSettings with _$AppSettings {
  const factory AppSettings({
    @Default(true) bool isDarkMode,
    @Default(true) bool useMaterialThemeOnItemPage,
    @Default(PlayerSettings()) PlayerSettings playerSettings,
    @Default(DownloadSettings()) DownloadSettings downloadSettings,
  }) = _AppSettings;

  factory AppSettings.fromJson(Map<String, dynamic> json) =>
      _$AppSettingsFromJson(json);
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
    @Default([0.75, 1, 1.25, 1.5, 1.75, 2]) List<double> speedOptions,
    @Default(SleepTimerSettings()) SleepTimerSettings sleepTimerSettings,
    @Default(Duration(seconds: 10)) Duration playbackReportInterval,
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

enum SleepTimerShakeSenseMode { never, always, nearEnds }

@freezed
class SleepTimerSettings with _$SleepTimerSettings {
  const factory SleepTimerSettings({
    @Default(Duration(minutes: 15)) Duration defaultDuration,
    @Default(SleepTimerShakeSenseMode.always)
    SleepTimerShakeSenseMode shakeSenseMode,

    /// the duration in which the shake is detected before the end of the timer and after the timer ends
    /// only used if [shakeSenseMode] is [SleepTimerShakeSenseMode.nearEnds]
    @Default(Duration(seconds: 30)) Duration shakeSenseDuration,
    @Default(true) bool vibrateWhenReset,
    @Default(false) bool beepWhenReset,
    @Default(false) bool fadeOutAudio,
    @Default(0.5) double shakeDetectThreshold,

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
    @Default(true) bool alwaysAutoTurnOnTimer,

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
