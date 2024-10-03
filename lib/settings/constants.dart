import 'package:flutter/foundation.dart' show immutable;


@immutable
class AppMetadata {
  const AppMetadata._();
  // TODO: use the packageinfo package to get the app name
  static const String appName = 'Vaani';

  // for deeplinking
  static const String appScheme = 'vaani';

  static const version = '1.0.0';
  static const author = 'Dr.Blank';

  static Uri githubRepo = Uri.parse('https://github.com/Dr-Blank/Vaani');

  static get appNameLowerCase => appName.toLowerCase().replaceAll(' ', '_');
}
