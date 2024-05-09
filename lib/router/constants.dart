// to store names of routes

part of 'router.dart';

class Routes {
  static const home = 'home';
  static const onboarding = 'onboarding';
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
}

// a class to store path

class _SimpleRoute {
  const _SimpleRoute({
    required this.pathName,
    required this.pathParamName,
    required this.name,
  });

  final String pathName;
  final String pathParamName;
  final String name;

  String get path => '/$pathName/:$pathParamName';
}
