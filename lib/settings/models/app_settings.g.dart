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
          const [0.8, 1, 1.25, 1.5, 1.75, 2],
      sleepTimer: json['sleepTimer'] == null
          ? const Duration(minutes: 15)
          : Duration(microseconds: (json['sleepTimer'] as num).toInt()),
    );

Map<String, dynamic> _$$PlayerSettingsImplToJson(
        _$PlayerSettingsImpl instance) =>
    <String, dynamic>{
      'miniPlayerSettings': instance.miniPlayerSettings,
      'expandedPlayerSettings': instance.expandedPlayerSettings,
      'preferredDefaultVolume': instance.preferredDefaultVolume,
      'preferredDefaultSpeed': instance.preferredDefaultSpeed,
      'speedOptions': instance.speedOptions,
      'sleepTimer': instance.sleepTimer.inMicroseconds,
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
