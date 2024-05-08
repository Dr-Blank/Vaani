import 'package:auto_scroll_text/auto_scroll_text.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shelfsdk/audiobookshelf_api.dart';
import 'package:whispering_pages/api/image_provider.dart';
import 'package:whispering_pages/widgets/shelves/home_shelf.dart';

/// A shelf that displays books on the home page
class BookHomeShelf extends HookConsumerWidget {
  const BookHomeShelf({
    super.key,
    required this.shelf,
    required this.title,
  });

  final Widget title;
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
  });

  final LibraryItem item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final book = BookMinified.fromJson(item.media.toJson());
    final metadata = BookMetadataMinified.fromJson(book.metadata.toJson());
    final coverImage = ref.watch(coverImageProvider(item));
    const coverSize = 150.0;
    return Container(
      margin: const EdgeInsets.only(right: 10, bottom: 10),
      constraints: const BoxConstraints(maxWidth: coverSize),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: AspectRatio(
              aspectRatio: 1,
              child: Container(
                constraints: const BoxConstraints(maxWidth: coverSize),
                color: Colors.grey[800],
                child: coverImage.when(
                  data: (image) {
                    if (image.isEmpty) {
                      return const Icon(Icons.error);
                    }
                    return Image.memory(
                      image,
                      fit: BoxFit.cover,
                      cacheWidth:
                          (coverSize * MediaQuery.of(context).devicePixelRatio)
                              .round(),
                    );
                  },
                  loading: () {
                    return const Center(child: CircularProgressIndicator());
                  },
                  error: (error, stack) {
                    return const Icon(Icons.error);
                  },
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoScrollText(
                  metadata.title ?? '',
                  mode: AutoScrollTextMode.bouncing,
                  curve: Curves.easeInOut,
                  velocity: const Velocity(pixelsPerSecond: Offset(15, 0)),
                  delayBefore: const Duration(seconds: 2),
                  pauseBetween: const Duration(seconds: 2),
                  numberOfReps: 15,
                  // maxLines: 1,
                  // overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 3),
                Text(
                  metadata.authorName ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
