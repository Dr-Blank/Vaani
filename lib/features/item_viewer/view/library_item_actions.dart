import 'package:background_downloader/background_downloader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shelfsdk/audiobookshelf_api.dart' as shelfsdk;
import 'package:vaani/api/library_item_provider.dart';
import 'package:vaani/constants/hero_tag_conventions.dart';
import 'package:vaani/features/downloads/providers/download_manager.dart'
    show
        downloadHistoryProvider,
        downloadManagerProvider,
        downloadProgressProvider,
        downloadStatusProvider,
        isItemDownloadingProvider,
        simpleDownloadManagerProvider;
import 'package:vaani/features/item_viewer/view/library_item_page.dart';
import 'package:vaani/features/per_book_settings/providers/book_settings_provider.dart';
import 'package:vaani/features/player/providers/audiobook_player.dart';
import 'package:vaani/features/player/providers/player_form.dart';
import 'package:vaani/main.dart';
import 'package:vaani/router/router.dart';
import 'package:vaani/settings/api_settings_provider.dart';
import 'package:vaani/settings/app_settings_provider.dart';
import 'package:vaani/shared/extensions/model_conversions.dart';
import 'package:vaani/shared/utils.dart';

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
    final downloadHistory = ref.watch(downloadHistoryProvider(group: item.id));
    final apiSettings = ref.watch(apiSettingsProvider);

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
                        onPressed: () {
                          appLogger.fine('Sharing');
                          var currentServerUrl =
                              apiSettings.activeServer!.serverUrl;
                          if (!currentServerUrl.hasScheme) {
                            currentServerUrl =
                                Uri.https(currentServerUrl.toString());
                          }
                          handleLaunchUrl(
                            Uri.parse(
                              currentServerUrl.toString() +
                                  (Routes.libraryItem.pathParamName != null
                                      ? Routes.libraryItem.fullPath.replaceAll(
                                          ':${Routes.libraryItem.pathParamName!}',
                                          item.id,
                                        )
                                      : Routes.libraryItem.fullPath),
                            ),
                          );
                        },
                        icon: const Icon(Icons.share_rounded),
                      ),
                      // download button
                      LibItemDownloadButton(item: item),

                      // more button
                      IconButton(
                        onPressed: () {
                          // show the bottom sheet with download history
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return downloadHistory.when(
                                data: (downloadHistory) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ListView.builder(
                                      itemCount: downloadHistory.length,
                                      itemBuilder: (context, index) {
                                        final record = downloadHistory[index];
                                        return ListTile(
                                          title: Text(record.task.filename),
                                          subtitle: Text(
                                            '${record.task.directory}/${record.task.baseDirectory}',
                                          ),
                                          trailing: const Icon(
                                            Icons.open_in_new_rounded,
                                          ),
                                          onLongPress: () {
                                            // show the delete dialog
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  title: const Text('Delete'),
                                                  content: Text(
                                                    'Are you sure you want to delete ${record.task.filename}?',
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () {
                                                        // delete the file
                                                        FileDownloader()
                                                            .database
                                                            .deleteRecordWithId(
                                                              record
                                                                  .task.taskId,
                                                            );
                                                        Navigator.pop(context);
                                                      },
                                                      child: const Text('Yes'),
                                                    ),
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: const Text('No'),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                          onTap: () async {
                                            // open the file location
                                            final didOpen =
                                                await FileDownloader().openFile(
                                              task: record.task,
                                            );

                                            if (!didOpen) {
                                              appLogger.warning(
                                                'Failed to open file: ${record.task.filename} at ${record.task.directory}',
                                              );
                                              return;
                                            }
                                            appLogger.fine(
                                              'Opened file: ${record.task.filename} at ${record.task.directory}',
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  );
                                },
                                loading: () => const Center(
                                  child: CircularProgressIndicator(),
                                ),
                                error: (error, stackTrace) => Center(
                                  child: Text('Error: $error'),
                                ),
                              );
                            },
                          );
                        },
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

class LibItemDownloadButton extends HookConsumerWidget {
  const LibItemDownloadButton({
    super.key,
    required this.item,
  });

  final shelfsdk.LibraryItemExpanded item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isItemDownloaded = ref.watch(downloadStatusProvider(item));
    final isItemDownloading = ref.watch(isItemDownloadingProvider(item.id));

    return isItemDownloaded.valueOrNull ?? false
        ? AlreadyItemDownloadedButton(item: item)
        : isItemDownloading
            ? ItemCurrentlyInDownloadQueue(
                item: item,
              )
            : IconButton(
                onPressed: () {
                  appLogger.fine('Pressed download button');

                  ref
                      .read(downloadManagerProvider.notifier)
                      .queueAudioBookDownload(item);
                },
                icon: const Icon(
                  Icons.download_rounded,
                ),
              );
  }
}

class ItemCurrentlyInDownloadQueue extends HookConsumerWidget {
  const ItemCurrentlyInDownloadQueue({
    super.key,
    required this.item,
  });

  final shelfsdk.LibraryItemExpanded item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progress = ref.watch(downloadProgressProvider(item.id));
    final updatesStream = useStream(ref.watch(downloadManagerProvider).taskUpdateStream);

    return Stack(
      alignment: Alignment.center,
      children: [
        CircularProgressIndicator(
          value: progress,
          strokeWidth: 2,
        ),
        const Icon(
          Icons.download,
        )
            .animate(
              onPlay: (controller) => controller.repeat(),
            )
            .fade(
              begin: 0.5,
              end: 1,
              duration: 1.seconds,
            )
            .fade(
              begin: 1,
              end: 0.5,
              duration: 1.seconds,
            ),
      ],
    );
  }
}

class AlreadyItemDownloadedButton extends HookConsumerWidget {
  const AlreadyItemDownloadedButton({
    super.key,
    required this.item,
  });

  final shelfsdk.LibraryItemExpanded item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isBookPlaying = ref.watch(audiobookPlayerProvider).book != null;

    return IconButton(
      onPressed: () {
        appLogger.fine('Pressed already downloaded button');
        // manager.openDownloadedFile(item);
        // open popup menu to open or delete the file
        showModalBottomSheet(
          useRootNavigator: false,
          context: context,
          builder: (context) {
            return Padding(
              padding: EdgeInsets.only(
                top: 8.0,
                bottom: (isBookPlaying ? playerMinHeight : 0) + 8,
              ),
              child: DownloadSheet(
                item: item,
              ),
            );
          },
        );
      },
      icon: const Icon(
        Icons.download_done_rounded,
      ),
    );
  }
}

