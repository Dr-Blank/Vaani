import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vaani/api/api_provider.dart';
import 'package:vaani/settings/app_settings_provider.dart';

import '../shared/widgets/shelves/home_shelf.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(appSettingsProvider);
    final api = ref.watch(authenticatedApiProvider);
    final me = ref.watch(meProvider);
    final views = ref.watch(personalizedViewProvider);
    final scrollController = useScrollController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
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
              debugPrint('building shelf ${shelf.label}');
              return HomeShelf(
                title: shelf.label,
                shelf: shelf,
              );
            }).toList();
            return RefreshIndicator(
              onRefresh: () async {
                return ref.refresh(personalizedViewProvider);
              },
              child: ListView.separated(
                itemBuilder: (context, index) => shelvesToDisplay[index],
                separatorBuilder: (context, index) => Divider(
                  color: Theme.of(context).dividerColor.withOpacity(0.1),
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
