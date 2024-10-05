import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logging/logging.dart';
import 'package:material_color_utilities/material_color_utilities.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'system_theme_provider.g.dart';

final _logger = Logger('SystemThemeProvider');

/// copied from [DynamicColorBuilder]
@Riverpod(keepAlive: true)
FutureOr<(ColorScheme light, ColorScheme dark)?> systemTheme(
  SystemThemeRef ref, {
  bool highContrast = false,
}) async {
  _logger.fine('Generating system theme');
  ColorScheme? schemeLight;
  ColorScheme? schemeDark;
  // Platform messages may fail, so we use a try/catch PlatformException.
  try {
    CorePalette? corePalette = await DynamicColorPlugin.getCorePalette();

    if (corePalette != null) {
      _logger.fine('dynamic_color: Core palette detected.');
      schemeLight = corePalette.toColorScheme(brightness: Brightness.light);
      schemeDark = corePalette.toColorScheme(brightness: Brightness.dark);
    }
  } on PlatformException {
    _logger.warning('dynamic_color: Failed to obtain core palette.');
  }

  if (schemeLight == null || schemeDark == null) {
    try {
      final Color? accentColor = await DynamicColorPlugin.getAccentColor();

      if (accentColor != null) {
        _logger.fine('dynamic_color: Accent color detected.');
        schemeLight = ColorScheme.fromSeed(
          seedColor: accentColor,
          brightness: Brightness.light,
        );
        schemeDark = ColorScheme.fromSeed(
          seedColor: accentColor,
          brightness: Brightness.dark,
        );
      }
    } on PlatformException {
      _logger.warning('dynamic_color: Failed to obtain accent color.');
    }
  }

  if (schemeLight == null || schemeDark == null) {
    _logger
        .warning('dynamic_color: Dynamic color not detected on this device.');
    return null;
  }
  // set high contrast theme
  if (highContrast) {
    schemeLight = schemeLight
        .copyWith(
          surface: Colors.white,
        )
        .harmonized();
    schemeDark = schemeDark
        .copyWith(
          surface: Colors.black,
        )
        .harmonized();
  }
  return (schemeLight, schemeDark);
}
