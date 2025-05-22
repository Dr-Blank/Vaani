import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_settings_ui/flutter_settings_ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vaani/settings/app_settings_provider.dart';
import 'package:vaani/settings/view/buttons.dart';
import 'package:vaani/settings/view/simple_settings_page.dart';
import 'package:vaani/shared/extensions/enum.dart';

class ThemeSettingsPage extends HookConsumerWidget {
  const ThemeSettingsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appSettings = ref.watch(appSettingsProvider);
    final themeSettings = appSettings.themeSettings;
    final primaryColor = Theme.of(context).colorScheme.primary;

    return SimpleSettingsPage(
      title: const Text('Theme Settings'),
      sections: [
        SettingsSection(
          margin: const EdgeInsetsDirectional.symmetric(
            horizontal: 16.0,
            vertical: 8.0,
          ),
          tiles: [
            // choose system , light or dark theme
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: SegmentedButton<ThemeMode>(
                segments: [
                  ButtonSegment<ThemeMode>(
                    value: ThemeMode.light,
                    icon: Icon(
                      themeSettings.themeMode == ThemeMode.light
                          ? Icons.check
                          : Icons.light_mode,
                    ),
                    label: const Text('Light'),
                  ),
                  ButtonSegment<ThemeMode>(
                    value: ThemeMode.system,
                    icon: Icon(
                      themeSettings.themeMode == ThemeMode.system
                          ? Icons.check
                          : Icons.auto_awesome,
                    ),
                    label: const Text('System'),
                  ),
                  ButtonSegment<ThemeMode>(
                    value: ThemeMode.dark,
                    icon: Icon(
                      themeSettings.themeMode == ThemeMode.dark
                          ? Icons.check
                          : Icons.dark_mode,
                    ),
                    label: const Text('Dark'),
                  ),
                ],
                selected: {themeSettings.themeMode},
                onSelectionChanged: (Set<ThemeMode> newSelection) {
                  ref.read(appSettingsProvider.notifier).update(
                        appSettings.copyWith.themeSettings(
                          themeMode: newSelection.first,
                        ),
                      );
                },
              ),
            ),

            // high contrast mode
            SettingsTile.switchTile(
              leading: themeSettings.highContrast
                  ? const Icon(Icons.accessibility)
                  : const Icon(Icons.accessibility_new_outlined),
              initialValue: themeSettings.highContrast,
              title: const Text('High Contrast Mode'),
              description: const Text(
                'Increase the contrast between the background and the text',
              ),
              onToggle: (value) {
                ref.read(appSettingsProvider.notifier).update(
                      appSettings.copyWith.themeSettings(
                        highContrast: value,
                      ),
                    );
              },
            ),

            // use material theme from system
            SettingsTile.switchTile(
              initialValue: themeSettings.useMaterialThemeFromSystem,
              title: Platform.isAndroid
                  ? const Text('Use Material You')
                  : const Text('Material Theme from System'),
              description: const Text(
                'Use the system theme colors for the app',
              ),
              leading: themeSettings.useMaterialThemeFromSystem
                  ? const Icon(Icons.auto_awesome)
                  : const Icon(Icons.auto_fix_off),
              onToggle: (value) {
                ref.read(appSettingsProvider.notifier).update(
                      appSettings.copyWith.themeSettings(
                        useMaterialThemeFromSystem: value,
                      ),
                    );
              },
            ),

            // TODO choose the primary color
            // SettingsTile.navigation(
            //   title: const Text('Primary Color'),
            //   description: const Text(
            //     'Choose the primary color for the app',
            //   ),
            //   leading: const Icon(Icons.colorize),
            //   trailing: Icon(
            //     Icons.circle,
            //     color: themeSettings.customThemeColor.toColor(),
            //   ),
            //   onPressed: (context) async {
            //     final selectedColor = await showDialog<Color>(
            //       context: context,
            //       builder: (context) {
            //         return SimpleDialog(
            //           title: const Text('Select Primary Color'),
            //           children: [
            //             for (final color in Colors.primaries)
            //               SimpleDialogOption(
            //                 onPressed: () {
            //                   Navigator.pop(context, color);
            //                 },
            //                 child: Container(
            //                   color: color,
            //                   height: 48,
            //                 ),
            //               ),
            //           ],
            //         );
            //       },
            //     );
            //     if (selectedColor != null) {
            //       ref.read(appSettingsProvider.notifier).update(
            //             appSettings.copyWith.themeSettings(
            //               customThemeColor: selectedColor.toHexString(),
            //             ),
            //           );
            //     }
            //   },
            // ),

            // use theme throughout the app when playing item
            SettingsTile.switchTile(
              initialValue: themeSettings.useCurrentPlayerThemeThroughoutApp,
              title: const Text('Adapt theme from currently playing item'),
              description: const Text(
                'Use the theme colors from the currently playing item for the app',
              ),
              leading: themeSettings.useCurrentPlayerThemeThroughoutApp
                  ? const Icon(Icons.auto_fix_high)
                  : const Icon(Icons.auto_fix_off),
              onToggle: (value) {
                ref.read(appSettingsProvider.notifier).update(
                      appSettings.copyWith.themeSettings(
                        useCurrentPlayerThemeThroughoutApp: value,
                      ),
                    );
              },
            ),

            SettingsTile.switchTile(
              initialValue: themeSettings.useMaterialThemeOnItemPage,
              title: const Text('Adaptive Theme on Item Page'),
              description: const Text(
                'get fancy with the colors on the item page at the cost of some performance',
              ),
              leading: themeSettings.useMaterialThemeOnItemPage
                  ? const Icon(Icons.auto_fix_high)
                  : const Icon(Icons.auto_fix_off),
              onToggle: (value) {
                ref.read(appSettingsProvider.notifier).update(
                      appSettings.copyWith.themeSettings(
                        useMaterialThemeOnItemPage: value,
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

extension ColorExtension on Color {
  String toHexString() {
    return '#${value.toRadixString(16).substring(2)}';
  }
}

extension StringExtension on String {
  Color toColor() {
    return Color(int.parse('0xff$substring(1)'));
  }
}
// ModeSelectionDialog is no longer needed as SegmentedButton handles selection directly.
// class ModeSelectionDialog extends HookConsumerWidget {
//   final ThemeMode themeMode;

//   const ModeSelectionDialog({
//     super.key,
//     required this.themeMode,
//   });

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final selectedTheme = useState(themeMode);
//     // a wrap of chips to show the available modes with icons
//     return AlertDialog(
//       title: const Text('Select Theme Mode'),
//       content: Wrap(
//         spacing: 8.0,
//         runSpacing: 8.0,
//         children: ThemeMode.values
//             .map(
//               (mode) => ChoiceChip(
//                 avatar: switch (mode) {
//                   ThemeMode.system => const Icon(Icons.auto_awesome),
//                   ThemeMode.light => const Icon(Icons.light_mode),
//                   ThemeMode.dark => const Icon(Icons.dark_mode),
//                 },
//                 showCheckmark: false,
//                 label: Text(mode.pascalCase),
//                 selected: mode == selectedTheme.value,
//                 onSelected: (selected) {
//                   if (selected) {
//                     selectedTheme.value = mode;
//                   }
//                 },
//               ),
//             )
//             .toList(),
//       ),
//       actions: [
//         CancelButton(),
//         OkButton(
//           onPressed: () {
//             Navigator.pop(context, selectedTheme.value);
//           },
//         ),
//       ],
//     );
//   }
// }
