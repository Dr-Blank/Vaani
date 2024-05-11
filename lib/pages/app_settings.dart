import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_settings_ui/flutter_settings_ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:whispering_pages/api/authenticated_user_provider.dart';
import 'package:whispering_pages/api/server_provider.dart';
import 'package:whispering_pages/settings/app_settings_provider.dart';
import 'package:whispering_pages/theme/theme.dart';

class AppSettingsPage extends HookConsumerWidget {
  const AppSettingsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appSettings = ref.watch(appSettingsProvider);
    final registeredServers = ref.watch(audiobookShelfServerProvider);
    final registeredServersAsList = registeredServers.toList();
    final availableUsers = ref.watch(authenticatedUserProvider);
    final serverURIController = useTextEditingController();
    final formKey = GlobalKey<FormState>();

    return ThemeSwitchingArea(
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('App Settings'),
            ),
            body: SettingsList(
              sections: [
                SettingsSection(
                  title: const Text('Appearance'),
                  tiles: [
                    ThemeSwitcherTile(
                      initialValue: appSettings.isDarkMode,
                      title: const Text('Dark Mode'),
                      description:
                          const Text('we all know dark mode is better'),
                      leading: (appSettings.isDarkMode
                          ? const Icon(Icons.dark_mode)
                          : const Icon(Icons.light_mode)),
                      onToggle: (value, context) {
                        ThemeSwitcher.of(context)
                            .changeTheme(theme: value ? darkTheme : lightTheme);
                        ref.read(appSettingsProvider.notifier).toggleDarkMode();
                      },
                    ),
                    SettingsTile.switchTile(
                      initialValue: appSettings.useMaterialThemeOnItemPage,
                      title: const Text('Use Material Theming on Item Page'),
                      description: const Text(
                        'get fancy with the colors on the item page at the cost of some performance',
                      ),
                      leading: const Icon(Icons.dynamic_form_outlined),
                      onToggle: (value) {
                        ref.read(appSettingsProvider.notifier).updateState(
                              appSettings.copyWith(
                                useMaterialThemeOnItemPage: value,
                              ),
                            );
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// a custom settings tile that extends AbstractSettingsTile but also returns ThemeSwitcher
// so we can switch themes by using the switch tile ans ThemeSwitcher.of(context).changeTheme()
// it is nothing but a wrapper around the switch tile so the type is settings tile but also contains a theme switcher
class ThemeSwitcherTile extends AbstractSettingsTile {
  ThemeSwitcherTile({
    required this.initialValue,
    required this.onToggle,
    this.descriptionInlineIos = false,
    this.activeSwitchColor,
    this.leading,
    this.trailing,
    required this.title,
    this.description,
    this.onPressed,
    this.enabled = true,
    this.backgroundColor,
    super.key,
  }) {
    value = null;
    tileType = SettingsTileType.switchTile;
  }

  final Widget? leading;

  final Widget? trailing;

  final Widget title;

  final Widget? description;

  final bool descriptionInlineIos;

  final Color? backgroundColor;

  final Function(BuildContext context)? onPressed;

  late final Color? activeSwitchColor;
  late final Widget? value;
  late final Function(bool value, BuildContext context)? onToggle;
  late final SettingsTileType tileType;
  late final bool? initialValue;
  late final bool enabled;

  @override
  Widget build(BuildContext context) {
    return ThemeSwitcher(
      builder: (context) {
        return SettingsTile.switchTile(
          initialValue: initialValue,
          title: title,
          description: description,
          descriptionInlineIos: descriptionInlineIos,
          leading: leading,
          trailing: trailing,
          onToggle: (value) {
            onToggle?.call(value, context);
          },
          onPressed: onPressed,
          enabled: enabled,
          backgroundColor: backgroundColor,
        );
      },
    );
  }
}
