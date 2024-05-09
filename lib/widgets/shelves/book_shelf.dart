import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shelfsdk/audiobookshelf_api.dart';
import 'package:shimmer/shimmer.dart' show Shimmer;
import 'package:whispering_pages/api/image_provider.dart';
import 'package:whispering_pages/extensions/hero_tag_conventions.dart';
import 'package:whispering_pages/router/models/library_item_extras.dart';
import 'package:whispering_pages/router/router.dart';
import 'package:whispering_pages/widgets/shelves/home_shelf.dart';

/// A shelf that displays books on the home page
class BookHomeShelf extends HookConsumerWidget {
  const BookHomeShelf({
    super.key,
    required this.shelf,
    required this.title,
  });

  final String title;
  final LibraryItemShelf shelf;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SimpleHomeShelf(
      title: title,
      children: shelf.entities
          .map(
            (item) => switch (item.mediaType) {
              MediaType.book => BookOnShelf(
                  item: item,
                  key: ValueKey(shelf.id + item.id),
                  heroTagSuffix: shelf.id,
                ),
              _ => Container(),
            },
          )
          .toList(),
    );
  }
}

// a widget to display a item on the shelf
class BookOnShelf extends HookConsumerWidget {
  const BookOnShelf({
    super.key,
    required this.item,
    this.heroTagSuffix = '',
  });

  final LibraryItem item;

  /// makes the hero tag unique
  final String heroTagSuffix;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final book = BookMinified.fromJson(item.media.toJson());
    final metadata = BookMetadataMinified.fromJson(book.metadata.toJson());
    final coverImage = ref.watch(coverImageProvider(item));
    return LayoutBuilder(
      builder: (context, constraints) {
        final height = min(constraints.maxHeight, 500);
        final width = height * 0.75;
        return SizedBox(
          width: width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // the cover image of the book
              // take up remaining space
              Expanded(
                child: InkWell(
                  onTap: () {
                    // open the book
                    context.pushNamed(
                      Routes.libraryItem.name,
                      pathParameters: {
                        Routes.libraryItem.pathParamName: item.id,
                      },
                      extra: LibraryItemExtras(
                        book: book,
                        heroTagSuffix: heroTagSuffix,
                      ),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: coverImage.when(
                      data: (image) {
                        // return const BookCoverSkeleton();
                        if (image.isEmpty) {
                          return const Icon(Icons.error);
                        }
                        // cover 80% of parent height
                        return Hero(
                          tag: HeroTagPrefixes.bookCover +
                              item.id +
                              heroTagSuffix,
                          child: Image.memory(
                            image,
                            fit: BoxFit.cover,
                            cacheWidth: (height *
                                    MediaQuery.of(context).devicePixelRatio)
                                .round(),
                          ),
                        );
                      },
                      loading: () {
                        return const Center(child: BookCoverSkeleton());
                      },
                      error: (error, stack) {
                        return const Icon(Icons.error);
                      },
                    ),
                  ),
                ),
              ),
              // the title and author of the book
              // AutoScrollText(
              Text(
                metadata.title ?? '',
                // mode: AutoScrollTextMode.bouncing,
                // curve: Curves.easeInOut,
                // velocity: const Velocity(pixelsPerSecond: Offset(15, 0)),
                // delayBefore: const Duration(seconds: 2),
                // pauseBetween: const Duration(seconds: 2),
                // numberOfReps: 15,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 3),
              Text(
                metadata.authorName ?? '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        );
      },
    );
  }
}

// a skeleton for the book cover
class BookCoverSkeleton extends StatelessWidget {
  const BookCoverSkeleton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: SizedBox(
        width: 150,
        child: Shimmer.fromColors(
          baseColor: Theme.of(context).colorScheme.surface.withOpacity(0.3),
          highlightColor:
              Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
          child: Container(
            color: Theme.of(context).colorScheme.surface,
          ),
        ),
      ),
    );
  }
}
