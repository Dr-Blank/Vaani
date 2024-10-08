import 'package:package_info_plus/package_info_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vaani/api/api_provider.dart';
import 'package:vaani/features/playback_reporting/core/playback_reporter.dart'
    as core;
import 'package:vaani/features/player/providers/audiobook_player.dart';
import 'package:vaani/settings/app_settings_provider.dart';
import 'package:vaani/settings/metadata/metadata_provider.dart';

part 'playback_reporter_provider.g.dart';

@Riverpod(keepAlive: true)
class PlaybackReporter extends _$PlaybackReporter {
  @override
  Future<core.PlaybackReporter> build() async {
    final playerSettings = ref.watch(appSettingsProvider).playerSettings;
    final player = ref.watch(simpleAudiobookPlayerProvider);
    final packageInfo = await PackageInfo.fromPlatform();
    final api = ref.watch(authenticatedApiProvider);
    final deviceName = await ref.watch(deviceNameProvider.future);
    final deviceModel = await ref.watch(deviceModelProvider.future);
    final deviceSdkVersion = await ref.watch(deviceSdkVersionProvider.future);
    final deviceManufacturer =
        await ref.watch(deviceManufacturerProvider.future);

    final reporter = core.PlaybackReporter(
      player,
      api,
      reportingInterval: playerSettings.playbackReportInterval,
      markCompleteWhenTimeLeft: playerSettings.markCompleteWhenTimeLeft,
      minimumPositionForReporting: playerSettings.minimumPositionForReporting,
      deviceName: deviceName,
      deviceModel: deviceModel,
      deviceSdkVersion: deviceSdkVersion,
      deviceClientName: packageInfo.appName,
      deviceClientVersion: packageInfo.version,
      deviceManufacturer: deviceManufacturer,
    );
    ref.onDispose(reporter.dispose);
    return reporter;
  }
}
