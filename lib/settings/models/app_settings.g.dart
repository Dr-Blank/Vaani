// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppSettingsImpl _$$AppSettingsImplFromJson(Map<String, dynamic> json) =>
    _$AppSettingsImpl(
      themeSettings: json['themeSettings'] == null
          ? const ThemeSettings()
          : ThemeSettings.fromJson(
              json['themeSettings'] as Map<String, dynamic>),
      playerSettings: json['playerSettings'] == null
          ? const PlayerSettings()
          : PlayerSettings.fromJson(
              json['playerSettings'] as Map<String, dynamic>),
      downloadSettings: json['downloadSettings'] == null
          ? const DownloadSettings()
          : DownloadSettings.fromJson(
              json['downloadSettings'] as Map<String, dynamic>),
      notificationSettings: json['notificationSettings'] == null
          ? const NotificationSettings()
          : NotificationSettings.fromJson(
              json['notificationSettings'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$AppSettingsImplToJson(_$AppSettingsImpl instance) =>
    <String, dynamic>{
      'themeSettings': instance.themeSettings,
      'playerSettings': instance.playerSettings,
      'downloadSettings': instance.downloadSettings,
      'notificationSettings': instance.notificationSettings,
    };

_$ThemeSettingsImpl _$$ThemeSettingsImplFromJson(Map<String, dynamic> json) =>
    _$ThemeSettingsImpl(
      isDarkMode: json['isDarkMode'] as bool? ?? true,
      useMaterialThemeOnItemPage:
          json['useMaterialThemeOnItemPage'] as bool? ?? true,
      useCurrentPlayerThemeThroughoutApp:
          json['useCurrentPlayerThemeThroughoutApp'] as bool? ?? true,
    );

Map<String, dynamic> _$$ThemeSettingsImplToJson(_$ThemeSettingsImpl instance) =>
    <String, dynamic>{
      'isDarkMode': instance.isDarkMode,
      'useMaterialThemeOnItemPage': instance.useMaterialThemeOnItemPage,
      'useCurrentPlayerThemeThroughoutApp':
          instance.useCurrentPlayerThemeThroughoutApp,
    };

_$PlayerSettingsImpl _$$PlayerSettingsImplFromJson(Map<String, dynamic> json) =>
    _$PlayerSettingsImpl(
      miniPlayerSettings: json['miniPlayerSettings'] == null
          ? const MinimizedPlayerSettings()
          : MinimizedPlayerSettings.fromJson(
              json['miniPlayerSettings'] as Map<String, dynamic>),
      expandedPlayerSettings: json['expandedPlayerSettings'] == null
          ? const ExpandedPlayerSettings()
          : ExpandedPlayerSettings.fromJson(
              json['expandedPlayerSettings'] as Map<String, dynamic>),
      preferredDefaultVolume:
          (json['preferredDefaultVolume'] as num?)?.toDouble() ?? 1,
      preferredDefaultSpeed:
          (json['preferredDefaultSpeed'] as num?)?.toDouble() ?? 1,
      speedOptions: (json['speedOptions'] as List<dynamic>?)
              ?.map((e) => (e as num).toDouble())
              .toList() ??
          const [0.75, 1, 1.25, 1.5, 1.75, 2],
      speedIncrement: (json['speedIncrement'] as num?)?.toDouble() ?? 0.05,
      minSpeed: (json['minSpeed'] as num?)?.toDouble() ?? 0.1,
      maxSpeed: (json['maxSpeed'] as num?)?.toDouble() ?? 4,
      sleepTimerSettings: json['sleepTimerSettings'] == null
          ? const SleepTimerSettings()
          : SleepTimerSettings.fromJson(
              json['sleepTimerSettings'] as Map<String, dynamic>),
      minimumPositionForReporting: json['minimumPositionForReporting'] == null
          ? const Duration(seconds: 10)
          : Duration(
              microseconds:
                  (json['minimumPositionForReporting'] as num).toInt()),
      playbackReportInterval: json['playbackReportInterval'] == null
          ? const Duration(seconds: 10)
          : Duration(
              microseconds: (json['playbackReportInterval'] as num).toInt()),
      markCompleteWhenTimeLeft: json['markCompleteWhenTimeLeft'] == null
          ? const Duration(seconds: 15)
          : Duration(
              microseconds: (json['markCompleteWhenTimeLeft'] as num).toInt()),
      configurePlayerForEveryBook:
          json['configurePlayerForEveryBook'] as bool? ?? true,
    );

Map<String, dynamic> _$$PlayerSettingsImplToJson(
        _$PlayerSettingsImpl instance) =>
    <String, dynamic>{
      'miniPlayerSettings': instance.miniPlayerSettings,
      'expandedPlayerSettings': instance.expandedPlayerSettings,
      'preferredDefaultVolume': instance.preferredDefaultVolume,
      'preferredDefaultSpeed': instance.preferredDefaultSpeed,
      'speedOptions': instance.speedOptions,
      'speedIncrement': instance.speedIncrement,
      'minSpeed': instance.minSpeed,
      'maxSpeed': instance.maxSpeed,
      'sleepTimerSettings': instance.sleepTimerSettings,
      'minimumPositionForReporting':
          instance.minimumPositionForReporting.inMicroseconds,
      'playbackReportInterval': instance.playbackReportInterval.inMicroseconds,
      'markCompleteWhenTimeLeft':
          instance.markCompleteWhenTimeLeft.inMicroseconds,
      'configurePlayerForEveryBook': instance.configurePlayerForEveryBook,
    };

_$ExpandedPlayerSettingsImpl _$$ExpandedPlayerSettingsImplFromJson(
        Map<String, dynamic> json) =>
    _$ExpandedPlayerSettingsImpl(
      showTotalProgress: json['showTotalProgress'] as bool? ?? false,
      showChapterProgress: json['showChapterProgress'] as bool? ?? true,
    );

Map<String, dynamic> _$$ExpandedPlayerSettingsImplToJson(
        _$ExpandedPlayerSettingsImpl instance) =>
    <String, dynamic>{
      'showTotalProgress': instance.showTotalProgress,
      'showChapterProgress': instance.showChapterProgress,
    };

_$MinimizedPlayerSettingsImpl _$$MinimizedPlayerSettingsImplFromJson(
        Map<String, dynamic> json) =>
    _$MinimizedPlayerSettingsImpl(
      useChapterInfo: json['useChapterInfo'] as bool? ?? false,
    );

Map<String, dynamic> _$$MinimizedPlayerSettingsImplToJson(
        _$MinimizedPlayerSettingsImpl instance) =>
    <String, dynamic>{
      'useChapterInfo': instance.useChapterInfo,
    };

_$SleepTimerSettingsImpl _$$SleepTimerSettingsImplFromJson(
        Map<String, dynamic> json) =>
    _$SleepTimerSettingsImpl(
      defaultDuration: json['defaultDuration'] == null
          ? const Duration(minutes: 15)
          : Duration(microseconds: (json['defaultDuration'] as num).toInt()),
      shakeSenseMode: $enumDecodeNullable(
              _$SleepTimerShakeSenseModeEnumMap, json['shakeSenseMode']) ??
          SleepTimerShakeSenseMode.always,
      shakeSenseDuration: json['shakeSenseDuration'] == null
          ? const Duration(seconds: 30)
          : Duration(microseconds: (json['shakeSenseDuration'] as num).toInt()),
      vibrateWhenReset: json['vibrateWhenReset'] as bool? ?? true,
      beepWhenReset: json['beepWhenReset'] as bool? ?? false,
      fadeOutAudio: json['fadeOutAudio'] as bool? ?? false,
      shakeDetectThreshold:
          (json['shakeDetectThreshold'] as num?)?.toDouble() ?? 0.5,
      autoRewindWhenStopped: json['autoRewindWhenStopped'] as bool? ?? false,
      autoRewindDurations:
          (json['autoRewindDurations'] as Map<String, dynamic>?)?.map(
                (k, e) => MapEntry(
                    int.parse(k), Duration(microseconds: (e as num).toInt())),
              ) ??
              const {
                5: Duration(seconds: 10),
                15: Duration(seconds: 30),
                45: Duration(seconds: 45),
                60: Duration(minutes: 1),
                120: Duration(minutes: 2)
              },
      autoTurnOnTimer: json['autoTurnOnTimer'] as bool? ?? false,
      alwaysAutoTurnOnTimer: json['alwaysAutoTurnOnTimer'] as bool? ?? true,
      autoTurnOnTime: json['autoTurnOnTime'] == null
          ? const Duration(hours: 22, minutes: 0)
          : Duration(microseconds: (json['autoTurnOnTime'] as num).toInt()),
      autoTurnOffTime: json['autoTurnOffTime'] == null
          ? const Duration(hours: 6, minutes: 0)
          : Duration(microseconds: (json['autoTurnOffTime'] as num).toInt()),
    );

Map<String, dynamic> _$$SleepTimerSettingsImplToJson(
        _$SleepTimerSettingsImpl instance) =>
    <String, dynamic>{
      'defaultDuration': instance.defaultDuration.inMicroseconds,
      'shakeSenseMode':
          _$SleepTimerShakeSenseModeEnumMap[instance.shakeSenseMode]!,
      'shakeSenseDuration': instance.shakeSenseDuration.inMicroseconds,
      'vibrateWhenReset': instance.vibrateWhenReset,
      'beepWhenReset': instance.beepWhenReset,
      'fadeOutAudio': instance.fadeOutAudio,
      'shakeDetectThreshold': instance.shakeDetectThreshold,
      'autoRewindWhenStopped': instance.autoRewindWhenStopped,
      'autoRewindDurations': instance.autoRewindDurations
          .map((k, e) => MapEntry(k.toString(), e.inMicroseconds)),
      'autoTurnOnTimer': instance.autoTurnOnTimer,
      'alwaysAutoTurnOnTimer': instance.alwaysAutoTurnOnTimer,
      'autoTurnOnTime': instance.autoTurnOnTime.inMicroseconds,
      'autoTurnOffTime': instance.autoTurnOffTime.inMicroseconds,
    };

const _$SleepTimerShakeSenseModeEnumMap = {
  SleepTimerShakeSenseMode.never: 'never',
  SleepTimerShakeSenseMode.always: 'always',
  SleepTimerShakeSenseMode.nearEnds: 'nearEnds',
};

_$DownloadSettingsImpl _$$DownloadSettingsImplFromJson(
        Map<String, dynamic> json) =>
    _$DownloadSettingsImpl(
      requiresWiFi: json['requiresWiFi'] as bool? ?? true,
      retries: (json['retries'] as num?)?.toInt() ?? 3,
      allowPause: json['allowPause'] as bool? ?? true,
      maxConcurrent: (json['maxConcurrent'] as num?)?.toInt() ?? 3,
      maxConcurrentByHost: (json['maxConcurrentByHost'] as num?)?.toInt() ?? 3,
      maxConcurrentByGroup:
          (json['maxConcurrentByGroup'] as num?)?.toInt() ?? 3,
    );

Map<String, dynamic> _$$DownloadSettingsImplToJson(
        _$DownloadSettingsImpl instance) =>
    <String, dynamic>{
      'requiresWiFi': instance.requiresWiFi,
      'retries': instance.retries,
      'allowPause': instance.allowPause,
      'maxConcurrent': instance.maxConcurrent,
      'maxConcurrentByHost': instance.maxConcurrentByHost,
      'maxConcurrentByGroup': instance.maxConcurrentByGroup,
    };

_$NotificationSettingsImpl _$$NotificationSettingsImplFromJson(
        Map<String, dynamic> json) =>
    _$NotificationSettingsImpl(
      fastForwardInterval: json['fastForwardInterval'] == null
          ? const Duration(seconds: 30)
          : Duration(
              microseconds: (json['fastForwardInterval'] as num).toInt()),
      rewindInterval: json['rewindInterval'] == null
          ? const Duration(seconds: 10)
          : Duration(microseconds: (json['rewindInterval'] as num).toInt()),
      progressBarIsChapterProgress:
          json['progressBarIsChapterProgress'] as bool? ?? true,
      primaryTitle: json['primaryTitle'] as String? ?? '\$bookTitle',
      secondaryTitle: json['secondaryTitle'] as String? ?? '\$author',
      mediaControls: (json['mediaControls'] as List<dynamic>?)
              ?.map((e) => $enumDecode(_$NotificationMediaControlEnumMap, e))
              .toList() ??
          const [
            NotificationMediaControl.rewind,
            NotificationMediaControl.fastForward,
            NotificationMediaControl.skipToPreviousChapter,
            NotificationMediaControl.skipToNextChapter
          ],
    );

Map<String, dynamic> _$$NotificationSettingsImplToJson(
        _$NotificationSettingsImpl instance) =>
    <String, dynamic>{
      'fastForwardInterval': instance.fastForwardInterval.inMicroseconds,
      'rewindInterval': instance.rewindInterval.inMicroseconds,
      'progressBarIsChapterProgress': instance.progressBarIsChapterProgress,
      'primaryTitle': instance.primaryTitle,
      'secondaryTitle': instance.secondaryTitle,
      'mediaControls': instance.mediaControls
          .map((e) => _$NotificationMediaControlEnumMap[e]!)
          .toList(),
    };

const _$NotificationMediaControlEnumMap = {
  NotificationMediaControl.fastForward: 'fastForward',
  NotificationMediaControl.rewind: 'rewind',
  NotificationMediaControl.speedToggle: 'speedToggle',
  NotificationMediaControl.stop: 'stop',
  NotificationMediaControl.skipToNextChapter: 'skipToNextChapter',
  NotificationMediaControl.skipToPreviousChapter: 'skipToPreviousChapter',
};
