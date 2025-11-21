import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shelfsdk/audiobookshelf_api.dart';
import 'package:vaani/api/api_provider.dart';
import 'package:vaani/api/library_browser_provider.dart';
import 'package:vaani/router/router.dart';
import 'package:vaani/settings/api_settings_provider.dart';

class LibraryAuthorsPage extends HookConsumerWidget {
  const LibraryAuthorsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authorsAsync = ref.watch(libraryAuthorsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Authors'),
      ),
      body: authorsAsync.when(
        data: (authors) {
          if (authors.isEmpty) {
            return const Center(
              child: Text('No authors found'),
            );
          }

          // Sort authors alphabetically by surname (last word in name)
          final sortedAuthors = List<Author>.from(authors)
            ..sort((a, b) {
              final aSurname = a.name.split(' ').last.toLowerCase();
              final bSurname = b.name.split(' ').last.toLowerCase();
              return aSurname.compareTo(bSurname);
            });

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            cacheExtent: 500,  // Pre-render items for smoother scrolling
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: sortedAuthors.length,
            itemBuilder: (context, index) {
              final author = sortedAuthors[index];
              return RepaintBoundary(
                child: AuthorCard(author: author),
              );
            },
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 16),
              Text('Error loading authors: $error'),
            ],
          ),
        ),
      ),
    );
  }
}

class AuthorCard extends HookConsumerWidget {
  const AuthorCard({
    super.key,
    required this.author,
  });

  final Author author;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final apiSettings = ref.watch(apiSettingsProvider);
    final api = ref.watch(authenticatedApiProvider);

    // Determine the author variant and extract relevant data
    final String? imagePath = author.map(
      (base) => base.imagePath,
      minified: (minified) => null,
      expanded: (expanded) => expanded.imagePath,
    );

    final int? numBooks = author.map(
      (base) => base.libraryItems?.length,
      minified: (minified) => null,
      expanded: (expanded) => expanded.numBooks,
    );

    // Build the image URL if imagePath is available
    String? imageUrl;
    if (imagePath != null && apiSettings.activeServer != null) {
      imageUrl = '${apiSettings.activeServer!.serverUrl}/api/authors/${author.id}/image';
    }

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          // Navigate to filtered items page with author filter
          context.pushNamed(
            Routes.libraryFiltered.name,
            extra: {
              'filter': AuthorFilter(author.id),
              'title': author.name,
            },
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 3,
              child: imageUrl != null
                  ? CachedNetworkImage(
                      imageUrl: imageUrl,
                      httpHeaders: {
                        'Authorization': 'Bearer ${apiSettings.activeUser?.authToken}',
                      },
                      fit: BoxFit.cover,
                      fadeInDuration: Duration.zero,  // Remove fade animation for better performance
                      fadeOutDuration: Duration.zero,
                      memCacheHeight: 300,  // Limit memory cache size
                      maxHeightDiskCache: 600,  // Limit disk cache size
                      placeholder: (context, url) => Container(
                        color: Theme.of(context).colorScheme.surfaceContainerHighest,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: Theme.of(context).colorScheme.surfaceContainerHighest,
                        child: const Icon(Icons.person, size: 48),
                      ),
                    )
                  : Container(
                      color: Theme.of(context).colorScheme.surfaceContainerHighest,
                      child: const Icon(Icons.person, size: 48),
                    ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      author.name,
                      style: Theme.of(context).textTheme.titleMedium,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (numBooks != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        '$numBooks ${numBooks == 1 ? 'book' : 'books'}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
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
