import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shelfsdk/audiobookshelf_api.dart';
import 'package:vaani/shared/extensions/model_conversions.dart';
import 'package:vaani/shared/widgets/shelves/home_shelf.dart';

/// A shelf that displays Authors on the home page
class AuthorHomeShelf extends HookConsumerWidget {
  const AuthorHomeShelf({
    super.key,
    required this.shelf,
    required this.title,
  });

  final String title;
  final AuthorShelf shelf;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SimpleHomeShelf(
      title: title,
      children: shelf.entities
          .map(
            (item) => AuthorOnShelf(item: item),
          )
          .toList(),
    );
  }
}

// a widget to display a item on the shelf
class AuthorOnShelf extends HookConsumerWidget {
  const AuthorOnShelf({
    super.key,
    required this.item,
  });

  final Author item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final author = item.asMinified;
    // final coverImage = ref.watch(coverImageProvider(item));

    return Container(
      margin: const EdgeInsets.only(right: 10, bottom: 10),
      constraints: const BoxConstraints(maxWidth: 100),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: AspectRatio(
              aspectRatio: 1,
              child: Container(
                constraints: const BoxConstraints(maxWidth: 50),
                // child: coverImage.when(
                //   data: (image) {
                //     return Image.memory(image, fit: BoxFit.cover);
                //   },
                //   loading: () {
                //     return const Center(child: CircularProgressIndicator());
                //   },
                //   error: (error, stack) {
                //     return const Icon(Icons.error);
                //   },
                // ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(5),
            child: Text(
              author.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
