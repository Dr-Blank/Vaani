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
          title: const Text('Quick Play'),
          margin: const EdgeInsetsDirectional.symmetric(
            horizontal: 16.0,
            vertical: 8.0,
          ),
          tiles: [
            SettingsTile.switchTile(
              initialValue: appSettings
                  .homePageSettings.showPlayButtonOnContinueListeningShelf,
              title: const Text('Continue Listening'),
              leading: const Icon(Icons.play_arrow),
              description: const Text(
                'Show play button for books in currently listening shelf',
              ),
              onToggle: (value) {
                appSettingsNotifier.update(
                  appSettings.copyWith(
                    homePageSettings: appSettings.homePageSettings.copyWith(
                      showPlayButtonOnContinueListeningShelf: value,
                    ),
                  ),
                );
              },
            ),
            SettingsTile.switchTile(
              title: const Text('Continue Series'),
              leading: const Icon(Icons.play_arrow),
              description: const Text(
                'Show play button for books in continue series shelf',
              ),
              initialValue: appSettings
                  .homePageSettings.showPlayButtonOnContinueSeriesShelf,
              onToggle: (value) {
                appSettingsNotifier.update(
                  appSettings.copyWith(
                    homePageSettings: appSettings.homePageSettings.copyWith(
                      showPlayButtonOnContinueSeriesShelf: value,
                    ),
                  ),
                );
              },
            ),
            SettingsTile.switchTile(
              title: const Text('Other shelves'),
              leading: const Icon(Icons.all_inclusive),
              description: const Text(
                'Show play button for all books in all remaining shelves',
              ),
              initialValue: appSettings
                  .homePageSettings.showPlayButtonOnAllRemainingShelves,
              onToggle: (value) {
                appSettingsNotifier.update(
                  appSettings.copyWith(
                    homePageSettings: appSettings.homePageSettings.copyWith(
                      showPlayButtonOnAllRemainingShelves: value,
                    ),
                  ),
                );
              },
            ),
            SettingsTile.switchTile(
              title: const Text('Listen Again'),
              leading: const Icon(Icons.replay),
              description: const Text(
                'Show play button for all books in listen again shelf',
              ),
              initialValue:
                  appSettings.homePageSettings.showPlayButtonOnListenAgainShelf,
              onToggle: (value) {
                appSettingsNotifier.update(
                  appSettings.copyWith(
                    homePageSettings: appSettings.homePageSettings.copyWith(
                      showPlayButtonOnListenAgainShelf: value,
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
