import 'package:hive/hive.dart';
import 'package:vaani/features/per_book_settings/models/book_settings.dart';
import 'package:vaani/settings/models/models.dart';

// register all models to Hive for serialization
Future registerModels() async {
  Hive.registerAdapter<AppSettings>(
    'AppSettings',
    ((json) => AppSettings.fromJson(json)),
  );
  Hive.registerAdapter<ApiSettings>(
    'ApiSettings',
    ((json) => ApiSettings.fromJson(json)),
  );
  Hive.registerAdapter<AudiobookShelfServer>(
    'AudiobookShelfServer',
    ((json) => AudiobookShelfServer.fromJson(json)),
  );
  Hive.registerAdapter<AuthenticatedUser>(
    'AuthenticatedUser',
    ((json) => AuthenticatedUser.fromJson(json)),
  );
  Hive.registerAdapter<BookSettings>(
    'BookSettings',
    ((json) => BookSettings.fromJson(json)),
  );
  Hive.registerAdapter<BookSettings>(
    '_\$BookSettingsImpl', // hack because of freezed
    ((json) => BookSettings.fromJson(json)),
  );
}
