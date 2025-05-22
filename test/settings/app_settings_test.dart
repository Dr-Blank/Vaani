import 'package:flutter_test/flutter_test.dart';
import 'package:vaani/settings/models/app_settings.dart';

void main() {
  group('AppSettings', () {
    test('initializes with default HomePageSettings', () {
      const appSettings = AppSettings();
      expect(appSettings.homePageSettings.showPlayButtonOnContinueShelves, isTrue);
      expect(appSettings.homePageSettings.showPlayButtonOnAllShelves, isFalse);
    });

    test('HomePageSettings can be updated', () {
      const initialSettings = AppSettings();
      final updatedSettings = initialSettings.copyWith(
        homePageSettings: initialSettings.homePageSettings.copyWith(
          showPlayButtonOnContinueShelves: false,
          showPlayButtonOnAllShelves: true,
        ),
      );

      expect(updatedSettings.homePageSettings.showPlayButtonOnContinueShelves, isFalse);
      expect(updatedSettings.homePageSettings.showPlayButtonOnAllShelves, isTrue);
    });

    test('HomePageSettings are correctly serialized and deserialized', () {
      const originalSettings = AppSettings(
        homePageSettings: HomePageSettings(
          showPlayButtonOnContinueShelves: false,
          showPlayButtonOnAllShelves: true,
        ),
      );

      final json = originalSettings.toJson();
      final deserializedSettings = AppSettings.fromJson(json);

      expect(deserializedSettings.homePageSettings.showPlayButtonOnContinueShelves, isFalse);
      expect(deserializedSettings.homePageSettings.showPlayButtonOnAllShelves, isTrue);
      expect(deserializedSettings, originalSettings);
    });

    test('Default AppSettings serialization and deserialization', () {
      const originalSettings = AppSettings();
      final json = originalSettings.toJson();
      final deserializedSettings = AppSettings.fromJson(json);

      expect(deserializedSettings.homePageSettings.showPlayButtonOnContinueShelves, isTrue);
      expect(deserializedSettings.homePageSettings.showPlayButtonOnAllShelves, isFalse);
      expect(deserializedSettings, originalSettings);
    });
  });
}
