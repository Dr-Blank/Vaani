import 'dart:convert';

import 'package:logging/logging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shelfsdk/audiobookshelf_api.dart' as shelfsdk;
import 'package:vaani/api/api_provider.dart';
import 'package:vaani/db/cache/cache_key.dart';
import 'package:vaani/db/cache_manager.dart';
import 'package:vaani/shared/extensions/model_conversions.dart';

part 'library_item_provider.g.dart';

final _logger = Logger('LibraryItemProvider');

/// provides the library item for the given id
@Riverpod(keepAlive: true)
class LibraryItem extends _$LibraryItem {
  @override
  Stream<shelfsdk.LibraryItemExpanded> build(String id) async* {
    final api = ref.watch(authenticatedApiProvider);

    _logger.fine('LibraryItemProvider fetching library item: $id');

    // ! this is a mock delay
    // await Future.delayed(const Duration(seconds: 150));

    // look for the item in the cache
    final key = CacheKey.libraryItem(id);
    final cachedFile = await apiResponseCacheManager.getFileFromMemory(key) ??
        await apiResponseCacheManager.getFileFromCache(key);
    if (cachedFile != null) {
      _logger.fine(
        'LibraryItemProvider reading from cache for $id from ${cachedFile.file}',
      );
      // read file as json
      final cachedItem = shelfsdk.LibraryItemExpanded.fromJson(
        jsonDecode(await cachedFile.file.readAsString()),
      );
      yield cachedItem;
    } else {
      _logger.fine('LibraryItemProvider cache miss for $id');
    }

    // ! this is a mock delay
    // await Future.delayed(const Duration(seconds: 3));

    final item = await api.items.get(
      libraryItemId: id,
      parameters: const shelfsdk.GetItemReqParams(
        expanded: true,
        include: [
          shelfsdk.GetItemIncludeOption.progress,
          shelfsdk.GetItemIncludeOption.rssFeed,
          shelfsdk.GetItemIncludeOption.authors,
          shelfsdk.GetItemIncludeOption.downloads,
        ],
      ),
    );
    if (item != null) {
      // save to cache
      final newFile = await apiResponseCacheManager.putFile(
        key,
        utf8.encode(jsonEncode(item.asExpanded.toJson())),
        fileExtension: 'json',
        key: key,
      );
      _logger.fine('writing to cache: $newFile');
      yield item.asExpanded;
    }
  }
}
