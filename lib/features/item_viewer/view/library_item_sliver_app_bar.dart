import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vaani/api/library_item_provider.dart' show libraryItemProvider;

class LibraryItemSliverAppBar extends HookConsumerWidget {
  const LibraryItemSliverAppBar({
    super.key,
    required this.id,
    required this.scrollController,
  });

  final String id;
  final ScrollController scrollController;

  static const double _showTitleThreshold = kToolbarHeight * 0.5;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final item = ref.watch(libraryItemProvider(id)).valueOrNull;

    final showTitle = useState(false);

    useEffect(
      () {
        void listener() {
          final shouldShow = scrollController.hasClients &&
              scrollController.offset > _showTitleThreshold;
          if (showTitle.value != shouldShow) {
            showTitle.value = shouldShow;
          }
        }

        scrollController.addListener(listener);
        // Trigger listener once initially in case the view starts scrolled
        // (though unlikely for this specific use case, it's good practice)
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (scrollController.hasClients) {
            listener();
          }
        });
        return () => scrollController.removeListener(listener);
      },
      [scrollController],
    );

    return SliverAppBar(
      elevation: 0,
      floating: false,
      pinned: true,
      primary: true,
      actions: [
        // IconButton(
        //   icon: const Icon(Icons.cast),
        //   onPressed: () {
        //     // Handle search action
        //   },
        // ),
      ],
      title: AnimatedSwitcher(
        duration: const Duration(milliseconds: 150),
        child: showTitle.value
            ? Text(
                // Use a Key to help AnimatedSwitcher differentiate widgets
                key: const ValueKey('title-text'),
                item?.media.metadata.title ?? '',
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium,
              )
            : const SizedBox(
                // Also give it a key for differentiation
                key: ValueKey('empty-title'),
                width: 0, // Ensure it takes no space if possible
                height: 0,
              ),
      ),
      centerTitle: false,
    );
  }
}
