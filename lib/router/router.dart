import 'package:go_router/go_router.dart';
import 'package:whispering_pages/pages/home_page.dart';
import 'package:whispering_pages/pages/library_item_page.dart';
import 'package:whispering_pages/pages/library_page.dart';
import 'package:whispering_pages/pages/onboarding/onboarding_single_page.dart';

part 'constants.dart';

// GoRouter configuration
class MyAppRouter {
  const MyAppRouter({required this.needOnboarding});
  final bool needOnboarding;
  // some static strings for named routes

  GoRouter get config => GoRouter(
        routes: [
          GoRoute(
            path: '/login',
            name: Routes.onboarding,
            builder: (context, state) => const OnboardingSinglePage(),
          ),
          GoRoute(
            path: '/',
            name: Routes.home,
            builder: (context, state) => const HomePage(),
          ),
          // /library/:libraryId
          GoRoute(
            path: Routes.library.path,
            name: Routes.library.name,
            builder: (context, state) => LibraryPage(
              libraryId: state.pathParameters[Routes.library.pathParamName]!,
            ),
          ),
          GoRoute(
            path: Routes.libraryItem.path,
            name: Routes.libraryItem.name,
            builder: (context, state) {
              final itemId =
                  state.pathParameters[Routes.libraryItem.pathParamName]!;
              return LibraryItemPage(itemId: itemId, extra: state.extra);
            },
          ),
        ],
        redirect: (context, state) {
          if (needOnboarding) {
            return config.namedLocation(Routes.onboarding);
          }
          return null;
        },
      );
}
