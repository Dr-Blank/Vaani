// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nullable_player_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NullablePlayerSettingsImpl _$$NullablePlayerSettingsImplFromJson(
        Map<String, dynamic> json) =>
    _$NullablePlayerSettingsImpl(
      miniPlayerSettings: json['miniPlayerSettings'] == null
          ? null
          : MinimizedPlayerSettings.fromJson(
              json['miniPlayerSettings'] as Map<String, dynamic>),
      expandedPlayerSettings: json['expandedPlayerSettings'] == null
          ? null
          : ExpandedPlayerSettings.fromJson(
              json['expandedPlayerSettings'] as Map<String, dynamic>),
      preferredDefaultVolume:
          (json['preferredDefaultVolume'] as num?)?.toDouble(),
      preferredDefaultSpeed:
          (json['preferredDefaultSpeed'] as num?)?.toDouble(),
      speedOptions: (json['speedOptions'] as List<dynamic>?)
          ?.map((e) => (e as num).toDouble())
          .toList(),
      sleepTimerSettings: json['sleepTimerSettings'] == null
          ? null
          : SleepTimerSettings.fromJson(
              json['sleepTimerSettings'] as Map<String, dynamic>),
      playbackReportInterval: json['playbackReportInterval'] == null
          ? null
          : Duration(
              microseconds: (json['playbackReportInterval'] as num).toInt()),
    );

Map<String, dynamic> _$$NullablePlayerSettingsImplToJson(
        _$NullablePlayerSettingsImpl instance) =>
    <String, dynamic>{
      'miniPlayerSettings': instance.miniPlayerSettings,
      'expandedPlayerSettings': instance.expandedPlayerSettings,
      'preferredDefaultVolume': instance.preferredDefaultVolume,
      'preferredDefaultSpeed': instance.preferredDefaultSpeed,
      'speedOptions': instance.speedOptions,
      'sleepTimerSettings': instance.sleepTimerSettings,
      'playbackReportInterval': instance.playbackReportInterval?.inMicroseconds,
    };
