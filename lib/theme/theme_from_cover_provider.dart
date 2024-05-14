import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shelfsdk/audiobookshelf_api.dart';
import 'package:whispering_pages/api/image_provider.dart';

part 'theme_from_cover_provider.g.dart';

@Riverpod(keepAlive: true)
Future<FutureOr<ColorScheme?>> themeFromCover(
  ThemeFromCoverRef ref,
  ImageProvider<Object> img, {
  Brightness brightness = Brightness.dark,
}) async {
  // ! add deliberate delay to simulate a long running task
  await Future.delayed(500.ms);

  debugPrint('Generating color scheme from cover image');
  return ColorScheme.fromImageProvider(
    provider: img,
    brightness: brightness,
  );
  // TODO isolate is not working
  // see https://github.com/flutter/flutter/issues/119207
  // use isolate to generate the color scheme
  // RootIsolateToken? token = RootIsolateToken.instance;
  // final scheme = await Isolate.run(
  //   () async {
  //     debugPrint('Isolate running ${Isolate.current.debugName}');
  //     try {
  //       BackgroundIsolateBinaryMessenger.ensureInitialized(token!);
  //       WidgetsFlutterBinding.ensureInitialized();
  //       return await ColorScheme.fromImageProvider(
  //         provider: img,
  //         brightness: brightness,
  //       );
  //     } catch (e) {
  //       debugPrint('Error in isolate: $e');
  //       return null;
  //     }
  //   },
  // );
  // return scheme;
}

@Riverpod(keepAlive: true)
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
