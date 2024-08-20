import 'package:background_downloader/background_downloader.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shelfsdk/audiobookshelf_api.dart';
import 'package:whispering_pages/api/api_provider.dart';
import 'package:whispering_pages/features/downloads/core/download_manager.dart'
    as core;
import 'package:whispering_pages/settings/app_settings_provider.dart';

part 'download_manager.g.dart';

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
FutureOr<List<TaskRecord>> downloadHistory(
  DownloadHistoryRef ref, {
  String? group,
}) async {
  return await FileDownloader().database.allRecords(group: group);
}

@Riverpod(keepAlive: false)
FutureOr<bool> downloadStatus(
  DownloadStatusRef ref,
  LibraryItemExpanded item,
) async {
  final manager = ref.read(simpleDownloadManagerProvider);
  return manager.isItemDownloaded(item);
}
