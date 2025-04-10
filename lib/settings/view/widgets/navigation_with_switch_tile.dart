import 'package:flutter/material.dart';
import 'package:flutter_settings_ui/flutter_settings_ui.dart';

class NavigationWithSwitchTile extends AbstractSettingsTile {
  const NavigationWithSwitchTile({
    this.leading,
    // this.trailing,
    required this.value,
    required this.title,
    this.description,
    this.descriptionInlineIos = false,
    this.onPressed,
    this.enabled = true,
    this.backgroundColor,
    super.key,
    this.onToggle,
  });

  final Widget title;
  final Widget? description;
  final Color? backgroundColor;
  final bool descriptionInlineIos;
  final bool enabled;
  final Widget? leading;
  final Function(BuildContext)? onPressed;
  final bool value;
  final Function(bool)? onToggle;

  @override
  Widget build(BuildContext context) {
    return SettingsTile.navigation(
      title: title,
      description: description,
      backgroundColor: backgroundColor,
      descriptionInlineIos: descriptionInlineIos,
      enabled: enabled,
      leading: leading,
      onPressed: onPressed,
      trailing: IntrinsicHeight(
        child: Row(
          children: [
            VerticalDivider(
              color: Theme.of(context).dividerColor.withValues(alpha: 0.5),
              indent: 8.0,
              endIndent: 8.0,
            ),
            Switch.adaptive(
              value: value,
              onChanged: onToggle,
            ),
          ],
        ),
      ),
    );
  }
}
