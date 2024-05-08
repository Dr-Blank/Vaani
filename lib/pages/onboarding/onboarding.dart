import 'package:coast/coast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:whispering_pages/pages/onboarding/server_setup.dart';
import 'package:whispering_pages/pages/onboarding/user_login.dart';
import 'package:whispering_pages/settings/api_settings_provider.dart';

const _serverTag = 'server';

class OnboardingPage extends StatefulHookConsumerWidget {
  const OnboardingPage({super.key});

  @override
  OnboardingPageState createState() => OnboardingPageState();
}

class OnboardingPageState extends ConsumerState<OnboardingPage> {
  final coastController = CoastController();

  @override
  void dispose() {
    coastController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final apiSettings = ref.watch(apiSettingsProvider);

    final serverUriController = useTextEditingController(
      text: apiSettings.activeServer?.serverUrl.toString(),
    );

    bool isUserLoginAvailable() {
      return apiSettings.activeServer != null;
    }

    // ignore: invalid_use_of_protected_member
    if (isUserLoginAvailable()) {
      try {
        coastController.animateTo(
          beach: 1,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      } catch (e) {
        debugPrint('Error: $e');
      }
    }

    final beaches = [
      Beach(
        builder: (context) => FirstTimeServerSetupPage(
          controller: serverUriController,
          heroServerTag: _serverTag,
        ),
      ),
      isUserLoginAvailable()
          ? Beach(
              builder: (context) => FirstTimeUserLoginPage(
                serverUriController: serverUriController,
                heroServerTag: _serverTag,
              ),
            )
          : null,
    ].nonNulls.toList();
    const activeStep = 0;
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Coast(
              beaches: beaches,
              controller: coastController,
              observers: [
                CrabController(),
              ],
            ),
          ),
          Positioned(
            child: Container(),
          ),
        ],
      ),
    );
  }
}
