import 'package:flutter/foundation.dart' show immutable;
import 'package:hive/hive.dart';
import 'package:vaani/features/per_book_settings/models/book_settings.dart';
import 'package:vaani/settings/models/models.dart';

@immutable
class AvailableHiveBoxes {
  const AvailableHiveBoxes._();

  /// Box for storing user preferences as [AppSettings]
  static final userPrefsBox = Hive.box<AppSettings>(name: 'userPrefs');

  /// Box for storing [ApiSettings]
  static final apiSettingsBox = Hive.box<ApiSettings>(name: 'apiSettings');

  /// stores the a list of [AudiobookShelfServer]
  static final serverBox =
      Hive.box<AudiobookShelfServer>(name: 'audiobookShelfServer');

  /// stores the a list of [AuthenticatedUser]
  static final authenticatedUserBox =
      Hive.box<AuthenticatedUser>(name: 'authenticatedUser');

  /// stores the a list of [BookSettings]
  static final individualBookSettingsBox =
      Hive.box<BookSettings>(name: 'bookSettings');
}
