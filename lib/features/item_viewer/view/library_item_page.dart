import 'dart:math';

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vaani/api/library_item_provider.dart';
import 'package:vaani/features/item_viewer/view/library_item_sliver_app_bar.dart';
import 'package:vaani/features/player/view/mini_player_bottom_padding.dart';
import 'package:vaani/router/models/library_item_extras.dart';
import 'package:vaani/shared/widgets/expandable_description.dart';

import 'library_item_actions.dart';
import 'library_item_hero_section.dart';
import 'library_item_metadata.dart';

class LibraryItemPage extends HookConsumerWidget {
  const LibraryItemPage({
    super.key,
    required this.itemId,
    this.extra,
  });

  final String itemId;
  final Object? extra;
  static const double _showFabThreshold = 300.0;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final additionalItemData =
        extra is LibraryItemExtras ? extra as LibraryItemExtras : null;
    final scrollController = useScrollController();
    final showFab = useState(false);

    // Effect to listen to scroll changes and update FAB visibility
    useEffect(
      () {
        void listener() {
          if (!scrollController.hasClients) {
            return; // Ensure controller is attached
          }
          final shouldShow = scrollController.offset > _showFabThreshold;
          // Update state only if it changes and widget is still mounted
          if (showFab.value != shouldShow && context.mounted) {
            showFab.value = shouldShow;
          }
        }

        scrollController.addListener(listener);
        // Initial check in case the view starts scrolled (less likely but safe)
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (scrollController.hasClients && context.mounted) {
            listener();
          }
        });

        // Cleanup: remove the listener when the widget is disposed
        return () => scrollController.removeListener(listener);
      },
      [scrollController],
    ); // Re-run effect if scrollController changes

    // --- FAB Scroll-to-Top Logic ---
    void scrollToTop() {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          0.0, // Target offset (top)
          duration: 300.ms,
          curve: Curves.easeInOut,
        );
      }
    }

    return ThemeProvider(
      initTheme: Theme.of(context),
      duration: 200.ms,
      child: ThemeSwitchingArea(
        child: Scaffold(
          floatingActionButton: AnimatedSwitcher(
            duration: 250.ms,
            // A common transition for FABs (fade + scale)
            transitionBuilder: (Widget child, Animation<double> animation) {
              return ScaleTransition(
                scale: animation,
                child: FadeTransition(
                  opacity: animation,
                  child: child,
                ),
              );
            },
            child: showFab.value
                ? FloatingActionButton(
                    // Key is important for AnimatedSwitcher to differentiate
                    key: const ValueKey('fab-scroll-top'),
                    onPressed: scrollToTop,
                    tooltip: 'Scroll to top',
                    child: const Icon(Icons.arrow_upward),
                  )
                : const SizedBox.shrink(
                    key: ValueKey('fab-empty'),
                  ),
          ),
          body: CustomScrollView(
            controller: scrollController,
            slivers: [
              LibraryItemSliverAppBar(
                id: itemId,
                scrollController: scrollController,
              ),
              SliverPadding(
                padding: const EdgeInsets.all(8),
                sliver: LibraryItemHeroSection(
                  itemId: itemId,
                  extraMap: additionalItemData,
                ),
              ),
              // a horizontal display with dividers of metadata
              SliverToBoxAdapter(
                child: LibraryItemMetadata(id: itemId),
              ),
              // a row of actions like play, download, share, etc
              SliverToBoxAdapter(
                child: LibraryItemActions(id: itemId),
              ),
              // a expandable section for book description
              SliverToBoxAdapter(
                child: LibraryItemDescription(id: itemId),
              ),
              // a padding at the bottom to make sure the last item is not hidden by mini player
              const SliverToBoxAdapter(child: MiniPlayerBottomPadding()),
            ],
          ),
        ),
      ),
    );
  }
}

class LibraryItemDescription extends HookConsumerWidget {
  const LibraryItemDescription({
    super.key,
    required this.id,
  });

  final String id;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final item = ref.watch(libraryItemProvider(id)).valueOrNull;
    if (item == null) {
      return const SizedBox();
    }
    return ExpandableDescription(
      title: 'About the Book',
      content: item.media.metadata.description ?? 'Sorry, no description found',
    );
  }
}

/// Calculate the width of the book cover based on the screen size
double calculateWidth(
  BuildContext context,
  BoxConstraints constraints, {
  /// width ratio of the cover image to the available width
  double widthRatio = 0.4,

  /// height ratio of the cover image to the available height
  double maxHeightToUse = 0.25,
}) {
  final availHeight =
      min(constraints.maxHeight, MediaQuery.of(context).size.height);
  final availWidth =
      min(constraints.maxWidth, MediaQuery.of(context).size.width);

  // make the width widthRatio of the available width
  var width = availWidth * widthRatio;
  // but never exceed more than heightRatio of height
  if (width > availHeight * maxHeightToUse) {
    width = availHeight * maxHeightToUse;
  }

  return width;
}
