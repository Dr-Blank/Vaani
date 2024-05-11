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
  }) = _AppSettings;

  factory AppSettings.fromJson(Map<String, dynamic> json) =>
      _$AppSettingsFromJson(json);
}