class DownloadSheet extends HookConsumerWidget {
  const DownloadSheet({
    super.key,
    required this.item,
  });

  final shelfsdk.LibraryItemExpanded item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final manager = ref.watch(downloadManagerProvider);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // ListTile(
        //   title: const Text('Open'),
        //   onTap: () async {
        //     final didOpen =
        //         await FileDownloader().openFile(
        //       task: manager.getTaskForItem(item),
        //     );

        //     if (!didOpen) {
        //       appLogger.warning(
        //         'Failed to open file: ${item.title}',
        //       );
        //       return;
        //     }
        //     appLogger.fine(
        //       'Opened file: ${item.title}',
        //     );
        //   },
        // ),
        ListTile(
          title: const Text('Delete'),
          leading: const Icon(
            Icons.delete_rounded,
          ),
          onTap: () async {
            // show the delete dialog
            final wasDeleted = await showDialog<bool>(
              useRootNavigator: false,
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Delete'),
                  content: Text(
                    'Are you sure you want to delete ${item.media.metadata.title}?',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        // delete the file
                        ref
                            .read(downloadManagerProvider.notifier)
                            .deleteDownloadedItem(
                              item,
                            );
                        GoRouter.of(context).pop(true);
                      },
                      child: const Text('Yes'),
                    ),
                    TextButton(
                      onPressed: () {
                        GoRouter.of(context).pop(false);
                      },
                      child: const Text('No'),
                    ),
                  ],
                );
              },
            );

            if (wasDeleted ?? false) {
              appLogger.fine('Deleted ${item.media.metadata.title}');
              GoRouter.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Deleted ${item.media.metadata.title}',
                  ),
                ),
              );
            }
          },
        ),
      ],
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
      onPressed: () => libraryItemPlayButtonOnPressed(
        ref: ref,
        book: book,
        userMediaProgress: userMediaProgress,
      ),
      icon: Hero(
        tag: HeroTagPrefixes.libraryItemPlayButton + book.libraryItemId,
        child: DynamicItemPlayIcon(
          isCurrentBookSetInPlayer: isCurrentBookSetInPlayer,
          isPlayingThisBook: isPlayingThisBook,
          isBookCompleted: isBookCompleted,
        ),
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

class DynamicItemPlayIcon extends StatelessWidget {
  const DynamicItemPlayIcon({
    super.key,
    required this.isCurrentBookSetInPlayer,
    required this.isPlayingThisBook,
    required this.isBookCompleted,
  });

  final bool isCurrentBookSetInPlayer;
  final bool isPlayingThisBook;
  final bool isBookCompleted;

  @override
  Widget build(BuildContext context) {
    return Icon(
      isCurrentBookSetInPlayer
          ? isPlayingThisBook
              ? Icons.pause_rounded
              : Icons.play_arrow_rounded
          : isBookCompleted
              ? Icons.replay_rounded
              : Icons.play_arrow_rounded,
    );
  }
}

/// Handles the play button pressed on the library item
Future<void> libraryItemPlayButtonOnPressed({
  required WidgetRef ref,
  required shelfsdk.BookExpanded book,
  shelfsdk.MediaProgress? userMediaProgress,
}) async {
  debugPrint('Pressed play/resume button');
  final player = ref.watch(audiobookPlayerProvider);

  final isCurrentBookSetInPlayer = player.book == book;
  final isPlayingThisBook = player.playing && isCurrentBookSetInPlayer;

  Future<void>? setSourceFuture;
  // set the book to the player if not already set
  if (!isCurrentBookSetInPlayer) {
    debugPrint('Setting the book ${book.libraryItemId}');
    debugPrint('Initial position: ${userMediaProgress?.currentTime}');
    final downloadManager = ref.watch(simpleDownloadManagerProvider);
    final libItem =
        await ref.read(libraryItemProvider(book.libraryItemId).future);
    final downloadedUris = await downloadManager.getDownloadedFiles(libItem);
    setSourceFuture = player.setSourceAudiobook(
      book,
      initialPosition: userMediaProgress?.currentTime,
      downloadedUris: downloadedUris,
    );
  } else {
    debugPrint('Book was already set');
    if (isPlayingThisBook) {
      debugPrint('Pausing the book');
      await player.pause();
      return;
    }
  }
  // set the volume as this is the first time playing and dismissing causes the volume to go to 0
  var bookPlayerSettings =
      ref.read(bookSettingsProvider(book.libraryItemId)).playerSettings;
  var appPlayerSettings = ref.read(appSettingsProvider).playerSettings;

  var configurePlayerForEveryBook =
      appPlayerSettings.configurePlayerForEveryBook;

  await Future.wait([
    setSourceFuture ?? Future.value(),
    // set the volume
    player.setVolume(
      configurePlayerForEveryBook
          ? bookPlayerSettings.preferredDefaultVolume ??
              appPlayerSettings.preferredDefaultVolume
          : appPlayerSettings.preferredDefaultVolume,
    ),
    // set the speed
    player.setSpeed(
      configurePlayerForEveryBook
          ? bookPlayerSettings.preferredDefaultSpeed ??
              appPlayerSettings.preferredDefaultSpeed
          : appPlayerSettings.preferredDefaultSpeed,
    ),
  ]);

  // toggle play/pause
  await player.play();
}
