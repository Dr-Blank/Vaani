import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:vaani/api/server_provider.dart';
import 'package:vaani/db/storage.dart';
import 'package:vaani/features/downloads/providers/download_manager.dart';
import 'package:vaani/features/playback_reporting/providers/playback_reporter_provider.dart';
import 'package:vaani/features/player/core/init.dart';
import 'package:vaani/features/player/providers/audiobook_player.dart';
import 'package:vaani/features/shake_detection/providers/shake_detector.dart';
import 'package:vaani/features/sleep_timer/providers/sleep_timer_provider.dart';
import 'package:vaani/router/router.dart';
import 'package:vaani/settings/api_settings_provider.dart';
import 'package:vaani/settings/app_settings_provider.dart';
import 'package:vaani/shared/extensions/duration_format.dart';
import 'package:vaani/theme/theme.dart';

final appLogger = Logger('vaani');

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Configure the root Logger
  Logger.root.level = Level.FINE; // Capture all logs
  Logger.root.onRecord.listen((record) {
    // Print log records to the console
    debugPrint(
      '${record.loggerName}: ${record.level.name}: ${record.time.time}: ${record.message}',
    );
  });

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

    try {
      return MaterialApp.router(
        // debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ref.watch(appSettingsProvider).themeSettings.isDarkMode
            ? ThemeMode.dark
            : ThemeMode.light,
        routerConfig: routerConfig,
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
