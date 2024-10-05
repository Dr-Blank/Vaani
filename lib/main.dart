import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:vaani/api/server_provider.dart';
import 'package:vaani/db/storage.dart';
import 'package:vaani/features/downloads/providers/download_manager.dart';
import 'package:vaani/features/logging/core/logger.dart';
import 'package:vaani/features/playback_reporting/providers/playback_reporter_provider.dart';
import 'package:vaani/features/player/core/init.dart';
import 'package:vaani/features/player/providers/audiobook_player.dart'
    show audiobookPlayerProvider, simpleAudiobookPlayerProvider;
import 'package:vaani/features/shake_detection/providers/shake_detector.dart';
import 'package:vaani/features/sleep_timer/providers/sleep_timer_provider.dart';
import 'package:vaani/router/router.dart';
import 'package:vaani/settings/api_settings_provider.dart';
import 'package:vaani/settings/app_settings_provider.dart';
import 'package:vaani/theme/providers/system_them_provider.dart';
import 'package:vaani/theme/providers/theme_from_cover_provider.dart';
import 'package:vaani/theme/theme.dart';

final appLogger = Logger('vaani');

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Configure the root Logger
  await initLogging();

  // initialize the storage
  await initStorage();

  // initialize audio player
  await configurePlayer();

  // run the app
  runApp(
    const ProviderScope(
      child: _EagerInitialization(child: MyApp()),
    ),
  );
}

var routerConfig = const MyAppRouter().config;

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final servers = ref.watch(audiobookShelfServerProvider);
    final apiSettings = ref.watch(apiSettingsProvider);

    final needOnboarding = apiSettings.activeUser == null || servers.isEmpty;

    if (needOnboarding) {
      routerConfig.goNamed(Routes.onboarding.name);
    }
    final appSettings = ref.watch(appSettingsProvider);
    final themeSettings = appSettings.themeSettings;

    ColorScheme lightColorScheme = brandLightColorScheme;
    ColorScheme darkColorScheme = brandDarkColorScheme;

    final shouldUseHighContrast =
        MediaQuery.of(context).highContrast || themeSettings.highContrast;

    if (shouldUseHighContrast) {
      lightColorScheme = lightColorScheme.copyWith(
        surface: Colors.white,
      );
      darkColorScheme = darkColorScheme.copyWith(
        surface: Colors.black,
      );
    }

    if (themeSettings.useMaterialThemeFromSystem) {
      var themes =
          ref.watch(systemThemeProvider(highContrast: shouldUseHighContrast));
      if (themes.valueOrNull != null) {
        lightColorScheme = themes.valueOrNull!.$1;
        darkColorScheme = themes.valueOrNull!.$2;
      }
    }

    if (themeSettings.useMaterialThemeOfPlayingItem) {
      final player = ref.watch(audiobookPlayerProvider);
      if (player.book != null) {
        final themeLight = ref.watch(
          themeOfLibraryItemProvider(
            player.book!.libraryItemId,
            highContrast: shouldUseHighContrast,
            brightness: Brightness.light,
          ),
        );
        final themeDark = ref.watch(
          themeOfLibraryItemProvider(
            player.book!.libraryItemId,
            highContrast: shouldUseHighContrast,
            brightness: Brightness.dark,
          ),
        );
        if (themeLight.valueOrNull != null && themeDark.valueOrNull != null) {
          lightColorScheme = themeLight.valueOrNull!;
          darkColorScheme = themeDark.valueOrNull!;
        }
      }
    }
    final appThemeLight = ThemeData(
      useMaterial3: true,
      colorScheme: lightColorScheme.harmonized(),
    );
    final appThemeDark = ThemeData(
      useMaterial3: true,
      colorScheme: darkColorScheme.harmonized(),
      brightness: Brightness.dark,
      // TODO bottom sheet theme is not working
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: darkColorScheme.surface,
      ),
    );
    try {
      return MaterialApp.router(
        // debugShowCheckedModeBanner: false,
        theme: appThemeLight,
        darkTheme: appThemeDark,
        themeMode: themeSettings.themeMode,
        routerConfig: routerConfig,
        themeAnimationCurve: Curves.easeInOut,
      );
    } catch (e) {
      debugPrintStack(stackTrace: StackTrace.current, label: e.toString());
      if (needOnboarding) {
        routerConfig.goNamed(Routes.onboarding.name);
      }
      return const SizedBox.shrink();
    }
  }
}

// https://riverpod.dev/docs/essentials/eager_initialization
// Eagerly initialize providers by watching them.
class _EagerInitialization extends ConsumerWidget {
  const _EagerInitialization({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Eagerly initialize providers by watching them.
    // By using "watch", the provider will stay alive and not be disposed.
    try {
      ref.watch(simpleAudiobookPlayerProvider);
      ref.watch(sleepTimerProvider);
      ref.watch(playbackReporterProvider);
      ref.watch(simpleDownloadManagerProvider);
      ref.watch(shakeDetectorProvider);
    } catch (e) {
      debugPrintStack(stackTrace: StackTrace.current, label: e.toString());
    }

    return child;
  }
}
