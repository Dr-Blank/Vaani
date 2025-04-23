import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vaani/features/player/providers/audiobook_player.dart'
    show audiobookPlayerProvider;
import 'package:vaani/features/player/providers/currently_playing_provider.dart'
    show currentPlayingChapterProvider, currentlyPlayingBookProvider;
import 'package:vaani/features/player/view/player_when_expanded.dart'
    show pendingPlayerModals;
import 'package:vaani/features/player/view/widgets/playing_indicator_icon.dart';
import 'package:vaani/main.dart' show appLogger;
import 'package:vaani/shared/extensions/chapter.dart' show ChapterDuration;
import 'package:vaani/shared/extensions/duration_format.dart'
    show DurationFormat;
import 'package:vaani/shared/hooks.dart' show useTimer;

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
    final theme = Theme.of(context);
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
                      children: currentBook!.chapters.map(
                        (chapter) {
                          final isCurrent = currentChapterIndex == chapter.id;
                          final isPlayed = currentChapterIndex != null &&
                              chapter.id < currentChapterIndex;
                          return ListTile(
                            autofocus: isCurrent,
                            iconColor: isPlayed && !isCurrent
                                ? theme.disabledColor
                                : null,
                            title: Text(
                              chapter.title,
                              style: isPlayed && !isCurrent
                                  ? TextStyle(color: theme.disabledColor)
                                  : null,
                            ),
                            subtitle: Text(
                              '(${chapter.duration.smartBinaryFormat})',
                              style: isPlayed && !isCurrent
                                  ? TextStyle(color: theme.disabledColor)
                                  : null,
                            ),
                            trailing: isCurrent
                                ? const PlayingIndicatorIcon()
                                : const Icon(Icons.play_arrow),
                            selected: isCurrent,
                            key: isCurrent ? chapterKey : null,
                            onTap: () {
                              Navigator.of(context).pop();
                              notifier.seek(chapter.start + 90.ms);
                              notifier.play();
                            },
                          );
                        },
                      ).toList(),
                    ),
            ),
          ),
        ),
      ],
    );
  }
}
