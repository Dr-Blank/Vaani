// download manager to handle download tasks of files

import 'dart:io';

import 'package:background_downloader/background_downloader.dart';
import 'package:logging/logging.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shelfsdk/audiobookshelf_api.dart';
import 'package:vaani/shared/extensions/model_conversions.dart';

final _logger = Logger('AudiobookDownloadManager');
final tq = MemoryTaskQueue();
const downloadDirectory = BaseDirectory.applicationSupport;

class AudiobookDownloadManager {
  // takes in the baseUrl and the token
  AudiobookDownloadManager({
    required this.baseUrl,
    required this.token,
    this.requiresWiFi = true,
    this.retries = 0,
    this.allowPause = false,

    // /// The maximum number of concurrent tasks to run at any given time.
    // int maxConcurrent = 3,

    // /// The maximum number of concurrent tasks to run for the same host.
    // int maxConcurrentByHost = 2,

    // /// The maximum number of concurrent tasks to run for the same group.
    // int maxConcurrentByGroup = 3,
  }) {
    // initialize the download manager

    FileDownloader().addTaskQueue(tq);

    _logger.fine('initialized with baseUrl: $baseUrl, token: $token');
    _logger.fine(
      'requiresWiFi: $requiresWiFi, retries: $retries, allowPause: $allowPause',
    );
  }

  // the base url for the audio files
  final String baseUrl;

  // the authentication token to access the [AudioTrack.contentUrl]
  final String token;

  // whether to download only on wifi
  final bool requiresWiFi;

  // the number of retries to attempt
  final int retries;

  // whether to allow pausing of downloads
  final bool allowPause;

  // final List<DownloadTask> _downloadTasks = [];

  Future<void> queueAudioBookDownload(LibraryItemExpanded item) async {
    _logger.info('queuing download for item: ${item.toJson()}');
    // create a download task for each file in the item
    final directory = await getApplicationSupportDirectory();
    for (final file in item.libraryFiles) {
      // check if the file is already downloaded
      if (isFileDownloaded(
        constructFilePath(directory, item, file),
      )) {
        _logger.info('file already downloaded: ${file.metadata.filename}');
        continue;
      }

      final task = DownloadTask(
        taskId: file.ino,
        url: file.url(baseUrl, item.id, token).toString(),
        directory: item.relPath,
        filename: file.metadata.filename,
        requiresWiFi: requiresWiFi,
        retries: retries,
        allowPause: allowPause,
        group: item.id,
        baseDirectory: downloadDirectory,
        // metaData: token
      );
      // _downloadTasks.add(task);
      tq.add(task);
      _logger.info('queued task: ${task.toJson()}');
    }

    FileDownloader().registerCallbacks(
      group: item.id,
      taskProgressCallback: (update) {
        _logger.info('Group: ${item.id}, Progress Update: ${update.progress}');
      },
      taskStatusCallback: (update) {
        switch (update.status) {
          case TaskStatus.complete:
            _logger.info('Group: ${item.id}, Download Complete');
            break;
          case TaskStatus.failed:
            _logger.warning('Group: ${item.id}, Download Failed');
            break;
          default:
            _logger
                .info('Group: ${item.id}, Download Status: ${update.status}');
        }
      },
      taskNotificationTapCallback: (task, notificationType) {
        _logger.info('Group: ${item.id}, Task: ${task.toJson()}');
      },
    );
  }

  String constructFilePath(
    Directory directory,
    LibraryItemExpanded item,
    LibraryFile file,
  ) =>
      '${directory.path}/${item.relPath}/${file.metadata.filename}';

  // void startDownload() {
  //   for (final task in _downloadTasks) {
  //     _logger.fine('enqueuing task: $task');
  //     FileDownloader().enqueue(task);
  //   }
  // }

  void dispose() {
    // tq.removeAll();
    _logger.fine('disposed');
  }

  bool isFileDownloaded(String filePath) {
    // Check if the file exists
    final fileExists = File(filePath).existsSync();

    return fileExists;
  }

  Future<bool> isItemDownloaded(LibraryItemExpanded item) async {
    final directory = await getApplicationSupportDirectory();
    for (final file in item.libraryFiles) {
      if (!isFileDownloaded(constructFilePath(directory, item, file))) {
        _logger.info('file not downloaded: ${file.metadata.filename}');
        return false;
      }
    }

    return true;
  }

  Future<void> deleteDownloadedItem(LibraryItemExpanded item) async {
    final directory = await getApplicationSupportDirectory();
    for (final file in item.libraryFiles) {
      final filePath = constructFilePath(directory, item, file);
      if (isFileDownloaded(filePath)) {
        File(filePath).deleteSync();
      }
      _logger.info('deleted file: $filePath');
    }
  }

  Future<List<Uri>> getDownloadedFiles(LibraryItemExpanded item) async {
    final directory = await getApplicationSupportDirectory();
    final files = <Uri>[];
    for (final file in item.libraryFiles) {
      final filePath = constructFilePath(directory, item, file);
      if (isFileDownloaded(filePath)) {
        files.add(Uri.file(filePath));
      }
    }

    return files;
  }
}

Future<void> initDownloadManager() async {
  // initialize the download manager
  var fileDownloader = FileDownloader();
  fileDownloader.configureNotification(
    running: const TaskNotification('Downloading', 'file: {filename}'),
    progressBar: true,
  );
  await fileDownloader.trackTasks();
}
