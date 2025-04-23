import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vaani/api/api_provider.dart';
import 'package:vaani/api/library_provider.dart' show librariesProvider;
import 'package:vaani/features/player/view/mini_player_bottom_padding.dart';
import 'package:vaani/features/you/view/widgets/library_switch_chip.dart';
import 'package:vaani/router/router.dart';
import 'package:vaani/settings/constants.dart';
import 'package:vaani/shared/utils.dart';
import 'package:vaani/shared/widgets/not_implemented.dart';
import 'package:vaani/shared/widgets/vaani_logo.dart';

class YouPage extends HookConsumerWidget {
  const YouPage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final api = ref.watch(authenticatedApiProvider);
    final librariesAsyncValue = ref.watch(librariesProvider);
    return Scaffold(
      appBar: AppBar(
        // title: const Text('You'),
        actions: [
          IconButton(
            tooltip: 'Logs',
            icon: const Icon(Icons.bug_report),
            onPressed: () {
              context.pushNamed(Routes.logs.name);
            },
          ),
          // IconButton(
          //   icon: const Icon(Icons.edit),
          //   onPressed: () {
          //     // Handle edit profile
          //   },
          // ),
          IconButton(
            tooltip: 'Settings',
            icon: const Icon(Icons.settings),
            onPressed: () {
              context.pushNamed(Routes.settings.name);
            },
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UserBar(),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    children: [
                      ActionChip(
                        avatar: const Icon(Icons.switch_account_outlined),
                        label: const Text('Switch Account'),
                        onPressed: () {
                          context.pushNamed(Routes.userManagement.name);
                        },
                      ),
                      librariesAsyncValue.when(
                        data: (libraries) =>
                            LibrarySwitchChip(libraries: libraries),
                        loading: () => const ActionChip(
                          avatar: SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                          label: Text('Loading Libs...'),
                          onPressed: null, // Disable while loading
                        ),
                        error: (error, stack) => ActionChip(
                          avatar: Icon(
                            Icons.error_outline,
                            color: Theme.of(context).colorScheme.error,
                          ),
                          label: const Text('Error Loading Libs'),
                          onPressed: () {
                            // Maybe show error details or allow retry
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content:
                                    Text('Failed to load libraries: $error'),
                              ),
                            );
                          },
                        ),
                      ), // ActionChip(
                      //   avatar: const Icon(Icons.logout),
                      //   label: const Text('Logout'),
                      //   onPressed: () {
                      //     // Handle logout
                      //   },
                      // ),
                      // ActionChip(
                      //   avatar: const Icon(Icons.privacy_tip),
                      //   label: const Text('Incognito Mode'),
                      //   onPressed: () {
                      //     // Handle incognito mode
                      //   },
                      // ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ListTile(
                    leading: const Icon(Icons.playlist_play),
                    title: const Text('My Playlists'),
                    onTap: () {
                      // Handle navigation to playlists
                      showNotImplementedToast(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.web),
                    title: const Text('Web Version'),
                    onTap: () {
                      handleLaunchUrl(
                        // get url from api and launch it
                        api.baseUrl,
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.help),
                    title: const Text('Help'),
                    onTap: () {
                      // Handle navigation to help website
                      showNotImplementedToast(context);
                    },
                  ),
                  AboutListTile(
                    icon: const Icon(Icons.info),
                    applicationName: AppMetadata.appName,
                    applicationVersion: AppMetadata.version,
                    applicationLegalese:
                        'Made with ❤️ by ${AppMetadata.author}',
                    aboutBoxChildren: [
                      // link to github repo
                      ListTile(
                        leading: Icon(Icons.code),
                        title: Text('Source Code'),
                        onTap: () {
                          handleLaunchUrl(AppMetadata.githubRepo);
                        },
                      ),
                    ],
                    // apply blend mode to the icon to match the primary color
                    applicationIcon: ColorFiltered(
                      colorFilter: ColorFilter.mode(
                        Theme.of(context).colorScheme.primary,
                        BlendMode.srcIn,
                      ),
                      child: const VaaniLogo(
                        size: 48,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(child: MiniPlayerBottomPadding()),
        ],
      ),
    );
  }
}

class UserBar extends HookConsumerWidget {
  const UserBar({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final me = ref.watch(meProvider);
    final api = ref.watch(authenticatedApiProvider);

    final themeData = Theme.of(context);
    final textTheme = themeData.textTheme;

    return me.when(
      data: (userData) {
        return Row(
          children: [
            CircleAvatar(
              radius: 40,
              // backgroundImage: NetworkImage(userData.avatarUrl),
              // first letter of the username
              child: Text(
                userData.username[0].toUpperCase(),
                style: textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userData.username,
                  style: textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  api.baseUrl.toString(),
                  style: textTheme.bodyMedium?.copyWith(
                    color:
                        themeData.colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
          ],
        );
      },
      loading: () => const CircularProgressIndicator(),
      error: (error, stack) => Text('Error: $error'),
    );
  }
}
