import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vaani/api/library_provider.dart' show currentLibraryProvider;
import 'package:vaani/features/you/view/widgets/library_switch_chip.dart'
    show showLibrarySwitcher;
import 'package:vaani/router/router.dart' show Routes;
import 'package:vaani/shared/icons/abs_icons.dart' show AbsIcons;
import 'package:vaani/shared/widgets/not_implemented.dart'
    show showNotImplementedToast;

class LibraryBrowserPage extends HookConsumerWidget {
  const LibraryBrowserPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLibrary = ref.watch(currentLibraryProvider).valueOrNull;

    // Determine the icon to use, with a fallback
    final IconData libraryIconData =
        AbsIcons.getIconByName(currentLibrary?.icon) ?? Icons.library_books;

    // Determine the title text
    final String appBarTitle = '${currentLibrary?.name ?? 'Your'} Library';

    return Scaffold(
      // Use CustomScrollView to enable slivers
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            // floating: true, // Optional: uncomment if you want floating behavior
            // snap:
            //     true, // Optional: uncomment if you want snapping behavior (usually with floating: true)
            leading: IconButton(
              icon: Icon(libraryIconData),
              tooltip: 'Switch Library', // Helpful tooltip for users
              onPressed: () {
                showLibrarySwitcher(context, ref);
              },
            ),
            title: Text(appBarTitle),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                ListTile(
                  title: const Text('Authors'),
                  leading: const Icon(Icons.person),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    showNotImplementedToast(context);
                  },
                ),
                ListTile(
                  title: const Text('Genres'),
                  leading: const Icon(Icons.category),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    showNotImplementedToast(context);
                  },
                ),
                ListTile(
                  title: const Text('Series'),
                  leading: const Icon(Icons.list),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    showNotImplementedToast(context);
                  },
                ),
                // Downloads
                ListTile(
                  title: const Text('Downloads'),
                  leading: const Icon(Icons.download),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    GoRouter.of(context).pushNamed(Routes.downloads.name);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
