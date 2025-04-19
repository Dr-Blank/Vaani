import 'package:flutter/material.dart';

class LibraryItemSliverAppBar extends StatelessWidget {
  const LibraryItemSliverAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      elevation: 0,
      floating: true,
      primary: true,
      snap: true,
      actions: [
        // cast button
        IconButton(onPressed: () {}, icon: const Icon(Icons.cast)),
        IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
      ],
    );
  }
}
