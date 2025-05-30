import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vaani/api/image_provider.dart';

part 'theme_from_cover_provider.g.dart';

final _logger = Logger('ThemeFromCoverProvider');

@Riverpod(keepAlive: true)
Future<FutureOr<ColorScheme?>> themeFromCover(
  Ref ref,
  ImageProvider<Object> img, {
  Brightness brightness = Brightness.dark,
  bool highContrast = false,
}) async {
  // ! add deliberate delay to simulate a long running task as it interferes with other animations
  await Future.delayed(500.ms);

  _logger.fine('Generating color scheme from cover image');
  var theme = await ColorScheme.fromImageProvider(
    provider: img,
    brightness: brightness,
  );
  // set high contrast theme
  if (highContrast) {
    theme = theme
        .copyWith(
          surface: brightness == Brightness.light ? Colors.white : Colors.black,
        )
        .harmonized();
  }
  return theme;
  // TODO isolate is not working
  // see https://github.com/flutter/flutter/issues/119207
  // use isolate to generate the color scheme
  // RootIsolateToken? token = RootIsolateToken.instance;
  // final scheme = await Isolate.run(
  //   () async {
  //     _logger.fine('Isolate running ${Isolate.current.debugName}');
  //     try {
  //       BackgroundIsolateBinaryMessenger.ensureInitialized(token!);
  //       WidgetsFlutterBinding.ensureInitialized();
  //       return await ColorScheme.fromImageProvider(
  //         provider: img,
  //         brightness: brightness,
  //       );
  //     } catch (e) {
  //       _logger.fine('Error in isolate: $e');
  //       return null;
  //     }
  //   },
  // );
  // return scheme;
}

@Riverpod(keepAlive: true)
FutureOr<ColorScheme?> themeOfLibraryItem(
  Ref ref,
  String? itemId, {
  Brightness brightness = Brightness.dark,
  bool highContrast = false,
}) async {
  if (itemId == null) {
    return null;
  }
  final coverImage = await ref.watch(coverImageProvider(itemId).future);
  final val = await ref.watch(
    themeFromCoverProvider(
      MemoryImage(coverImage),
      brightness: brightness,
      highContrast: highContrast,
    ).future,
  );
  return val;
  // coverImage.when(
  //   data: (value) async {
  //     _logger.fine('CoverImage: $value');
  //     final val = ref.watch(themeFromCoverProvider(MemoryImage(value)));
  //     _logger.fine('ColorScheme generated: $val');
  //     ref.invalidateSelf();
  //     return val;
  //   },
  //   loading: () => null,
  //   error: (error, stackTrace) => null,
  // );
  // return null;
}
