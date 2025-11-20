import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vaani/api/library_browser_provider.dart';

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
            return const Center(
              child: Text('No series found'),
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
          // TODO: Navigate to series detail page
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Tapped on ${series.name}'),
              duration: const Duration(seconds: 1),
            ),
          );
        },
      ),
    );
  }
}
