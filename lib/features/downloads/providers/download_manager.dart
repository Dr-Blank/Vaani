import 'package:background_downloader/background_downloader.dart';
import 'package:logging/logging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shelfsdk/audiobookshelf_api.dart';
import 'package:vaani/api/api_provider.dart';
import 'package:vaani/features/downloads/core/download_manager.dart' as core;
import 'package:vaani/settings/app_settings_provider.dart';

part 'download_manager.g.dart';

final _logger = Logger('AudiobookDownloadManagerProvider');

@Riverpod(keepAlive: true)
class SimpleDownloadManager extends _$SimpleDownloadManager {
  @override
  core.AudiobookDownloadManager build() {
    final api = ref.watch(authenticatedApiProvider);
    final downloadSettings = ref.watch(appSettingsProvider).downloadSettings;

    final manager = core.AudiobookDownloadManager(
      baseUrl: api.baseUrl.toString(),
      token: api.token!,
      requiresWiFi: downloadSettings.requiresWiFi,
      retries: downloadSettings.retries,
      allowPause: downloadSettings.allowPause,
    );
    core.tq.maxConcurrent = downloadSettings.maxConcurrent;
    core.tq.maxConcurrentByHost = downloadSettings.maxConcurrentByHost;
    core.tq.maxConcurrentByGroup = downloadSettings.maxConcurrentByGroup;

    ref.onDispose(() {
      manager.dispose();
    });

    return manager;
  }
}

@riverpod
class DownloadManager extends _$DownloadManager {
  @override
  core.AudiobookDownloadManager build() {
    final manager = ref.watch(simpleDownloadManagerProvider);
    ref.onDispose(() {
      manager.dispose();
    });

    manager.taskUpdateStream.listen((_) {
      ref.notifyListeners();
    });
    return manager;
  }

  Future<void> queueAudioBookDownload(
    LibraryItemExpanded item, {
    void Function(TaskStatusUpdate)? taskStatusCallback,
    void Function(TaskProgressUpdate)? taskProgressCallback,
  }) async {
    await state.queueAudioBookDownload(
      item,
      taskStatusCallback: (item) {
        try {
          taskStatusCallback?.call(item);
        } catch (e) {
          _logger.severe('Error in taskStatusCallback', e);
        }
        ref.notifyListeners();
      },
      taskProgressCallback: (item) {
        try {
          taskProgressCallback?.call(item);
        } catch (e) {
          _logger.severe('Error in taskProgressCallback', e);
        }
        ref.notifyListeners();
      },
    );
  }

  Future<void> deleteDownloadedItem(LibraryItemExpanded item) async {
    await state.deleteDownloadedItem(item);
    ref.notifyListeners();
  }
}

@riverpod
class IsItemDownloading extends _$IsItemDownloading {
  @override
  bool build(String id) {
    final manager = ref.read(downloadManagerProvider);
    ref.onDispose(() {
      manager.dispose();
    });

    callback(dynamic _) {
      ref.notifyListeners();
    }

    FileDownloader().registerCallbacks(
      group: id,
      taskStatusCallback: callback,
    );

    ref.onDispose(() {
      FileDownloader().unregisterCallbacks(group: id, callback: callback);
    });

    return manager.isItemDownloading(id);
  }
}

@Riverpod(keepAlive: true)
class DownloadProgress extends _$DownloadProgress {
  @override
  double build(String id) {
    var progress = 0.0;

    void progressCallback(TaskProgressUpdate progress) {
      state = progress.progress;
    }

    FileDownloader().registerCallbacks(
      group: id,
      taskProgressCallback: progressCallback,
    );

    ref.onDispose(() {
      FileDownloader()
          .unregisterCallbacks(group: id, callback: progressCallback);
    });

    return progress;
  }
}

@riverpod
FutureOr<List<TaskRecord>> downloadHistory(
  DownloadHistoryRef ref, {
  String? group,
}) async {
  return await FileDownloader().database.allRecords(group: group);
}

// @Riverpod(keepAlive: false)
// FutureOr<bool> downloadStatus(
//   DownloadStatusRef ref,
//   LibraryItemExpanded item,
// ) async {
//   final manager = ref.read(simpleDownloadManagerProvider);
//   return manager.isItemDownloaded(item);
// }

@riverpod
class DownloadStatus extends _$DownloadStatus {
  @override
  FutureOr<bool> build(
    LibraryItemExpanded item,
  ) {
    final manager = ref.watch(downloadManagerProvider);
    return manager.isItemDownloaded(item);
  }

}
