import 'package:flutter/material.dart';
import 'package:vaani/theme/theme.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.fromSeed(
    seedColor: brandColor,
    brightness: Brightness.light,
  ),
);
