import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shelfsdk/audiobookshelf_api.dart';
import 'package:whispering_pages/api/api_provider.dart';
import 'package:whispering_pages/db/cache_manager.dart';

/// provides cover images for the audiobooks
///
/// is a stream provider that provides cover images first from the cache then from the server
/// if the image is not found in the cache, it will be fetched from the server and saved to the cache
/// if the image is not found in the server it will throw an error

part 'image_provider.g.dart';

@riverpod
class CoverImage extends _$CoverImage {
  @override
  Stream<Uint8List> build(LibraryItem libraryItem) async* {
    final api = ref.watch(authenticatedApiProvider);

    // ! artifical delay for testing
    // await Future.delayed(const Duration(seconds: 2));

    // try to get the image from the cache
    final file = await imageCacheManager.getFileFromMemory(libraryItem.id) ??
        await imageCacheManager.getFileFromCache(libraryItem.id);

    if (file != null) {
      // if the image is in the cache, yield it
      debugPrint(
        'cover image found in cache for ${libraryItem.id} at ${file.file.path}',
      );
      yield await file.file.readAsBytes();
      // return if no need to fetch from the server
      if (libraryItem.updatedAt.isBefore(await file.file.lastModified())) {
        debugPrint(
          'cover image is up to date for ${libraryItem.id}, no need to fetch from the server',
        );
        return;
      } else {
        debugPrint(
          'cover image stale for ${libraryItem.id}, fetching from the server',
        );
      }
    }

    // check if the image is in the cache
    final coverImage = await api.items.getCover(
      libraryItemId: libraryItem.id,
      parameters: const GetImageReqParams(width: 1200),
    );
    // save the image to the cache
    if (coverImage != null) {
      final newFile = await imageCacheManager.putFile(
        libraryItem.id,
        coverImage,
        key: libraryItem.id,
      );
      debugPrint(
        'cover image fetched for for ${libraryItem.id}, file time: ${await newFile.lastModified()}',
      );
    }

    yield coverImage ?? Uint8List(0);
  }
}
