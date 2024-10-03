import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vaani/features/player/providers/audiobook_player.dart';
import 'package:vaani/features/player/providers/currently_playing_provider.dart';
import 'package:vaani/features/player/view/player_when_expanded.dart';
import 'package:vaani/main.dart';
import 'package:vaani/shared/extensions/chapter.dart';
import 'package:vaani/shared/extensions/duration_format.dart';
import 'package:vaani/shared/hooks.dart';

class ChapterSelectionButton extends HookConsumerWidget {
  const ChapterSelectionButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Tooltip(
      message: 'Chapters',
      child: IconButton(
        icon: const Icon(Icons.menu_book_rounded),
        onPressed: () async {
          pendingPlayerModals++;
          await showModalBottomSheet<bool>(
            context: context,
            barrierLabel: 'Select Chapter',
            constraints: BoxConstraints(
              // 40% of the screen height
              maxHeight: MediaQuery.of(context).size.height * 0.4,
            ),
            builder: (context) {
              return const Padding(
                padding: EdgeInsets.all(8.0),
                child: ChapterSelectionModal(),
              );
            },
          );
          pendingPlayerModals--;
        },
      ),
    );
  }
}

class ChapterSelectionModal extends HookConsumerWidget {
  const ChapterSelectionModal({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentChapter = ref.watch(currentPlayingChapterProvider);
    final currentBook = ref.watch(currentlyPlayingBookProvider);
    final notifier = ref.watch(audiobookPlayerProvider);
    final currentChapterIndex = currentChapter?.id;
    final chapterKey = GlobalKey();
    scrollToCurrentChapter() async {
      appLogger.fine('scrolling to chapter');
      await Scrollable.ensureVisible(
        chapterKey.currentContext!,
        duration: 200.ms,
        alignment: 0.5,
        curve: Curves.easeInOut,
      );
    }

    useTimer(scrollToCurrentChapter, 500.ms);
    // useInterval(scrollToCurrentChapter, 500.ms);
    return Column(
      children: [
        ListTile(
          title: Text(
            'Chapters${currentChapterIndex == null ? '' : ' (${currentChapterIndex + 1}/${currentBook?.chapters.length})'}',
          ),
        ),
        // scroll to current chapter after opening the dialog
        Expanded(
          child: Scrollbar(
            child: SingleChildScrollView(
              child: currentBook?.chapters == null
                  ? const Text('No chapters found')
                  : Column(
                      children: [
                        for (final chapter in currentBook!.chapters)
                          ListTile(
                            title: Text(chapter.title),
                            trailing: Text(
                              '(${chapter.duration.smartBinaryFormat})',
                            ),
                            selected: currentChapterIndex == chapter.id,
                            key: currentChapterIndex == chapter.id
                                ? chapterKey
                                : null,
                            onTap: () {
                              Navigator.of(context).pop();
                              notifier.seek(chapter.start + 90.ms);
                              notifier.play();
                            },
                          ),
                      ],
                    ),
            ),
          ),
        ),
      ],
    );
  }
}
