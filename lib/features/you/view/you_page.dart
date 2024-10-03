import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vaani/api/api_provider.dart';
import 'package:vaani/router/router.dart';
import 'package:vaani/settings/constants.dart';
import 'package:vaani/shared/utils.dart';
import 'package:vaani/shared/widgets/not_implemented.dart';

class YouPage extends HookConsumerWidget {
  const YouPage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final api = ref.watch(authenticatedApiProvider);
    return Scaffold(
      appBar: AppBar(
        // title: const Text('You'),
        backgroundColor: Colors.transparent,
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
                      // ActionChip(
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
                      child: const VaaniLogo(),
                    ),
                  ),
                ],
              ),
            ),
          ),
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
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Text(
              userData.username,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        );
      },
      loading: () => const CircularProgressIndicator(),
      error: (error, stack) => Text('Error: $error'),
    );
  }
}

class VaaniLogo extends StatelessWidget {
  const VaaniLogo({
    super.key,
    this.size,
    this.duration = const Duration(milliseconds: 750),
    this.curve = Curves.fastOutSlowIn,
  });

  final double? size;
  final Duration duration;
  final Curve curve;

  @override
  Widget build(BuildContext context) {
    final IconThemeData iconTheme = IconTheme.of(context);
    final double? iconSize = size ?? iconTheme.size;
    return AnimatedContainer(
      width: iconSize,
      height: iconSize,
      duration: duration,
      curve: curve,
      child: Image.asset('assets/images/vaani_logo_foreground.png'),
    );
  }
}
