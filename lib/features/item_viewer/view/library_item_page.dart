import 'dart:math';

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vaani/api/library_item_provider.dart';
import 'package:vaani/features/item_viewer/view/library_item_sliver_app_bar.dart';
import 'package:vaani/features/player/providers/player_form.dart';
import 'package:vaani/router/models/library_item_extras.dart';
import 'package:vaani/settings/app_settings_provider.dart';
import 'package:vaani/shared/extensions/model_conversions.dart';
import 'package:vaani/shared/widgets/expandable_description.dart';
import 'package:vaani/theme/theme_from_cover_provider.dart';

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
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final extraMap =
        extra is LibraryItemExtras ? extra as LibraryItemExtras : null;
    final bookDetailsCached = extraMap?.book;
    final providedCacheImage = extraMap?.coverImage != null
        ? Image.memory(extraMap!.coverImage!)
        : null;

    final itemFromApi = ref.watch(libraryItemProvider(itemId));

    var itemBookMetadata =
        itemFromApi.valueOrNull?.media.metadata.asBookMetadataExpanded;

    final useMaterialThemeOnItemPage =
        ref.watch(appSettingsProvider).themeSettings.useMaterialThemeOnItemPage;
    AsyncValue<ColorScheme?> coverColorScheme = const AsyncValue.loading();
    if (useMaterialThemeOnItemPage) {
      coverColorScheme = ref.watch(
        themeOfLibraryItemProvider(
          itemFromApi.valueOrNull,
          brightness: Theme.of(context).brightness,
        ),
      );
      debugPrint('ColorScheme: ${coverColorScheme.valueOrNull}');
    } else {
      debugPrint('useMaterialThemeOnItemPage is false');
      // AsyncValue<ColorScheme?> coverColorScheme = const AsyncValue.loading();
    }
    return ThemeProvider(
      initTheme: Theme.of(context),
      duration: 200.ms,
      child: ThemeSwitchingArea(
        child: Scaffold(
          body: CustomScrollView(
            slivers: [
              const LibraryItemSliverAppBar(),
              SliverPadding(
                padding: const EdgeInsets.all(8),
                sliver: LibraryItemHeroSection(
                  itemId: itemId,
                  extraMap: extraMap,
                  providedCacheImage: providedCacheImage,
                  item: itemFromApi,
                  itemBookMetadata: itemBookMetadata,
                  bookDetailsCached: bookDetailsCached,
                  coverColorScheme: coverColorScheme,
                ),
              ),
              // a horizontal display with dividers of metadata
              SliverToBoxAdapter(
                child: itemFromApi.valueOrNull != null
                    ? LibraryItemMetadata(
                        item: itemFromApi.valueOrNull!,
                        itemBookMetadata: itemBookMetadata,
                        bookDetailsCached: bookDetailsCached,
                      )
                    : const SizedBox.shrink(),
              ),
              // a row of actions like play, download, share, etc
              SliverToBoxAdapter(
                child: itemFromApi.valueOrNull != null
                    ? LibraryItemActions(item: itemFromApi.valueOrNull!)
                    : const SizedBox.shrink(),
              ),
              // a expandable section for book description
              SliverToBoxAdapter(
                child:
                    itemFromApi.valueOrNull?.media.metadata.description != null
                        ? ExpandableDescription(
                            title: 'About the Book',
                            content: itemFromApi
                                .valueOrNull!.media.metadata.description!,
                          )
                        : const SizedBox.shrink(),
              ),
              // a padding at the bottom to make sure the last item is not hidden by mini player
              const SliverToBoxAdapter(
                child: SizedBox(height: playerMinHeight),
              ),
            ],
          ),
        ),
      ),
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
