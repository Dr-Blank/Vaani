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
    @Default(false) bool useMaterialThemeOnItemPage,
    @Default(PlayerSettings()) PlayerSettings playerSettings,
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
    @Default([0.8, 1, 1.25, 1.5, 1.75, 2]) List<double> speedOptions,
    @Default(Duration(minutes: 15)) Duration sleepTimer,
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
