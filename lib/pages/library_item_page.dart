import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:whispering_pages/api/api_provider.dart';
import 'package:whispering_pages/extensions/hero_tag_conventions.dart';
import 'package:whispering_pages/router/models/library_item_extras.dart';

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
    final views = ref.watch(personalizedViewProvider);
    final extraMap =
        extra is LibraryItemExtras ? extra as LibraryItemExtras : null;

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Hero(
          tag: HeroTagPrefixes.bookCover +
              itemId +
              (extraMap?.heroTagSuffix ?? ''),
          child: Container(
            color: Colors.amber,
            height: 200,
            width: 200,
          ),
        ),
      ),
    );
  }
}
