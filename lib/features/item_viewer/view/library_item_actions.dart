import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shelfsdk/audiobookshelf_api.dart' as shelfsdk;
import 'package:whispering_pages/features/item_viewer/view/library_item_page.dart';
import 'package:whispering_pages/features/player/providers/audiobook_player.dart';
import 'package:whispering_pages/settings/app_settings_provider.dart';
import 'package:whispering_pages/shared/extensions/model_conversions.dart';

class LibraryItemActions extends HookConsumerWidget {
  LibraryItemActions({
    super.key,
    required this.item,
  }) {
    book = item.media.asBookExpanded;
  }

  final shelfsdk.LibraryItemExpanded item;
  late final shelfsdk.BookExpanded book;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final player = ref.read(audiobookPlayerProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // play/resume button the same width as image
          LayoutBuilder(
            builder: (context, constraints) {
              return SizedBox(
                width: calculateWidth(context, constraints),
                // a boxy button with icon and text but little rounded corner
                child: _LibraryItemPlayButton(item: item),
              );
            },
          ),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SizedBox(
                  width: constraints.maxWidth * 0.6,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // read list button
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.playlist_add_rounded,
                        ),
                      ),
                      // share button
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.share_rounded),
                      ),
                      // download button
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.download_rounded,
                        ),
                      ),
                      // more button
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.more_vert_rounded,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _LibraryItemPlayButton extends HookConsumerWidget {
  const _LibraryItemPlayButton({
    super.key,
    required this.item,
  });

  final shelfsdk.LibraryItemExpanded item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final book = item.media.asBookExpanded;
    final player = ref.watch(audiobookPlayerProvider);
    final isCurrentBookSetInPlayer = player.book == book;
    final isPlayingThisBook = player.playing && isCurrentBookSetInPlayer;

    final userMediaProgress = item.userMediaProgress;
    final isBookCompleted = userMediaProgress?.isFinished ?? false;

    String getPlayDisplayText() {
      // if book is not set to player
      if (!isCurrentBookSetInPlayer) {
        // either play or resume or listen again based on the progress
        if (isBookCompleted) {
          return 'Listen Again';
        }
        // if some progress is made, then 'continue listening'
        if (userMediaProgress?.progress != null) {
          return 'Continue Listening';
        }
        return 'Start Listening';
      } else {
        // if book is set to player
        if (isPlayingThisBook) {
          return 'Pause';
        }
        return 'Resume';
      }
    }

    return ElevatedButton.icon(
      onPressed: () async {
        debugPrint('Pressed play/resume button');
        // set the book to the player if not already set
        if (!isCurrentBookSetInPlayer) {
          debugPrint('Setting the book ${book.libraryItemId}');
          debugPrint('Initial position: ${userMediaProgress?.currentTime}');
          await player.setSourceAudioBook(
            book,
            initialPosition: userMediaProgress?.currentTime,
          );
        } else {
          debugPrint('Book was already set');
          if (isPlayingThisBook) {
            debugPrint('Pausing the book');
            await player.pause();
            return;
          }
        }
        // toggle play/pause
        await player.play();
        // set the volume as this is the first time playing and dismissing causes the volume to go to 0
        await player.setVolume(
          ref.read(appSettingsProvider).playerSettings.preferredDefaultVolume,
        );
      },
      icon: Icon(
        isCurrentBookSetInPlayer
            ? isPlayingThisBook
                ? Icons.pause_rounded
                : Icons.play_arrow_rounded
            : isBookCompleted
                ? Icons.replay_rounded
                : Icons.play_arrow_rounded,
      ),
      label: Text(getPlayDisplayText()),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }
}
