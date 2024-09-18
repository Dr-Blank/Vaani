import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vaani/settings/models/app_settings.dart';

part 'nullable_player_settings.freezed.dart';
part 'nullable_player_settings.g.dart';

@freezed
class NullablePlayerSettings with _$NullablePlayerSettings {
  const factory NullablePlayerSettings({
    MinimizedPlayerSettings? miniPlayerSettings,
    ExpandedPlayerSettings? expandedPlayerSettings,
    double? preferredDefaultVolume,
    double? preferredDefaultSpeed,
    List<double>? speedOptions,
    SleepTimerSettings? sleepTimerSettings,
    Duration? playbackReportInterval,
  }) = _NullablePlayerSettings;

  factory NullablePlayerSettings.fromJson(Map<String, dynamic> json) =>
      _$NullablePlayerSettingsFromJson(json);
}
