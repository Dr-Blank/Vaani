import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shelfsdk/audiobookshelf_api.dart';
import 'package:whispering_pages/constants/sizes.dart';
import 'package:whispering_pages/features/player/providers/audiobook_player.dart';

class AudiobookPlayerSeekChapterButton extends HookConsumerWidget {
  const AudiobookPlayerSeekChapterButton({
    super.key,
    required this.isForward,
  });

  /// if true, the button seeks forward, else it seeks backwards
  final bool isForward;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final player = ref.watch(audiobookPlayerProvider);

    // add a small offset so the display does not show the previous chapter for a split second
    const offset = Duration(milliseconds: 10);

    /// time into the current chapter to determine if we should go to the previous chapter or the start of the current chapter
    const doNotSeekBackIfLessThan = Duration(seconds: 5);

    /// seek forward to the next chapter
    void seekForward() {
      final index = player.book!.chapters.indexOf(player.currentChapter!);
      if (index < player.book!.chapters.length - 1) {
        player.seek(
          player.book!.chapters[index + 1].start + offset,
        );
      } else {
        player.seek(player.currentChapter!.end);
      }
    }

    /// seek backward to the previous chapter or the start of the current chapter
    void seekBackward() {
      final currentPlayingChapterIndex =
          player.book!.chapters.indexOf(player.currentChapter!);
      final chapterPosition =
          player.positionInBook - player.currentChapter!.start;
      BookChapter chapterToSeekTo;
      // if player position is less than 5 seconds into the chapter, go to the previous chapter
      if (chapterPosition < doNotSeekBackIfLessThan &&
          currentPlayingChapterIndex > 0) {
        chapterToSeekTo = player.book!.chapters[currentPlayingChapterIndex - 1];
      } else {
        chapterToSeekTo = player.currentChapter!;
      }
      player.seek(
        chapterToSeekTo.start + offset,
      );
    }

    return IconButton(
      icon: Icon(
        isForward ? Icons.skip_next : Icons.skip_previous,
        size: AppElementSizes.iconSizeSmall,
      ),
      onPressed: () {
        if (player.book == null) {
          return;
        }
        // if chapter does not exist, go to the start or end of the book
        if (player.currentChapter == null) {
          player.seek(isForward ? player.book!.duration : Duration.zero);
          return;
        }
        if (isForward) {
          seekForward();
        } else {
          seekBackward();
        }
      },
    );
  }
}
