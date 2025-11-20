import 'package:hooks_riverpod/hooks_riverpod.dart' show Ref;
import 'package:logging/logging.dart' show Logger;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shelfsdk/audiobookshelf_api.dart'
    show Author, GetLibrarysSeriesResponse, LibraryFilterData;
import 'package:vaani/api/api_provider.dart' show authenticatedApiProvider;
import 'package:vaani/api/library_provider.dart' show currentLibraryProvider;

part 'library_browser_provider.g.dart';

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

  final filterData = await api.libraries.getFilterData(libraryId: currentLibrary.id);

  if (filterData == null) {
    _logger.warning('Failed to fetch filter data for library ${currentLibrary.id}');
    return [];
  }

  _logger.fine('Fetched ${filterData.genres.length} genres');
  return filterData.genres;
}

/// Provider for fetching all series in the current library
@riverpod
Future<GetLibrarysSeriesResponse?> librarySeries(Ref ref, {int page = 0, int limit = 50}) async {
  final api = ref.watch(authenticatedApiProvider);
  final currentLibrary = await ref.watch(currentLibraryProvider.future);

  if (currentLibrary == null) {
    _logger.warning('No current library found');
    return null;
  }

  final series = await api.libraries.getSeries(
    libraryId: currentLibrary.id,
  );

  if (series == null) {
    _logger.warning('Failed to fetch series for library ${currentLibrary.id}');
    return null;
  }

  _logger.fine('Fetched ${series.results.length} series (${series.total} total)');
  return series;
}
