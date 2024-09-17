import 'package:flutter/foundation.dart' show immutable;


@immutable
class AppMetadata {
  const AppMetadata._();
  // TODO: use the packageinfo package to get the app name
  static const String appName = 'Vaani';

  // for deeplinking
  static const String appScheme = 'vaani';

  static get appNameLowerCase => appName.toLowerCase().replaceAll(' ', '_');
}
