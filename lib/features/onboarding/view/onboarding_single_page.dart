import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vaani/api/api_provider.dart';
import 'package:vaani/features/onboarding/view/user_login.dart';
import 'package:vaani/settings/api_settings_provider.dart';
import 'package:vaani/shared/utils.dart';
import 'package:vaani/shared/widgets/add_new_server.dart';

class OnboardingSinglePage extends HookConsumerWidget {
  const OnboardingSinglePage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Center(
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: 600,
                  minWidth:
                      constraints.maxWidth < 600 ? constraints.maxWidth : 0,
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  child: SafeArea(child: OnboardingBody()),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class OnboardingBody extends HookConsumerWidget {
  const OnboardingBody({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final apiSettings = ref.watch(apiSettingsProvider);
    final serverUriController = useTextEditingController(
      text: apiSettings.activeServer?.serverUrl.toString() ?? 'https://',
    );
    var audiobookshelfUri = makeBaseUrl(serverUriController.text);

    final canUserLogin = useState(apiSettings.activeServer != null);

    fadeSlideTransitionBuilder(
      Widget child,
      Animation<double> animation,
    ) {
      return FadeTransition(
        opacity: animation,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 0.3),
            end: const Offset(0, 0),
          ).animate(animation),
          child: child,
        ),
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Welcome to Vaani',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        const SizedBox.square(
          dimension: 16.0,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: AnimatedSwitcher(
            duration: 500.ms,
            transitionBuilder: fadeSlideTransitionBuilder,
            child: canUserLogin.value
                ? Text(
                    'Server connected, please login',
                    key: const ValueKey('connected'),
                    style: Theme.of(context).textTheme.bodyMedium,
                  )
                : Text(
                    'Please enter the URL of your AudiobookShelf Server',
                    key: const ValueKey('not_connected'),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: AddNewServer(
            controller: serverUriController,
            allowEmpty: true,
            onPressed: () {
              canUserLogin.value = serverUriController.text.isNotEmpty;
            },
          ),
        ),
        const SizedBox.square(
          dimension: 16.0,
        ),
        AnimatedSwitcher(
          duration: 500.ms,
          transitionBuilder: fadeSlideTransitionBuilder,
          child: canUserLogin.value
              ? UserLoginWidget(
                  server: audiobookshelfUri,
                )
              // ).animate().fade(duration: 600.ms).slideY(begin: 0.3, end: 0)
              : const RedirectToABS().animate().fadeIn().slideY(
                    curve: Curves.easeInOut,
                    duration: 500.ms,
                  ),
        ),
      ],
    );
  }
}

class RedirectToABS extends StatelessWidget {
  const RedirectToABS({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // a simple text with hyper link to only the "click here" part
          const Text('Do not have a server? '),
          // a simple text with hyper link to the github page
          TextButton(
            autofocus: false,
            isSemanticButton: false,
            style: ButtonStyle(
              elevation: WidgetStateProperty.all(0),
              padding: WidgetStateProperty.all(
                const EdgeInsets.all(0),
              ),
            ),
            onPressed: () async {
              // open the github page
              // ignore: avoid_print
              print('Opening the github page');
              await handleLaunchUrl(
                Uri.parse(
                  'https://www.audiobookshelf.org',
                ),
              );
            },
            child: const Text('Click here'),
          ),
          const Text(' to know how to setup a server.'),
        ],
      ),
    );
  }
}
