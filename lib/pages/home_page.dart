import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vaani/api/api_provider.dart';
import 'package:vaani/main.dart';
import 'package:vaani/router/router.dart';
import 'package:vaani/settings/api_settings_provider.dart';
import 'package:vaani/settings/app_settings_provider.dart'
    show appSettingsProvider;

import '../shared/widgets/shelves/home_shelf.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final views = ref.watch(personalizedViewProvider);
    final apiSettings = ref.watch(apiSettingsProvider);
    final scrollController = useScrollController();
    final appSettings = ref.watch(appSettingsProvider);
    final homePageSettings = appSettings.homePageSettings;
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          child: Text(
            'Vaani',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          onTap: () {
            // scroll to the top of the page
            scrollController.animateTo(
              0,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
            // refresh the view
            ref.invalidate(personalizedViewProvider);
          },
        ),
      ),
      body: Container(
        child: views.when(
          data: (data) {
            if (data.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('No shelves to display'),
                    // try again button
                    ElevatedButton(
                      onPressed: () {
                        ref.read(apiSettingsProvider.notifier).updateState(
                              apiSettings.copyWith(activeLibraryId: null),
                            );
                        ref.invalidate(personalizedViewProvider);
                      },
                      child: const Text('Try again'),
                    ),
                  ],
                ),
              );
            }
            final shelvesToDisplay = data
                // .where((element) => !element.id.contains('discover'))
                .map((shelf) {
              appLogger.fine('building shelf ${shelf.label}');
              // check if showPlayButton is enabled for the shelf
              // using the id of the shelf
              final showPlayButton = switch (shelf.id) {
                'continue-listening' =>
                  homePageSettings.showPlayButtonOnContinueListeningShelf,
                'continue-series' =>
                  homePageSettings.showPlayButtonOnContinueSeriesShelf,
                'listen-again' =>
                  homePageSettings.showPlayButtonOnListenAgainShelf,
                _ => homePageSettings.showPlayButtonOnAllRemainingShelves,
              };
              return HomeShelf(
                title: shelf.label,
                shelf: shelf,
                showPlayButton: showPlayButton,
              );
            }).toList();
            return RefreshIndicator(
              onRefresh: () async {
                return ref.refresh(personalizedViewProvider);
              },
              child: ListView.separated(
                itemBuilder: (context, index) => shelvesToDisplay[index],
                separatorBuilder: (context, index) => Divider(
                  color: Theme.of(context).dividerColor.withValues(alpha: 0.1),
                  indent: 16,
                  endIndent: 16,
                ),
                itemCount: shelvesToDisplay.length,
                controller: scrollController,
              ),
            );
          },
          loading: () => const HomePageSkeleton(),
          error: (error, stack) {
            if (apiSettings.activeUser == null ||
                apiSettings.activeServer == null) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Error: $error'),
                    ElevatedButton(
                      onPressed: () {
                        GoRouter.of(context).goNamed(Routes.onboarding.name);
                      },
                      child: const Text('Go to login'),
                    ),
                  ],
                ),
              );
            }
            return Text('Error: $error');
          },
        ),
      ),
    );
  }
}

class HomePageSkeleton extends StatelessWidget {
  const HomePageSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
