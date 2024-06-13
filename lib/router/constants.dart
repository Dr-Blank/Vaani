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

  // settings
  static const settings = _SimpleRoute(
    pathName: 'config',
    name: 'settings',
  );
  static const autoSleepTimerSettings = _SimpleRoute(
    pathName: 'autosleeptimer',
    name: 'autoSleepTimerSettings',
    // parentRoute: settings,
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
  String get path {
    return '${parentRoute?.path ?? ''}$localPath';
  }

  /// the local path of the route
  String get localPath =>
      '/$pathName${pathParamName != null ? '/:$pathParamName' : ''}';
}
