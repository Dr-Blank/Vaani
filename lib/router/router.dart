import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vaani/features/downloads/view/downloads_page.dart';
import 'package:vaani/features/explore/view/explore_page.dart';
import 'package:vaani/features/explore/view/search_result_page.dart';
import 'package:vaani/features/item_viewer/view/library_item_page.dart';
import 'package:vaani/features/library_browser/view/library_browser_page.dart';
import 'package:vaani/features/logging/view/logs_page.dart';
import 'package:vaani/features/onboarding/view/callback_page.dart';
import 'package:vaani/features/onboarding/view/onboarding_single_page.dart';
import 'package:vaani/features/you/view/server_manager.dart';
import 'package:vaani/features/you/view/you_page.dart';
import 'package:vaani/main.dart';
import 'package:vaani/pages/home_page.dart';
import 'package:vaani/settings/view/app_settings_page.dart';
import 'package:vaani/settings/view/auto_sleep_timer_settings_page.dart';
import 'package:vaani/settings/view/notification_settings_page.dart';
import 'package:vaani/settings/view/player_settings_page.dart';
import 'package:vaani/settings/view/shake_detector_settings_page.dart';
import 'package:vaani/settings/view/theme_settings_page.dart';
import 'package:vaani/settings/view/home_page_settings_page.dart';

import 'scaffold_with_nav_bar.dart';
import 'transitions/slide.dart';

part 'constants.dart';

final GlobalKey<NavigatorState> rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> sectionHomeNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'HomeNavigator');

// GoRouter configuration
class MyAppRouter {
  const MyAppRouter();

  GoRouter get config => GoRouter(
        initialLocation: Routes.home.localPath,
        debugLogDiagnostics: true,
        routes: [
          // sign in page
          GoRoute(
            path: Routes.onboarding.localPath,
            name: Routes.onboarding.name,
            builder: (context, state) => const OnboardingSinglePage(),
            routes: [
              // open id callback
              GoRoute(
                path: Routes.openIDCallback.pathName,
                name: Routes.openIDCallback.name,
                pageBuilder: handleCallback,
              ),
            ],
          ),
          // callback for open id
          // need to duplicate  because of https://github.com/flutter/flutter/issues/100624
          GoRoute(
            path: Routes.openIDCallback.localPath,
            // name: Routes.openIDCallback.name,
            // builder: handleCallback,
            pageBuilder: handleCallback,
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
                navigatorKey: sectionHomeNavigatorKey,
                routes: <RouteBase>[
                  GoRoute(
                    path: Routes.home.localPath,
                    name: Routes.home.name,
                    // builder: (context, state) => const HomePage(),
                    pageBuilder: defaultPageBuilder(const HomePage()),
                  ),
                  GoRoute(
                    path: Routes.libraryItem.localPath,
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
                  // downloads page
                  GoRoute(
                    path: Routes.downloads.localPath,
                    name: Routes.downloads.name,
                    pageBuilder: defaultPageBuilder(const DownloadsPage()),
                  ),
                ],
              ),

              // Library page
              StatefulShellBranch(
                routes: <RouteBase>[
                  GoRoute(
                    path: Routes.libraryBrowser.localPath,
                    name: Routes.libraryBrowser.name,
                    pageBuilder: defaultPageBuilder(const LibraryBrowserPage()),
                  ),
                ],
              ),
              // search/explore page
              StatefulShellBranch(
                routes: <RouteBase>[
                  GoRoute(
                    path: Routes.explore.localPath,
                    name: Routes.explore.name,
                    // builder: (context, state) => const ExplorePage(),
                    pageBuilder: defaultPageBuilder(const ExplorePage()),
                  ),
                  // search page
                  GoRoute(
                    path: Routes.search.localPath,
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
              // you page
              StatefulShellBranch(
                routes: <RouteBase>[
                  GoRoute(
                    path: Routes.you.localPath,
                    name: Routes.you.name,
                    pageBuilder: defaultPageBuilder(const YouPage()),
                  ),
                  GoRoute(
                    path: Routes.settings.localPath,
                    name: Routes.settings.name,
                    // builder: (context, state) => const AppSettingsPage(),
                    pageBuilder: defaultPageBuilder(const AppSettingsPage()),
                    routes: [
                      GoRoute(
                        path: Routes.themeSettings.pathName,
                        name: Routes.themeSettings.name,
                        pageBuilder: defaultPageBuilder(
                          const ThemeSettingsPage(),
                        ),
                      ),
                      GoRoute(
                        path: Routes.autoSleepTimerSettings.pathName,
                        name: Routes.autoSleepTimerSettings.name,
                        pageBuilder: defaultPageBuilder(
                          const AutoSleepTimerSettingsPage(),
                        ),
                      ),
                      GoRoute(
                        path: Routes.notificationSettings.pathName,
                        name: Routes.notificationSettings.name,
                        pageBuilder: defaultPageBuilder(
                          const NotificationSettingsPage(),
                        ),
                      ),
                      GoRoute(
                        path: Routes.playerSettings.pathName,
                        name: Routes.playerSettings.name,
                        pageBuilder:
                            defaultPageBuilder(const PlayerSettingsPage()),
                      ),
                      GoRoute(
                        path: Routes.shakeDetectorSettings.pathName,
                        name: Routes.shakeDetectorSettings.name,
                        pageBuilder: defaultPageBuilder(
                          const ShakeDetectorSettingsPage(),
                        ),
                      ),
                      GoRoute(
                        path: Routes.homePageSettings.pathName,
                        name: Routes.homePageSettings.name,
                        pageBuilder: defaultPageBuilder(
                          const HomePageSettingsPage(),
                        ),
                      ),
                    ],
                  ),
                  GoRoute(
                    path: Routes.userManagement.localPath,
                    name: Routes.userManagement.name,
                    // builder: (context, state) => const UserManagementPage(),
                    pageBuilder: defaultPageBuilder(const ServerManagerPage()),
                  ),
                ],
              ),
            ],
          ),

          // loggers page
          GoRoute(
            path: Routes.logs.localPath,
            name: Routes.logs.name,
            // builder: (context, state) => const LogsPage(),
            pageBuilder: defaultPageBuilder(const LogsPage()),
          ),
        ],
      );

  Page handleCallback(
    BuildContext context,
    GoRouterState state,
  ) {
    // extract the code and state from the uri
    final code = state.uri.queryParameters['code'];
    final stateParam = state.uri.queryParameters['state'];
    appLogger.fine('deep linking callback: code: $code, state: $stateParam');

    var callbackPage =
        CallbackPage(code: code, state: stateParam, key: ValueKey(stateParam));
    return buildPageWithDefaultTransition(
      context: context,
      state: state,
      child: callbackPage,
    );
  }
}
