// to store names of routes

part of 'router.dart';

class Routes {
  static const home = _SimpleRoute(
    pathName: '',
    name: 'home',
  );
  static const onboarding = _SimpleRoute(
    pathName: 'login',
    name: 'onboarding',
  );
  static const library = _SimpleRoute(
    pathName: 'library',
    pathParamName: 'libraryId',
    name: 'library',
  );
  static const libraryItem = _SimpleRoute(
    pathName: 'item',
    pathParamName: 'itemId',
    name: 'libraryItem',
  );

  // Local settings
  static const settings = _SimpleRoute(
    pathName: 'config',
    name: 'settings',
  );
  static const themeSettings = _SimpleRoute(
    pathName: 'theme',
    name: 'themeSettings',
    parentRoute: settings,
  );
  static const autoSleepTimerSettings = _SimpleRoute(
    pathName: 'autoSleepTimer',
    name: 'autoSleepTimerSettings',
    parentRoute: settings,
  );
  static const notificationSettings = _SimpleRoute(
    pathName: 'notifications',
    name: 'notificationSettings',
    parentRoute: settings,
  );
  static const playerSettings = _SimpleRoute(
    pathName: 'player',
    name: 'playerSettings',
    parentRoute: settings,
  );
  static const shakeDetectorSettings = _SimpleRoute(
    pathName: 'shakeDetector',
    name: 'shakeDetectorSettings',
    parentRoute: settings,
  );
  static const homePageSettings = _SimpleRoute(
    pathName: 'home-page',
    name: 'homePageSettings',
    parentRoute: settings,
  );

  // search and explore
  static const search = _SimpleRoute(
    pathName: 'search',
    name: 'search',
    // parentRoute: library,
  );
  static const explore = _SimpleRoute(
    pathName: 'explore',
    name: 'explore',
  );

  // downloads
  static const downloads = _SimpleRoute(
    pathName: 'downloads',
    name: 'downloads',
  );

  // library browser to browse the library using author, genre, etc.
  static const libraryBrowser = _SimpleRoute(
    pathName: 'browser',
    name: 'libraryBrowser',
    // parentRoute: library,
  );

  // you page for the user
  static const you = _SimpleRoute(
    pathName: 'you',
    name: 'you',
  );

  // user management
  static const userManagement = _SimpleRoute(
    pathName: 'users',
    name: 'userManagement',
  );

  // openID callback
  static const openIDCallback = _SimpleRoute(
    pathName: 'callback',
    name: 'openIDCallback',
    parentRoute: onboarding,
  );

  // logs page
  static const logs = _SimpleRoute(
    pathName: 'logs',
    name: 'logs',
  );
}

// a class to store path

class _SimpleRoute {
  const _SimpleRoute({
    required this.pathName,
    this.pathParamName,
    required this.name,
    this.parentRoute,
  });

  final String pathName;
  final String? pathParamName;
  final String name;
  final _SimpleRoute? parentRoute;

  /// the full path of the route
  String get fullPath {
    return '${parentRoute?.fullPath ?? ''}$localPath';
  }

  /// the local path of the route
  String get localPath =>
      '/$pathName${pathParamName != null ? '/:$pathParamName' : ''}';
}
