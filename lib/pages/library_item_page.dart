import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:whispering_pages/api/image_provider.dart';
import 'package:whispering_pages/api/library_item_provider.dart';
import 'package:whispering_pages/extensions/hero_tag_conventions.dart';
import 'package:whispering_pages/router/models/library_item_extras.dart';
import 'package:whispering_pages/widgets/shelves/book_shelf.dart';

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
    final item = ref.watch(libraryItemProvider(itemId));
    final providedCacheImage = extraMap?.coverImage != null
        ? Image.memory(extraMap!.coverImage!)
        : null;

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            // cover image
            Hero(
              tag: HeroTagPrefixes.bookCover +
                  itemId +
                  (extraMap?.heroTagSuffix ?? ''),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final width =
                      calculateWidth(context, constraints, heightRatio: 0.35);
                  return SizedBox(
                    height: width,
                    width: width,
                    child: providedCacheImage ??
                        item.when(
                          data: (libraryItem) {
                            final coverImage =
                                ref.watch(coverImageProvider(libraryItem));
                            return Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: coverImage.when(
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
                                ),
                              ],
                            );
                          },
                          error: (error, stack) =>
                              const CircularProgressIndicator(),
                          loading: () =>
                              const Center(child: BookCoverSkeleton()),
                        ),
                  );
                },
              ),
            ),
        
            // author

            // title


            // description
            const Text('Description'),
          ],
        ),
      ),
    );
  }
}

// child: Hero(
//   tag: HeroTagPrefixes.bookCover +
//       itemId +
//       (extraMap?.heroTagSuffix ?? ''),
//   child: Container(
//     color: Colors.amber,
//     height: 200,
//     width: 200,
//   ),
// ),

double calculateWidth(
  BuildContext context,
  BoxConstraints constraints, {
  double heightRatio = 0.25,
  double widthRatio = 0.9,
}) {
  final availHeight =
      min(constraints.maxHeight, MediaQuery.of(context).size.height);
  final availWidth =
      min(constraints.maxWidth, MediaQuery.of(context).size.width);

  // make the width 90% of the available width
  var width = availWidth * widthRatio;
  // but never exceed more than 25% of height
  if (width > availHeight * heightRatio) {
    width = availHeight * heightRatio;
  }

  return width;
}
