import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shelfsdk/audiobookshelf_api.dart' show Library;
import 'package:vaani/api/api_provider.dart';
import 'package:vaani/api/library_provider.dart' show librariesProvider;
import 'package:vaani/features/player/view/mini_player_bottom_padding.dart';
import 'package:vaani/main.dart' show appLogger;
import 'package:vaani/router/router.dart';
import 'package:vaani/settings/api_settings_provider.dart'
    show apiSettingsProvider;
import 'package:vaani/settings/constants.dart';
import 'package:vaani/shared/icons/abs_icons.dart';
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
    // Get current settings to know the active library ID later
    final apiSettings = ref.watch(apiSettingsProvider);
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
                      librariesAsyncValue.when(
                        data: (libraries) => ActionChip(
                          avatar: Icon(
                            AbsIcons.getIconByName(
                              apiSettings.activeLibraryId != null
                                  ? libraries
                                      .firstWhere(
                                        (lib) =>
                                            lib.id ==
                                            apiSettings.activeLibraryId,
                                      )
                                      .icon
                                  : libraries.first.icon,
                            ),
                          ), // Replace with your icon
                          label: const Text('Change Library'),
                          // Enable only if libraries are loaded and not empty
                          onPressed: libraries.isNotEmpty
                              ? () => _showLibrarySwitcher(
                                    context,
                                    ref,
                                    libraries,
                                    apiSettings.activeLibraryId,
                                  )
                              : null, // Disable if no libraries
                        ),
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

// --- Helper Function to Show the Switcher ---
void _showLibrarySwitcher(
  BuildContext context,
  WidgetRef ref,
  List<Library> libraries, // Pass loaded libraries
  String? currentLibraryId, // Pass current ID
) {
  final content = _LibrarySelectionContent(
    libraries: libraries,
    currentLibraryId: currentLibraryId,
  );

  // --- Platform-Specific UI ---
  bool isDesktop = false;
  if (!kIsWeb) {
    // dart:io Platform is not available on web
    isDesktop = Platform.isLinux || Platform.isMacOS || Platform.isWindows;
  } else {
    // Basic web detection (might need refinement based on screen size)
    // Consider using MediaQuery for a size-based check instead for web/tablet
    final size = MediaQuery.of(context).size;
    isDesktop = size.width > 600; // Example threshold for "desktop-like" layout
  }

  if (isDesktop) {
    // --- Desktop: Use AlertDialog ---
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Select Library'),
        content: SizedBox(
          // Constrain size for dialogs
          width: 300, // Adjust as needed
          // Make content scrollable if list is long
          child: Scrollbar(child: content),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  } else {
    // --- Mobile/Tablet: Use BottomSheet ---
    showModalBottomSheet(
      context: context,
      // Make it scrollable and control height
      isScrollControlled: true,
      constraints: BoxConstraints(
        maxHeight:
            MediaQuery.of(context).size.height * 0.6, // Max 60% of screen
      ),
      builder: (sheetContext) => Padding(
        // Add padding within the bottom sheet
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min, // Take minimum necessary height
          children: [
            const Text(
              'Select Library',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Divider(),
            Flexible(
              // Allow the list to take remaining space and scroll
              child: Scrollbar(child: content),
            ),
          ],
        ),
      ),
    );
  }
}

// --- Widget for the Selection List Content (Reusable) ---
class _LibrarySelectionContent extends ConsumerWidget {
  final List<Library> libraries;
  final String? currentLibraryId;

  const _LibrarySelectionContent({
    required this.libraries,
    this.currentLibraryId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      shrinkWrap: true, // Important for Dialog/BottomSheet sizing
      itemCount: libraries.length,
      itemBuilder: (context, index) {
        final library = libraries[index];
        final bool isSelected = library.id == currentLibraryId;

        return ListTile(
          title: Text(library.name),
          leading: Icon(AbsIcons.getIconByName(library.icon)),
          selected: isSelected, // Makes the tile visually selected
          onTap: () {
            appLogger
                .info('Selected library: ${library.name} (ID: ${library.id})');
            // Get current settings state
            final currentSettings = ref.read(apiSettingsProvider);
            // Update the active library ID
            ref.read(apiSettingsProvider.notifier).updateState(
                  currentSettings.copyWith(activeLibraryId: library.id),
                );
            // Close the dialog/bottom sheet
            Navigator.pop(context);
          },
        );
      },
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
