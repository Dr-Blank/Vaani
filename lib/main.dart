import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:whispering_pages/api/server_provider.dart';
import 'package:whispering_pages/db/storage.dart';
import 'package:whispering_pages/router/router.dart';
import 'package:whispering_pages/settings/api_settings_provider.dart';
import 'package:whispering_pages/settings/app_settings_provider.dart';
import 'package:whispering_pages/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // initialize the storage
  await initStorage();

  runApp(
    const ProviderScope(
      child: MyApp(),
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

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ref.watch(appSettingsProvider).isDarkMode
          ? ThemeMode.dark
          : ThemeMode.light,
      routerConfig: routerConfig,
    );
  }
}
