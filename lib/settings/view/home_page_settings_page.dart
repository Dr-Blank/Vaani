import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_settings_ui/flutter_settings_ui.dart';
import 'package:vaani/settings/app_settings_provider.dart';
import 'package:vaani/settings/view/simple_settings_page.dart'
    show SimpleSettingsPage;

class HomePageSettingsPage extends HookConsumerWidget {
  const HomePageSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appSettings = ref.watch(appSettingsProvider);
    final appSettingsNotifier = ref.read(appSettingsProvider.notifier);

    return SimpleSettingsPage(
      title: Text('Home Page Settings'),
      sections: [
        SettingsSection(
          tiles: [
            SettingsTile.switchTile(
              title: const Text('Show play button on continue shelves'),
              initialValue:
                  appSettings.homePageSettings.showPlayButtonOnContinueShelves,
              onToggle: (value) {
                appSettingsNotifier.update(
                  appSettings.copyWith(
                    homePageSettings: appSettings.homePageSettings.copyWith(
                      showPlayButtonOnContinueShelves: value,
                    ),
                  ),
                );
              },
            ),
            SettingsTile.switchTile(
              title: const Text('Show play button on all shelves'),
              initialValue:
                  appSettings.homePageSettings.showPlayButtonOnAllShelves,
              onToggle: (value) {
                appSettingsNotifier.update(
                  appSettings.copyWith(
                    homePageSettings: appSettings.homePageSettings.copyWith(
                      showPlayButtonOnAllShelves: value,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
