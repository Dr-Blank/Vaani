import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shelfsdk/audiobookshelf_api.dart' show Library;
import 'package:vaani/api/library_provider.dart';
import 'package:vaani/settings/api_settings_provider.dart'
    show apiSettingsProvider;
import 'package:vaani/shared/icons/abs_icons.dart';
import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:vaani/main.dart' show appLogger;

class LibrarySwitchChip extends HookConsumerWidget {
  const LibrarySwitchChip({
    super.key,
    required this.libraries,
  });
  final List<Library> libraries;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final apiSettings = ref.watch(apiSettingsProvider);

    return ActionChip(
      avatar: Icon(
        AbsIcons.getIconByName(
          apiSettings.activeLibraryId != null
              ? libraries
                  .firstWhere(
                    (lib) => lib.id == apiSettings.activeLibraryId,
                  )
                  .icon
              : libraries.first.icon,
        ),
      ), // Replace with your icon
      label: const Text('Change Library'),
      // Enable only if libraries are loaded and not empty
      onPressed: libraries.isNotEmpty
          ? () => showLibrarySwitcher(
                context,
                ref,
              )
          : null, // Disable if no libraries
    );
  }
}

// --- Helper Function to Show the Switcher ---
void showLibrarySwitcher(
  BuildContext context,
  WidgetRef ref,
) {
  final content = _LibrarySelectionContent();

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
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get the current library ID from the settings
    final currentLibraryId = ref.watch(
      apiSettingsProvider.select(
        (settings) => settings.activeLibraryId,
      ),
    );
    // Get the list of libraries from the settings
    final libraries = ref.watch(librariesProvider).valueOrNull ??
        []; // Use null-aware operator to handle null case

    // If no libraries are available, show a message
    if (libraries.isEmpty) {
      return const Center(
        child: Text('No libraries available'),
      );
    }
    return ListView.builder(
      shrinkWrap: true, // Important for Dialog/BottomSheet sizing
      itemCount: libraries.length,
      itemBuilder: (context, index) {
        final library = libraries[index];
        final bool isSelected = library.id == currentLibraryId;

        return ListTile(
          title: Text(library.name),
          leading: Icon(AbsIcons.getIconByName(library.icon)),
          selected: isSelected,
          trailing: isSelected ? const Icon(Icons.check) : null,
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
