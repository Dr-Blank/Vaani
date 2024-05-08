// a freezed class to store the settings of the app

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:whispering_pages/settings/models/audiobookshelf_server.dart';
import 'package:whispering_pages/settings/models/authenticated_user.dart';

part 'api_settings.freezed.dart';
part 'api_settings.g.dart';

/// stores the settings for the active server and user
///
/// all settings that are needed to interact with the server are stored here
@freezed
class ApiSettings with _$ApiSettings {
  const factory ApiSettings({
    AudiobookShelfServer? activeServer,
    AuthenticatedUser? activeUser,
    String? activeLibraryId,
  }) = _ApiSettings;

  factory ApiSettings.fromJson(Map<String, dynamic> json) =>
      _$ApiSettingsFromJson(json);
}
