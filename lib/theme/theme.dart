import 'package:flutter/material.dart';

// brand color rgb(49, 27, 146) rgb(96, 76, 236)
const brandColor = Color(0xFF311B92);
const brandColorLight = Color(0xFF604CEC);

final brandLightColorScheme = ColorScheme.fromSeed(
  seedColor: brandColor,
  brightness: Brightness.light,
);

final brandDarkColorScheme = ColorScheme.fromSeed(
  seedColor: brandColor,
  brightness: Brightness.dark,
);
