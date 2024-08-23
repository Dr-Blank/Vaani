import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vaani/router/router.dart';

class LibraryBrowserPage extends HookConsumerWidget {
  const LibraryBrowserPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Library'),
        backgroundColor: Colors.transparent,
      ),
      // a list redirecting to authors, genres, and series pages
      body: ListView(
        children: [
          ListTile(
            title: const Text('Authors'),
            leading: const Icon(Icons.person),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Genres'),
            leading: const Icon(Icons.category),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Series'),
            leading: const Icon(Icons.list),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          // Downloads
          ListTile(
            title: const Text('Downloads'),
            leading: const Icon(Icons.download),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              GoRouter.of(context).pushNamed(Routes.downloads.name);
            },
          ),
        ],
      ),
    );
  }
}
