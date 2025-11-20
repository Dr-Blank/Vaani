import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shelfsdk/audiobookshelf_api.dart';
import 'package:vaani/api/api_provider.dart';
import 'package:vaani/api/library_provider.dart';
import 'package:vaani/router/router.dart';
import 'package:vaani/settings/api_settings_provider.dart';

/// Page that displays library items filtered by author, genre, or series
class FilteredLibraryItemsPage extends HookConsumerWidget {
  const FilteredLibraryItemsPage({
    super.key,
    required this.filter,
    required this.title,
  });

  final Filter filter;
  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final api = ref.watch(authenticatedApiProvider);
    final currentLibraryAsync = ref.watch(currentLibraryProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: currentLibraryAsync.when(
        data: (library) {
          if (library == null) {
            return const Center(
              child: Text('No library selected'),
            );
          }

          return FutureBuilder<GetLibrarysItemsResponse?>(
            future: api.libraries.getItems(
              libraryId: library.id,
              parameters: GetLibrarysItemsReqParams(
                filter: filter,
                sort: 'media.metadata.title',
                limit: 100,
              ),
            ),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (snapshot.hasError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error_outline,
                          size: 48, color: Colors.red),
                      const SizedBox(height: 16),
                      Text('Error: ${snapshot.error}'),
                    ],
                  ),
                );
              }

              final response = snapshot.data;
              if (response == null || response.results.isEmpty) {
                return const Center(
                  child: Text('No items found'),
                );
              }

              return GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 0.68,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 16,
                ),
                itemCount: response.results.length,
                itemBuilder: (context, index) {
                  final item = response.results[index];
                  return LibraryItemCard(item: item);
                },
              );
            },
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stack) => Center(
          child: Text('Error: $error'),
        ),
      ),
    );
  }
}

class LibraryItemCard extends ConsumerWidget {
  const LibraryItemCard({
    super.key,
    required this.item,
  });

  final LibraryItem item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final apiSettings = ref.watch(apiSettingsProvider);
    final media = item.media;

    // Extract book info
    String title = '';
    String? authorName;

    // Use map to handle Media variants
    media.mapOrNull(
      book: (book) {
        final metadata = book.metadata;
        metadata.mapOrNull(
          book: (m) {
            title = m.title ?? 'Unknown';
            if (m.authors.isNotEmpty) {
              authorName = m.authors.map((a) => a.name).join(', ');
            }
          },
          bookMinified: (m) {
            title = m.title ?? 'Unknown';
            authorName = m.authorName;
          },
          bookExpanded: (m) {
            title = m.title ?? 'Unknown';
            if (m.authors.isNotEmpty) {
              authorName = m.authors.map((a) => a.name).join(', ');
            }
          },
        );
      },
      bookMinified: (book) {
        final metadata = book.metadata;
        metadata.mapOrNull(
          book: (m) {
            title = m.title ?? 'Unknown';
            if (m.authors.isNotEmpty) {
              authorName = m.authors.map((a) => a.name).join(', ');
            }
          },
          bookMinified: (m) {
            title = m.title ?? 'Unknown';
            authorName = m.authorName;
          },
          bookExpanded: (m) {
            title = m.title ?? 'Unknown';
            if (m.authors.isNotEmpty) {
              authorName = m.authors.map((a) => a.name).join(', ');
            }
          },
        );
      },
      bookExpanded: (book) {
        final metadata = book.metadata;
        metadata.mapOrNull(
          book: (m) {
            title = m.title ?? 'Unknown';
            if (m.authors.isNotEmpty) {
              authorName = m.authors.map((a) => a.name).join(', ');
            }
          },
          bookMinified: (m) {
            title = m.title ?? 'Unknown';
            authorName = m.authorName;
          },
          bookExpanded: (m) {
            title = m.title ?? 'Unknown';
            if (m.authors.isNotEmpty) {
              authorName = m.authors.map((a) => a.name).join(', ');
            }
          },
        );
      },
    );

    final imageUrl = apiSettings.activeServer != null
        ? '${apiSettings.activeServer!.serverUrl}/api/items/${item.id}/cover'
        : null;

    return InkWell(
      onTap: () {
        // Navigate to item detail page
        context.pushNamed(
          Routes.libraryItem.name,
          pathParameters: {'itemId': item.id},
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Book cover - always square
          AspectRatio(
            aspectRatio: 1.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: imageUrl != null
                  ? CachedNetworkImage(
                      imageUrl: imageUrl,
                      fit: BoxFit.cover,
                      httpHeaders: {
                        if (apiSettings.activeUser?.authToken != null)
                          'Authorization':
                              'Bearer ${apiSettings.activeUser!.authToken}',
                      },
                      placeholder: (context, url) => Container(
                        color: Theme.of(context).colorScheme.surfaceContainerHighest,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: Theme.of(context).colorScheme.surfaceContainerHighest,
                        child: const Icon(Icons.book, size: 48),
                      ),
                    )
                  : Container(
                      color: Theme.of(context).colorScheme.surfaceContainerHighest,
                      child: const Icon(Icons.book, size: 48),
                    ),
            ),
          ),
          const SizedBox(height: 8),
          // Book title
          Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          // Author name
          if (authorName != null)
            Text(
              authorName!,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
        ],
      ),
    );
  }
}
