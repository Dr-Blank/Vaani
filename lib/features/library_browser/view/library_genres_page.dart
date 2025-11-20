import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shelfsdk/audiobookshelf_api.dart';
import 'package:vaani/api/library_browser_provider.dart';
import 'package:vaani/router/router.dart';

class LibraryGenresPage extends HookConsumerWidget {
  const LibraryGenresPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final genresAsync = ref.watch(libraryGenresProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Genres'),
      ),
      body: genresAsync.when(
        data: (genres) {
          if (genres.isEmpty) {
            return const Center(
              child: Text('No genres found'),
            );
          }

          // Sort genres alphabetically
          final sortedGenres = List<String>.from(genres)..sort();

          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: sortedGenres.length,
            itemBuilder: (context, index) {
              final genre = sortedGenres[index];
              return GenreListTile(genre: genre);
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
              Text('Error loading genres: $error'),
            ],
          ),
        ),
      ),
    );
  }
}

class GenreListTile extends StatelessWidget {
  const GenreListTile({
    super.key,
    required this.genre,
  });

  final String genre;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            Icons.category,
            color: Theme.of(context).colorScheme.onPrimaryContainer,
          ),
        ),
        title: Text(
          genre,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          // Navigate to filtered items page with genre filter
          context.pushNamed(
            Routes.libraryFiltered.name,
            extra: {
              'filter': GenreFilter(genre),
              'title': genre,
            },
          );
        },
      ),
    );
  }
}
