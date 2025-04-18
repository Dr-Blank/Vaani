import 'package:hooks_riverpod/hooks_riverpod.dart' show Ref;
import 'package:logging/logging.dart' show Logger;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:shelfsdk/audiobookshelf_api.dart' show Library;
import 'package:vaani/api/api_provider.dart' show authenticatedApiProvider;
part 'library_provider.g.dart';

final _logger = Logger('LibraryProvider');

@riverpod
Future<Library?> currentLibrary(Ref ref, String id) async {
  final api = ref.watch(authenticatedApiProvider);
  final library = await api.libraries.get(libraryId: id);
  if (library == null) {
    _logger.warning('No library found through id: $id');
    //  try to get the library from the list of libraries
    final libraries = await ref.watch(librariesProvider.future);
    for (final lib in libraries) {
      if (lib.id == id) {
        return lib;
      }
    }
    _logger.warning('No library found in the list of libraries');
    return null;
  }
  return library.library;
}

@riverpod
class Libraries extends _$Libraries {
  @override
  FutureOr<List<Library>> build() async {
    final api = ref.watch(authenticatedApiProvider);
    final libraries = await api.libraries.getAll();
    if (libraries == null) {
      _logger.warning('Failed to fetch libraries');
      return [];
    }
    return libraries;
  }
}
