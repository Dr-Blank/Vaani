import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shelfsdk/audiobookshelf_api.dart' as shelfsdk;
import 'package:whispering_pages/api/api_provider.dart';
import 'package:whispering_pages/db/cache/cache_key.dart';
import 'package:whispering_pages/db/cache_manager.dart';

part 'library_item_provider.g.dart';

/// provides the library item for the given id
@riverpod
class LibraryItem extends _$LibraryItem {
  @override
  Stream<shelfsdk.LibraryItem> build(String id) async* {
    final api = ref.watch(authenticatedApiProvider);

    debugPrint('fetching library item: $id');

    // ! this is a mock delay
    // await Future.delayed(const Duration(seconds: 10));

    // look for the item in the cache
    final key = CacheKey.libraryItem(id);
    final cachedFile = await apiResponseCacheManager.getFileFromMemory(key) ??
        await apiResponseCacheManager.getFileFromCache(key);
    if (cachedFile != null) {
      debugPrint('reading from cache for $id from ${cachedFile.file}');
      // read file as json
      final cachedItem = shelfsdk.LibraryItem.fromJson(
        jsonDecode(await cachedFile.file.readAsString()),
      );
      yield cachedItem;
    }
    final item = await api.items.get(
      libraryItemId: id,
      parameters: const shelfsdk.GetItemReqParams(expanded: true),
    );
    if (item != null) {
      // save to cache
      final newFile = await apiResponseCacheManager.putFile(
        key,
        utf8.encode(jsonEncode(item)),
        fileExtension: 'json',
        key: key,
      );
      debugPrint('writing to cache: $newFile');
      yield item;
    }
  }
}
