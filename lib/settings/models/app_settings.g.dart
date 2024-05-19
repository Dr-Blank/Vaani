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
      preferredVolume: (json['preferredVolume'] as num?)?.toDouble() ?? 1,
      preferredSpeed: (json['preferredSpeed'] as num?)?.toDouble() ?? 1,
      sleepTimer: json['sleepTimer'] == null
          ? const Duration(minutes: 15)
          : Duration(microseconds: (json['sleepTimer'] as num).toInt()),
    );

Map<String, dynamic> _$$PlayerSettingsImplToJson(
        _$PlayerSettingsImpl instance) =>
    <String, dynamic>{
      'miniPlayerSettings': instance.miniPlayerSettings,
      'expandedPlayerSettings': instance.expandedPlayerSettings,
      'preferredVolume': instance.preferredVolume,
      'preferredSpeed': instance.preferredSpeed,
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
