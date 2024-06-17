import 'package:flutter/foundation.dart' show immutable;


@immutable
class AppMetadata {
  const AppMetadata._();
  // TODO: use the packageinfo package to get the app name
  static const String appName = 'Whispering Pages';

  static get appNameLowerCase => appName.toLowerCase().replaceAll(' ', '_');
}
