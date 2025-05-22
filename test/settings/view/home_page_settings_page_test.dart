import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:vaani/settings/models/app_settings.dart';
import 'package:vaani/settings/app_settings_provider.dart';
import 'package:vaani/settings/view/home_page_settings_page.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  // Helper function to pump HomePageSettingsPage
  Future<void> pumpHomePageSettingsPage({
    required WidgetTester tester,
    required AppSettings initialAppSettings,
    required ProviderContainer container,
  }) async {
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(
          home: HomePageSettingsPage(),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  group('HomePageSettingsPage Widget Tests', () {
    late ProviderContainer container;
    late AppSettingsNotifier appSettingsNotifier;

    setUp(() {
      // Initialize with default AppSettings
      appSettingsNotifier = AppSettingsNotifier(const AppSettings());
      container = ProviderContainer(
        overrides: [
          appSettingsProvider.overrideWithValue(appSettingsNotifier),
        ],
      );
    });

    tearDown(() {
      container.dispose();
    });

    testWidgets('Initial State: Switches reflect default AppSettings',
        (WidgetTester tester) async {
      await pumpHomePageSettingsPage(
        tester: tester,
        initialAppSettings: const AppSettings(), // Not strictly needed here as it's in setUp
        container: container,
      );

      // Find the SettingsList
      final settingsListFinder = find.byType(SettingsList);
      expect(settingsListFinder, findsOneWidget);

      // Find the switch tiles
      final switchTileFinders = find.byType(SettingsTile);
      expect(switchTileFinders, findsNWidgets(2));

      final continueShelvesSwitch = tester.widget<SettingsTile>(
        find.descendant(
          of: settingsListFinder,
          matching: find.widgetWithText(SettingsTile, 'Show play button on continue shelves'),
        ),
      );
      expect(continueShelvesSwitch.initialValue, isTrue);

      final allShelvesSwitch = tester.widget<SettingsTile>(
        find.descendant(
          of: settingsListFinder,
          matching: find.widgetWithText(SettingsTile, 'Show play button on all shelves'),
        ),
      );
      expect(allShelvesSwitch.initialValue, isFalse);
    });

    testWidgets('Toggle Switches: Updates AppSettings in provider',
        (WidgetTester tester) async {
      await pumpHomePageSettingsPage(
        tester: tester,
        initialAppSettings: const AppSettings(),
        container: container,
      );

      // Initial state check (from AppSettingsNotifier directly)
      expect(
        container.read(appSettingsProvider).homePageSettings.showPlayButtonOnContinueShelves,
        isTrue,
      );
      expect(
        container.read(appSettingsProvider).homePageSettings.showPlayButtonOnAllShelves,
        isFalse,
      );

      // Find and tap the first switch (Continue Shelves)
      final continueShelvesSwitchFinder = find.widgetWithText(SettingsTile, 'Show play button on continue shelves');
      expect(continueShelvesSwitchFinder, findsOneWidget);
      await tester.tap(continueShelvesSwitchFinder);
      await tester.pumpAndSettle(); // Allow state to update

      // Verify the AppSettingsProvider was updated
      expect(
        container.read(appSettingsProvider).homePageSettings.showPlayButtonOnContinueShelves,
        isFalse,
      );

      // Find and tap the second switch (All Shelves)
      final allShelvesSwitchFinder = find.widgetWithText(SettingsTile, 'Show play button on all shelves');
      expect(allShelvesSwitchFinder, findsOneWidget);
      await tester.tap(allShelvesSwitchFinder);
      await tester.pumpAndSettle(); // Allow state to update

      // Verify the AppSettingsProvider was updated
      expect(
        container.read(appSettingsProvider).homePageSettings.showPlayButtonOnAllShelves,
        isTrue,
      );

      // Tap them again to ensure they toggle back
      await tester.tap(continueShelvesSwitchFinder);
      await tester.pumpAndSettle();
      expect(
        container.read(appSettingsProvider).homePageSettings.showPlayButtonOnContinueShelves,
        isTrue,
      );

      await tester.tap(allShelvesSwitchFinder);
      await tester.pumpAndSettle();
      expect(
        container.read(appSettingsProvider).homePageSettings.showPlayButtonOnAllShelves,
        isFalse,
      );
    });
  });
}
