import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:whispering_pages/features/explore/providers/search_controller.dart';
import 'package:whispering_pages/features/player/providers/player_form.dart';
import 'package:whispering_pages/features/player/view/audiobook_player.dart';

// stack to track changes in navigationShell.currentIndex
// home is always at index 0 and at the start and should be the last before popping
// if stack is empty, push home, if already contains home, pop it
final Set<int> navigationShellStack = {};

/// Builds the "shell" for the app by building a Scaffold with a
/// BottomNavigationBar, where [child] is placed in the body of the Scaffold.
class ScaffoldWithNavBar extends HookConsumerWidget {
  /// Constructs an [ScaffoldWithNavBar].
  const ScaffoldWithNavBar({
    required this.navigationShell,
    Key? key,
  }) : super(key: key ?? const ValueKey<String>('ScaffoldWithNavBar'));

  /// The navigation shell and container for the branch Navigators.
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // playerExpandProgress is used to animate bottom navigation bar to opacity 0 and slide down when player is expanded
    // final playerProgress =
    //     useValueListenable(ref.watch(playerExpandProgressNotifierProvider));
    final playerProgress = ref.watch(playerHeightProvider);
    final playerMaxHeight = MediaQuery.of(context).size.height;
    var percentExpanded = (playerProgress - playerMinHeight) /
        (playerMaxHeight - playerMinHeight);
    // Clamp the value between 0 and 1
    percentExpanded = percentExpanded.clamp(0.0, 1.0);

    onBackButtonPressed() async {
      final isPlayerExpanded = playerProgress != playerMinHeight;

      debugPrint(
        'BackButtonListener: Back button pressed, isPlayerExpanded: $isPlayerExpanded, stack: $navigationShellStack',
      );
      // close miniplayer if it is open
      if (isPlayerExpanded) {
        debugPrint(
          'BackButtonListener: closing the player',
        );
        audioBookMiniplayerController.animateToHeight(state: PanelState.MIN);
        return true;
      }

      // do the the following only if the current branch has nothing to pop
      final canPop = GoRouter.of(context).canPop();

      if (canPop) {
        debugPrint(
          'BackButtonListener: passing it to the router as canPop is true',
        );
        return false;
      }

      if (navigationShellStack.isNotEmpty) {
        // pop the last index from the stack and navigate to it
        final index = navigationShellStack.last;
        navigationShellStack.remove(index);
        debugPrint('BackButtonListener: popping the stack, index: $index');

        // if the stack is empty, navigate to home else navigate to the last index
        if (navigationShellStack.isNotEmpty) {
          navigationShell.goBranch(navigationShellStack.last);
          return true;
        }
      }
      if (navigationShell.currentIndex != 0) {
        // if the stack is empty and the current branch is not home, navigate to home
        debugPrint('BackButtonListener: navigating to home');
        navigationShell.goBranch(0);
        return true;
      }

      debugPrint('BackButtonListener: passing it to the router');
      return false;
    }

    return BackButtonListener(
      onBackButtonPressed: onBackButtonPressed,
      child: Scaffold(
        body: Stack(
          children: [
            navigationShell,
            const AudiobookPlayer(),
          ],
        ),
        bottomNavigationBar: Opacity(
          // Opacity is interpolated from 1 to 0 when player is expanded
          opacity: 1 - percentExpanded,
          child: SizedBox(
            // height is interpolated from 0 to 56 when player is expanded
            height: 56 * (1 - percentExpanded),

            child: BottomNavigationBar(
              elevation: 0.0,
              landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
              selectedFontSize:
                  Theme.of(context).textTheme.labelMedium!.fontSize!,
              unselectedFontSize:
                  Theme.of(context).textTheme.labelMedium!.fontSize!,
              showUnselectedLabels: false,
              fixedColor: Theme.of(context).colorScheme.onSurface,
              enableFeedback: true,
              type: BottomNavigationBarType.fixed,

              // Here, the items of BottomNavigationBar are hard coded. In a real
              // world scenario, the items would most likely be generated from the
              // branches of the shell route, which can be fetched using
              // `navigationShell.route.branches`.
              items: _navigationItems
                  .map(
                    (item) => BottomNavigationBarItem(
                      icon: Icon(item.icon),
                      activeIcon: item.activeIcon != null
                          ? Icon(item.activeIcon)
                          : Icon(item.icon),
                      label: item.name,
                    ),
                  )
                  .toList(),
              currentIndex: navigationShell.currentIndex,
              onTap: (int index) => _onTap(context, index, ref),
            ),
          ),
        ),
      ),
    );
  }

  /// Navigate to the current location of the branch at the provided index when
  /// tapping an item in the BottomNavigationBar.
  void _onTap(BuildContext context, int index, WidgetRef ref) {
    // When navigating to a new branch, it's recommended to use the goBranch
    // method, as doing so makes sure the last navigation state of the
    // Navigator for the branch is restored.
    navigationShell.goBranch(
      index,
      // A common pattern when using bottom navigation bars is to support
      // navigating to the initial location when tapping the item that is
      // already active. This example demonstrates how to support this behavior,
      // using the initialLocation parameter of goBranch.
      initialLocation: index == navigationShell.currentIndex,
    );

    // add the index to the stack but remove it if it is already there
    if (navigationShellStack.contains(index)) {
      navigationShellStack.remove(index);
    }
    navigationShellStack.add(index);
    debugPrint('Tapped index: $index, stack: $navigationShellStack');

    // Check if the current branch is the same as the branch that was tapped.
    // If it is, debugPrint a message to the console.
    if (index == navigationShell.currentIndex) {
      // if current branch is explore, open the search view
      if (index == 1) {
        final searchController = ref.read(globalSearchControllerProvider);
        // open the search view if not already open
        if (!searchController.isOpen) {
          searchController.openView();
        } else {
          searchController.closeView(null);
        }
      }
      debugPrint('Tapped the current branch');
    }
  }
}

// list of constants with names and icons so that they can be used in the bottom navigation bar
// and reused for nav rail and other places
const _navigationItems = [
  _NavigationItem(
    name: 'Home',
    icon: Icons.home_outlined,
    activeIcon: Icons.home,
  ),
  _NavigationItem(
    name: 'Explore',
    icon: Icons.search_outlined,
    activeIcon: Icons.search,
  ),
  _NavigationItem(
    name: 'Settings',
    icon: Icons.settings_outlined,
    activeIcon: Icons.settings,
  ),
];

class _NavigationItem {
  const _NavigationItem({
    required this.name,
    required this.icon,
    this.activeIcon,
  });

  final String name;
  final IconData icon;
  final IconData? activeIcon;
}
