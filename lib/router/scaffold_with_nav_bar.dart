import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:whispering_pages/features/player/providers/player_form.dart';
import 'package:whispering_pages/features/player/view/audiobook_player.dart';

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
    final playerMaxHeight =
        MediaQuery.of(context).size.height * playerMaxHeightPercentOfScreen;
    var percentExpanded = (playerProgress - playerMinHeight) /
        (playerMaxHeight - playerMinHeight);
    // Clamp the value between 0 and 1
    percentExpanded = percentExpanded.clamp(0.0, 1.0);

    return Scaffold(
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
            fixedColor: Theme.of(context).colorScheme.onBackground,
            // type: BottomNavigationBarType.fixed,

            // Here, the items of BottomNavigationBar are hard coded. In a real
            // world scenario, the items would most likely be generated from the
            // branches of the shell route, which can be fetched using
            // `navigationShell.route.branches`.
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                label: 'Home',
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home),
              ),
              BottomNavigationBarItem(
                label: 'Settings',
                icon: Icon(Icons.settings_outlined),
                activeIcon: Icon(Icons.settings),
              ),
            ],
            currentIndex: navigationShell.currentIndex,
            onTap: (int index) => _onTap(context, index),
          ),
        ),
      ),
    );
  }

  /// Navigate to the current location of the branch at the provided index when
  /// tapping an item in the BottomNavigationBar.
  void _onTap(BuildContext context, int index) {
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
  }
}
