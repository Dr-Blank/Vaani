// download manager to handle download tasks of files

import 'dart:async';
import 'dart:io';

import 'package:background_downloader/background_downloader.dart';
import 'package:logging/logging.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shelfsdk/audiobookshelf_api.dart';
import 'package:vaani/shared/extensions/model_conversions.dart';
import 'package:vaani/shared/extensions/obfuscation.dart';

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

    _logger.fine(
      'initialized with baseUrl: ${Uri.parse(baseUrl).obfuscate()} and token: ${token.obfuscate()}',
    );
    _logger.fine(
      'requiresWiFi: $requiresWiFi, retries: $retries, allowPause: $allowPause',
    );
    initDownloadManager();
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

  final StreamController<TaskUpdate> _taskStatusController =
      StreamController.broadcast();

  Stream<TaskUpdate> get taskUpdateStream => _taskStatusController.stream;

  late StreamSubscription<TaskUpdate> _updatesSubscription;

  Future<void> queueAudioBookDownload(
    LibraryItemExpanded item,
  ) async {
    _logger.info('queuing download for item: ${item.id}');
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
        updates: Updates.statusAndProgress,
        // metaData: token
      );
      // _downloadTasks.add(task);
      tq.add(task);
      _logger.info('queued task: ${task.taskId}');
    }
  }

  String constructFilePath(
    Directory directory,
    LibraryItemExpanded item,
    LibraryFile file,
  ) =>
      '${directory.path}/${item.relPath}/${file.metadata.filename}';

  void dispose() {
    _updatesSubscription.cancel();
    FileDownloader().destroy();
    _logger.fine('Destroyed download manager');
  }

  bool isItemDownloading(String id) {
    return tq.enqueued.any((task) => task.group == id);
  }

  bool isFileDownloaded(String filePath) {
    return File(filePath).existsSync();
  }

  Future<List<LibraryFile>> getDownloadedFilesMetadata(
    LibraryItemExpanded item,
  ) async {
    final directory = await getApplicationSupportDirectory();
    final downloadedFiles = <LibraryFile>[];
    for (final file in item.libraryFiles) {
      final filePath = constructFilePath(directory, item, file);
      if (isFileDownloaded(filePath)) {
        downloadedFiles.add(file);
      }
    }

    return downloadedFiles;
  }

  Future<int> getDownloadedSize(LibraryItemExpanded item) async {
    final files = await getDownloadedFilesMetadata(item);
    return files.fold<int>(
      0,
      (previousValue, element) => previousValue + element.metadata.size,
    );
  }

  Future<bool> isItemDownloaded(LibraryItemExpanded item) async {
    final directory = await getApplicationSupportDirectory();
    for (final file in item.libraryFiles) {
      if (!isFileDownloaded(constructFilePath(directory, item, file))) {
        _logger.info('file not downloaded: ${file.metadata.filename}');
        return false;
      }
    }
    _logger.info('all files downloaded for item id: ${item.id}');
    return true;
  }

  Future<void> deleteDownloadedItem(LibraryItemExpanded item) async {
    _logger.info('deleting downloaded item with id: ${item.id}');
    final directory = await getApplicationSupportDirectory();
    for (final file in item.libraryFiles) {
      final filePath = constructFilePath(directory, item, file);
      if (isFileDownloaded(filePath)) {
        File(filePath).deleteSync();
      }
      _logger.info('deleted file: $filePath');
    }
  }

  Future<List<Uri>> getDownloadedFilesUri(LibraryItemExpanded item) async {
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

  Future<void> initDownloadManager() async {
    // initialize the download manager
    _logger.info('Initializing download manager');
    final fileDownloader = FileDownloader();

    _logger.info('Configuring Notification');
    fileDownloader.configureNotification(
      running: const TaskNotification('Downloading', 'file: {filename}'),
      progressBar: true,
    );

    await fileDownloader.trackTasks();

    try {
      _updatesSubscription = fileDownloader.updates.listen((event) {
        _logger.finer('Got event: $event');
        _taskStatusController.add(event);
      });
      _logger.info('Listening to download manager updates');
    } catch (e) {
      _logger.warning('Error when listening to download manager updates: $e');
    }
  }
}
