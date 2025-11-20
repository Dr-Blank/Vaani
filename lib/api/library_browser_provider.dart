import 'package:hooks_riverpod/hooks_riverpod.dart' show Ref;
import 'package:logging/logging.dart' show Logger;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shelfsdk/audiobookshelf_api.dart' show Author;
import 'package:vaani/api/api_provider.dart' show authenticatedApiProvider;
import 'package:vaani/api/library_provider.dart' show currentLibraryProvider;

part 'library_browser_provider.g.dart';

/// Simple series data for display purposes
class SimpleSeries {
  final String id;
  final String name;
  final int? numBooks;

  SimpleSeries({
    required this.id,
    required this.name,
    this.numBooks,
  });

  factory SimpleSeries.fromJson(Map<String, dynamic> json) {
    return SimpleSeries(
      id: json['id'] as String,
      name: json['name'] as String,
      numBooks: json['numBooks'] as int?,
    );
  }
}

final _logger = Logger('LibraryBrowserProvider');

/// Provider for fetching all authors in the current library
@riverpod
Future<List<Author>> libraryAuthors(Ref ref) async {
  final api = ref.watch(authenticatedApiProvider);
  final currentLibrary = await ref.watch(currentLibraryProvider.future);

  if (currentLibrary == null) {
    _logger.warning('No current library found');
    return [];
  }

  final authors = await api.libraries.getAuthors(libraryId: currentLibrary.id);

  if (authors == null) {
    _logger.warning('Failed to fetch authors for library ${currentLibrary.id}');
    return [];
  }

  _logger.fine('Fetched ${authors.length} authors');
  return authors;
}

/// Provider for fetching all genres in the current library
@riverpod
Future<List<String>> libraryGenres(Ref ref) async {
  final api = ref.watch(authenticatedApiProvider);
  final currentLibrary = await ref.watch(currentLibraryProvider.future);

  if (currentLibrary == null) {
    _logger.warning('No current library found');
    return [];
  }

  // Use raw API call to avoid Series deserialization issues in LibraryFilterData
  final genres = await api.getJson<List<String>>(
    path: '/api/libraries/${currentLibrary.id}/filterdata',
    requiresAuth: true,
    fromJson: (json) {
      if (json is Map<String, dynamic> && json.containsKey('genres')) {
        final genresList = json['genres'] as List<dynamic>;
        return genresList.map((e) => e.toString()).toList();
      }
      return <String>[];
    },
  );

  if (genres == null) {
    _logger.warning('Failed to fetch genres for library ${currentLibrary.id}');
    return [];
  }

  _logger.fine('Fetched ${genres.length} genres');
  return genres;
}

/// Provider for fetching all series in the current library
@riverpod
Future<List<SimpleSeries>> librarySeries(Ref ref) async {
  final api = ref.watch(authenticatedApiProvider);
  final currentLibrary = await ref.watch(currentLibraryProvider.future);

  if (currentLibrary == null) {
    _logger.warning('No current library found');
    return [];
  }

  // Use raw API call to avoid Series deserialization issues
  final seriesList = await api.getJson<List<SimpleSeries>>(
    path: '/api/libraries/${currentLibrary.id}/series',
    requiresAuth: true,
    fromJson: (json) {
      if (json is Map<String, dynamic> && json.containsKey('results')) {
        final results = json['results'] as List<dynamic>;
        return results
            .map((e) => SimpleSeries.fromJson(e as Map<String, dynamic>))
            .toList();
      }
      return <SimpleSeries>[];
    },
  );

  if (seriesList == null) {
    _logger.warning('Failed to fetch series for library ${currentLibrary.id}');
    return [];
  }

  _logger.fine('Fetched ${seriesList.length} series');
  return seriesList;
}
