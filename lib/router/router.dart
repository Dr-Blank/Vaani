import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:whispering_pages/features/explore/view/explore_page.dart';
import 'package:whispering_pages/features/explore/view/search_result_page.dart';
import 'package:whispering_pages/features/item_viewer/view/library_item_page.dart';
import 'package:whispering_pages/features/onboarding/view/onboarding_single_page.dart';
import 'package:whispering_pages/pages/app_settings.dart';
import 'package:whispering_pages/pages/home_page.dart';

import 'scaffold_with_nav_bar.dart';
import 'transitions/slide.dart';

part 'constants.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _sectionHomeNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'HomeNavigator');

// GoRouter configuration
class MyAppRouter {
  const MyAppRouter();

  GoRouter get config => GoRouter(
        initialLocation: Routes.home.path,
        routes: [
          // sign in page
          GoRoute(
            path: Routes.onboarding.path,
            name: Routes.onboarding.name,
            builder: (context, state) => const OnboardingSinglePage(),
          ),
          // The main app shell
          StatefulShellRoute.indexedStack(
            builder: (
              BuildContext context,
              GoRouterState state,
              StatefulNavigationShell navigationShell,
            ) {
              // Return the widget that implements the custom shell (in this case
              // using a BottomNavigationBar). The StatefulNavigationShell is passed
              // to be able access the state of the shell and to navigate to other
              // branches in a stateful way.
              return ScaffoldWithNavBar(navigationShell: navigationShell);
            },
            branches: <StatefulShellBranch>[
              // The route branch for the first tab of the bottom navigation bar.
              StatefulShellBranch(
                navigatorKey: _sectionHomeNavigatorKey,
                routes: <RouteBase>[
                  GoRoute(
                    path: Routes.home.path,
                    name: Routes.home.name,
                    // builder: (context, state) => const HomePage(),
                    pageBuilder: defaultPageBuilder(const HomePage()),
                  ),
                  GoRoute(
                    path: Routes.libraryItem.path,
                    name: Routes.libraryItem.name,
                    // builder: (context, state) {
                    //   final itemId = state
                    //       .pathParameters[Routes.libraryItem.pathParamName]!;
                    //   return LibraryItemPage(
                    //       itemId: itemId, extra: state.extra);
                    // },
                    pageBuilder: (context, state) {
                      final itemId = state
                          .pathParameters[Routes.libraryItem.pathParamName]!;
                      final child =
                          LibraryItemPage(itemId: itemId, extra: state.extra);
                      return buildPageWithDefaultTransition(
                        context: context,
                        state: state,
                        child: child,
                      );
                    },
                  ),
                ],
              ),
              // search/explore page
              StatefulShellBranch(
                routes: <RouteBase>[
                  GoRoute(
                    path: Routes.explore.path,
                    name: Routes.explore.name,
                    // builder: (context, state) => const ExplorePage(),
                    pageBuilder: defaultPageBuilder(const ExplorePage()),
                  ),
                  // search page
                  GoRoute(
                    path: Routes.search.path,
                    name: Routes.search.name,
                    // builder: (context, state) {
                    //   final libraryId = state
                    //       .pathParameters[Routes.library.pathParamName]!;
                    //   return LibrarySearchPage(
                    //     libraryId: libraryId,
                    //     extra: state.extra,
                    //   );
                    // },
                    pageBuilder: (context, state) {
                      final queryParam = state.uri.queryParameters['q']!;
                      final category = state.uri.queryParameters['category'];
                      final child = SearchResultPage(
                        extra: state.extra,
                        query: queryParam,
                        category: category != null
                            ? SearchResultCategory.values.firstWhere(
                                (e) => e.toString().split('.').last == category,
                              )
                            : null,
                      );
                      return buildPageWithDefaultTransition(
                        context: context,
                        state: state,
                        child: child,
                      );
                    },
                  ),
                ],
              ),
              // settings page
              StatefulShellBranch(
                routes: <RouteBase>[
                  GoRoute(
                    path: Routes.settings.path,
                    name: Routes.settings.name,
                    // builder: (context, state) => const AppSettingsPage(),
                    pageBuilder: defaultPageBuilder(const AppSettingsPage()),
                  ),
                ],
              ),
            ],
          ),
        ],
      );
}
