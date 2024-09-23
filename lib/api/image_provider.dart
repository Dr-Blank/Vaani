import 'dart:typed_data';

import 'package:logging/logging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shelfsdk/audiobookshelf_api.dart';
import 'package:vaani/api/api_provider.dart';
import 'package:vaani/api/library_item_provider.dart';
import 'package:vaani/db/cache_manager.dart';

/// provides cover images for the audiobooks
///
/// is a stream provider that provides cover images first from the cache then from the server
/// if the image is not found in the cache, it will be fetched from the server and saved to the cache
/// if the image is not found in the server it will throw an error

part 'image_provider.g.dart';

final _logger = Logger('cover_image_provider');

@Riverpod(keepAlive: true)
class CoverImage extends _$CoverImage {
  @override
  Stream<Uint8List> build(String itemId) async* {
    final api = ref.watch(authenticatedApiProvider);

    // ! artifical delay for testing
    // await Future.delayed(const Duration(seconds: 2));

    // try to get the image from the cache
    final file = await imageCacheManager.getFileFromMemory(itemId) ??
        await imageCacheManager.getFileFromCache(itemId);

    if (file != null) {
      // if the image is in the cache, yield it
      _logger.fine(
        'cover image found in cache for $itemId at ${file.file.path}',
      );
      yield await file.file.readAsBytes();
      final libraryItem = await ref.watch(libraryItemProvider(itemId).future);
      // return if no need to fetch from the server
      if (libraryItem.updatedAt.isBefore(await file.file.lastModified())) {
        _logger.fine(
          'cover image is up to date for $itemId, no need to fetch from the server',
        );
        return;
      } else {
        _logger.fine(
          'cover image stale for $itemId, fetching from the server',
        );
      }
    } else {
      _logger.fine('cover image not found in cache for $itemId');
    }

    // check if the image is in the cache
    final coverImage = await api.items.getCover(
      libraryItemId: itemId,
      parameters: const GetImageReqParams(width: 1200),
    );
    // save the image to the cache
    if (coverImage != null) {
      final newFile = await imageCacheManager.putFile(
        itemId,
        coverImage,
        key: itemId,
        fileExtension: 'jpg',
      );
      _logger.fine(
        'cover image fetched for for $itemId, file time: ${await newFile.lastModified()}',
      );
    }

    yield coverImage ?? Uint8List(0);
  }
}
