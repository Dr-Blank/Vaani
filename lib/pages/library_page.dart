import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vaani/api/api_provider.dart';
import 'package:vaani/main.dart';
import 'package:vaani/settings/api_settings_provider.dart';

import '../shared/widgets/drawer.dart';
import '../shared/widgets/shelves/home_shelf.dart';

// TODO: implement the library page
class LibraryPage extends HookConsumerWidget {
  const LibraryPage({this.libraryId, super.key});

  final String? libraryId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // set the library id as the active library
    if (libraryId != null) {
      ref.read(apiSettingsProvider.notifier).updateState(
            ref.watch(apiSettingsProvider).copyWith(activeLibraryId: libraryId),
          );
    }

    final views = ref.watch(personalizedViewProvider);
    final scrollController = useScrollController();

    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          child: const Text('Vaani'),
          onTap: () {
            // scroll to the top of the page
            scrollController.animateTo(
              0,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
            // refresh the view
            ref.invalidate(personalizedViewProvider);
          },
        ),
      ),
      drawer: const MyDrawer(),
      body: Container(
        child: views.when(
          data: (data) {
            final shelvesToDisplay = data
                // .where((element) => !element.id.contains('discover'))
                .map((shelf) {
              appLogger.fine('building shelf ${shelf.label}');
              return HomeShelf(
                title: shelf.label,
                shelf: shelf,
              );
            }).toList();
            return RefreshIndicator(
              onRefresh: () async {
                return ref.refresh(personalizedViewProvider);
              },
              child: ListView.separated(
                itemBuilder: (context, index) => shelvesToDisplay[index],
                separatorBuilder: (context, index) => Divider(
                  color: Theme.of(context).dividerColor.withValues(alpha: 0.1),
                  indent: 16,
                  endIndent: 16,
                ),
                itemCount: shelvesToDisplay.length,
                controller: scrollController,
              ),
            );
          },
          loading: () => const LibraryPageSkeleton(),
          error: (error, stack) {
            return Text('Error: $error');
          },
        ),
      ),
    );
  }
}

class LibraryPageSkeleton extends StatelessWidget {
  const LibraryPageSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
