import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shelfsdk/audiobookshelf_api.dart';
import 'package:whispering_pages/api/image_provider.dart';

part 'theme_from_cover_provider.g.dart';

@riverpod
FutureOr<ColorScheme> themeFromCover(
  ThemeFromCoverRef ref,
  ImageProvider<Object> img, {
  Brightness brightness = Brightness.dark,
}) {
  return ColorScheme.fromImageProvider(
    provider: img,
    brightness: brightness,
  );
}

@riverpod
FutureOr<ColorScheme?> themeOfLibraryItem(
  ThemeOfLibraryItemRef ref,
  LibraryItem? item, {
  Brightness brightness = Brightness.dark,
}) async {
  if (item == null) {
    return null;
  }
  final coverImage = await ref.watch(coverImageProvider(item).future);
  final val = await ref.watch(
    themeFromCoverProvider(MemoryImage(coverImage), brightness: brightness)
        .future,
  );
  return val;
  // coverImage.when(
  //   data: (value) async {
  //     debugPrint('CoverImage: $value');
  //     final val = ref.watch(themeFromCoverProvider(MemoryImage(value)));
  //     debugPrint('ColorScheme generated: $val');
  //     ref.invalidateSelf();
  //     return val;
  //   },
  //   loading: () => null,
  //   error: (error, stackTrace) => null,
  // );
  // return null;
}
