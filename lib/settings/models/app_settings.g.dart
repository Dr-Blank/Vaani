// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppSettingsImpl _$$AppSettingsImplFromJson(Map<String, dynamic> json) =>
    _$AppSettingsImpl(
      isDarkMode: json['isDarkMode'] as bool? ?? true,
      useMaterialThemeOnItemPage:
          json['useMaterialThemeOnItemPage'] as bool? ?? false,
      playerSettings: json['playerSettings'] == null
          ? const PlayerSettings()
          : PlayerSettings.fromJson(
              json['playerSettings'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$AppSettingsImplToJson(_$AppSettingsImpl instance) =>
    <String, dynamic>{
      'isDarkMode': instance.isDarkMode,
      'useMaterialThemeOnItemPage': instance.useMaterialThemeOnItemPage,
      'playerSettings': instance.playerSettings,
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
      sleepTimerSettings: json['sleepTimerSettings'] == null
          ? const SleepTimerSettings()
          : SleepTimerSettings.fromJson(
              json['sleepTimerSettings'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$PlayerSettingsImplToJson(
        _$PlayerSettingsImpl instance) =>
    <String, dynamic>{
      'miniPlayerSettings': instance.miniPlayerSettings,
      'expandedPlayerSettings': instance.expandedPlayerSettings,
      'preferredDefaultVolume': instance.preferredDefaultVolume,
      'preferredDefaultSpeed': instance.preferredDefaultSpeed,
      'speedOptions': instance.speedOptions,
      'sleepTimerSettings': instance.sleepTimerSettings,
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
