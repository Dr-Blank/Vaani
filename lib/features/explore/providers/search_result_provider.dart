import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shelfsdk/audiobookshelf_api.dart';
import 'package:vaani/api/api_provider.dart';
import 'package:vaani/settings/api_settings_provider.dart';

part 'search_result_provider.g.dart';

/// The provider for the search result.
@riverpod
FutureOr<LibrarySearchResponse?> searchResult(
  Ref ref,
  String query, {
  int limit = 25,
}) async {
  final api = ref.watch(authenticatedApiProvider);
  final apiSettings = ref.watch(apiSettingsProvider);

  return await api.libraries.search(
    libraryId: apiSettings.activeLibraryId!,
    query: query,
    limit: limit,
  );
}
