import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shelfsdk/audiobookshelf_api.dart' as shelfsdk;
import 'package:whispering_pages/api/image_provider.dart';
import 'package:whispering_pages/api/library_item_provider.dart';
import 'package:whispering_pages/extensions/hero_tag_conventions.dart';
import 'package:whispering_pages/router/models/library_item_extras.dart';
import 'package:whispering_pages/settings/app_settings_provider.dart';
import 'package:whispering_pages/theme/theme_from_cover_provider.dart';
import 'package:whispering_pages/widgets/shelves/book_shelf.dart';

import '../widgets/library_item_sliver_app_bar.dart';

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

    final item = ref.watch(libraryItemProvider(itemId));
    var itemBookMetadata =
        item.valueOrNull?.media.metadata as shelfsdk.BookMetadata?;

    final useMaterialThemeOnItemPage =
        ref.watch(appSettingsProvider).useMaterialThemeOnItemPage;
    AsyncValue<ColorScheme?> coverColorScheme = const AsyncValue.loading();
    if (useMaterialThemeOnItemPage) {
      coverColorScheme = ref.watch(
        themeOfLibraryItemProvider(
          item.valueOrNull,
          brightness: Theme.of(context).brightness,
        ),
      );
      debugPrint('ColorScheme: ${coverColorScheme.valueOrNull}');
    } else {
      debugPrint('useMaterialThemeOnItemPage is false');
      // AsyncValue<ColorScheme?> coverColorScheme = const AsyncValue.loading();
    }
    return Theme(
      data: coverColorScheme.valueOrNull != null && useMaterialThemeOnItemPage
          ? ThemeData.from(
              colorScheme: coverColorScheme.valueOrNull!,
              textTheme: Theme.of(context).textTheme,
            )
          : Theme.of(context),
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            const LibraryItemSliverAppBar(),
            SliverPadding(
              padding: const EdgeInsets.all(8),
              sliver: SliverToBoxAdapter(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    LayoutBuilder(
                      builder: (context, constraints) {
                        return SizedBox(
                          height: calculateWidth(
                            context,
                            constraints,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: _BookCover(
                              itemId: itemId,
                              extraMap: extraMap,
                              providedCacheImage: providedCacheImage,
                              item: item,
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox.square(
                      dimension: 8,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _BookTitle(
                            extraMap: extraMap,
                            itemBookMetadata: itemBookMetadata,
                            bookDetailsCached: bookDetailsCached,
                          ),
                          _BookAuthors(
                            itemBookMetadata: itemBookMetadata,
                            bookDetailsCached: bookDetailsCached,
                            coverColorScheme: coverColorScheme.valueOrNull,
                          ),
                          // series info if available

                          // narrators info if available
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BookCover extends HookConsumerWidget {
  const _BookCover({
    super.key,
    required this.itemId,
    required this.extraMap,
    required this.providedCacheImage,
    required this.item,
  });

  final String itemId;
  final LibraryItemExtras? extraMap;
  final Image? providedCacheImage;
  final AsyncValue<shelfsdk.LibraryItem> item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Hero(
      tag: HeroTagPrefixes.bookCover + itemId + (extraMap?.heroTagSuffix ?? ''),
      child: providedCacheImage ??
          item.when(
            data: (libraryItem) {
              final coverImage = ref.watch(coverImageProvider(libraryItem));
              return Stack(
                children: [
                  coverImage.when(
                    data: (image) {
                      // return const BookCoverSkeleton();
                      if (image.isEmpty) {
                        return const Icon(Icons.error);
                      }
                      // cover 80% of parent height
                      return Image.memory(
                        image,
                        fit: BoxFit.cover,
                        // cacheWidth: (height *
                        //         MediaQuery.of(context).devicePixelRatio)
                        //     .round(),
                      );
                    },
                    loading: () {
                      return const Center(
                        child: BookCoverSkeleton(),
                      );
                    },
                    error: (error, stack) {
                      return const Icon(Icons.error);
                    },
                  ),
                ],
              );
            },
            error: (error, stack) => const Icon(Icons.error),
            loading: () => const Center(child: BookCoverSkeleton()),
          ),
    );
  }
}

class _BookTitle extends StatelessWidget {
  const _BookTitle({
    super.key,
    required this.extraMap,
    required this.itemBookMetadata,
    required this.bookDetailsCached,
  });

  final LibraryItemExtras? extraMap;
  final shelfsdk.BookMetadata? itemBookMetadata;
  final shelfsdk.BookMinified? bookDetailsCached;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: HeroTagPrefixes.bookTitle +
          // itemId +
          (extraMap?.heroTagSuffix ?? ''),
      child: Text(
        // mode: AutoScrollTextMode.bouncing,
        // curve: Curves.fastEaseInToSlowEaseOut,
        // velocity: const Velocity(pixelsPerSecond: Offset(30, 0)),
        // delayBefore: 500.ms,
        // pauseBetween: 150.ms,
        // numberOfReps: 3,
        style: Theme.of(context).textTheme.headlineSmall,
        itemBookMetadata?.title ?? bookDetailsCached?.metadata.title ?? '',
      ),
    );
  }
}

class _BookAuthors extends StatelessWidget {
  const _BookAuthors({
    super.key,
    required this.itemBookMetadata,
    required this.bookDetailsCached,
    this.coverColorScheme,
  });

  final shelfsdk.BookMetadata? itemBookMetadata;
  final shelfsdk.BookMinified? bookDetailsCached;
  final ColorScheme? coverColorScheme;

  @override
  Widget build(BuildContext context) {
    String generateAuthorsString() {
      final authors = (itemBookMetadata)?.authors ?? [];
      if (authors.isEmpty) {
        return (bookDetailsCached?.metadata as shelfsdk.BookMetadataMinified?)
                ?.authorName ??
            '';
      }
      return authors.map((e) => e.name).join(', ');
    }

    return Row(
      children: [
        Container(
          margin: const EdgeInsets.only(right: 8),
          child: FaIcon(
            FontAwesomeIcons.penNib,
            size: 16,
            color: coverColorScheme?.primary ??
                Theme.of(context).colorScheme.onBackground,
          ),
        ),
        Expanded(
          child: Text(
            style: Theme.of(context).textTheme.titleSmall,
            generateAuthorsString(),
          ),
        ),
      ],
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
  double maxHeightToUse = 0.2,
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
