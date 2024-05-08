import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shelfsdk/audiobookshelf_api.dart';
import 'package:whispering_pages/widgets/shelves/author_shelf.dart';
import 'package:whispering_pages/widgets/shelves/book_shelf.dart';

/// A shelf that displays books/authors/series on the home page
///
/// this will build the appropriate shelf based on the type of the shelf
class HomeShelf extends HookConsumerWidget {
  const HomeShelf({
    super.key,
    required this.shelf,
    required this.title,
  });

  final Widget title;
  final Shelf shelf;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return switch (shelf.type) {
      ShelfType.book => BookHomeShelf(
          title: title,
          shelf: LibraryItemShelf.fromJson(shelf.toJson()),
        ),
      ShelfType.authors => AuthorHomeShelf(
          title: title,
          shelf: AuthorShelf.fromJson(shelf.toJson()),
        ),
      _ => Container(),
    };
  }
}

/// A shelf that displays books on the home page
class SimpleHomeShelf extends HookConsumerWidget {
  const SimpleHomeShelf({
    super.key,
    required this.children,
    required this.title,
  });

  final Widget title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          title,
          const SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: children,
            ),
          ),
        ],
      ),
    );
  }
}
