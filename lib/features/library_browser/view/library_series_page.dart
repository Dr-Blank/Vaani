import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shelfsdk/audiobookshelf_api.dart';
import 'package:vaani/api/library_browser_provider.dart';
import 'package:vaani/router/router.dart';

class LibrarySeriesPage extends HookConsumerWidget {
  const LibrarySeriesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final seriesAsync = ref.watch(librarySeriesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Series'),
      ),
      body: seriesAsync.when(
        data: (seriesList) {
          if (seriesList.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.library_books_outlined, size: 48),
                  const SizedBox(height: 16),
                  const Text('No series found'),
                  const SizedBox(height: 8),
                  Text(
                    'Check logs for API response details',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: seriesList.length,
            itemBuilder: (context, index) {
              final series = seriesList[index];
              return SeriesListTile(series: series);
            },
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stack) => Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 48, color: Colors.red),
                const SizedBox(height: 16),
                Text(
                  'Error loading series:',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  '$error',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
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

  final SimpleSeries series;

  @override
  Widget build(BuildContext context) {
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
          series.name,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        subtitle: series.numBooks != null
            ? Text('${series.numBooks} ${series.numBooks == 1 ? 'book' : 'books'}')
            : null,
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          // Navigate to filtered items page with series filter
          context.pushNamed(
            Routes.libraryFiltered.name,
            extra: {
              'filter': SeriesFilter(series.id),
              'title': series.name,
            },
          );
        },
      ),
    );
  }
}
