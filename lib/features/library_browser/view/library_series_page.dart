import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shelfsdk/audiobookshelf_api.dart';
import 'package:vaani/api/library_browser_provider.dart';

class LibrarySeriesPage extends HookConsumerWidget {
  const LibrarySeriesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final seriesAsync = ref.watch(librarySeriesProvider());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Series'),
      ),
      body: seriesAsync.when(
        data: (seriesResponse) {
          if (seriesResponse == null || seriesResponse.results.isEmpty) {
            return const Center(
              child: Text('No series found'),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: seriesResponse.results.length,
            itemBuilder: (context, index) {
              final series = seriesResponse.results[index];
              return SeriesListTile(series: series);
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
              Text('Error loading series: $error'),
            ],
          ),
        ),
      ),
    );
  }
}

class SeriesListTile extends StatelessWidget {
  const SeriesListTile({
    super.key,
    required this.series,
  });

  final Series series;

  @override
  Widget build(BuildContext context) {
    // Extract series data based on variant
    final String seriesName = series.name;
    final int? numBooks = series.maybeMap(
      numBooks: (s) => s.numBooks,
      books: (s) => s.books.length,
      orElse: () => null,
    );

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondaryContainer,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            Icons.list,
            color: Theme.of(context).colorScheme.onSecondaryContainer,
          ),
        ),
        title: Text(
          seriesName,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        subtitle: numBooks != null
            ? Text('$numBooks ${numBooks == 1 ? 'book' : 'books'}')
            : null,
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          // TODO: Navigate to series detail page
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Tapped on $seriesName'),
              duration: const Duration(seconds: 1),
            ),
          );
        },
      ),
    );
  }
}
