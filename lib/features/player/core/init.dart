import 'package:audio_service/audio_service.dart';
import 'package:audio_session/audio_session.dart';
import 'package:just_audio_background/just_audio_background.dart'
    show JustAudioBackground, NotificationConfig;
import 'package:just_audio_media_kit/just_audio_media_kit.dart'
    show JustAudioMediaKit;
import 'package:vaani/settings/app_settings_provider.dart';
import 'package:vaani/settings/models/app_settings.dart';

Future<void> configurePlayer() async {
  // for playing audio on windows, linux
  JustAudioMediaKit.ensureInitialized();

  // for configuring how this app will interact with other audio apps
  final session = await AudioSession.instance;
  await session.configure(const AudioSessionConfiguration.speech());

  final appSettings = loadOrCreateAppSettings();

  // for playing audio in the background
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.vaani.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: false,
    androidStopForegroundOnPause: false,
    androidNotificationChannelDescription: 'Audio playback in the background',
    androidNotificationIcon: 'drawable/ic_stat_logo',
    rewindInterval: appSettings.notificationSettings.rewindInterval,
    fastForwardInterval: appSettings.notificationSettings.fastForwardInterval,
    androidShowNotificationBadge: false,
    notificationConfigBuilder: (state) {
      final controls = [
        if (appSettings.notificationSettings.mediaControls
                .contains(NotificationMediaControl.skipToPreviousChapter) &&
            state.hasPrevious)
          MediaControl.skipToPrevious,
        if (appSettings.notificationSettings.mediaControls
            .contains(NotificationMediaControl.rewind))
          MediaControl.rewind,
        if (state.playing) MediaControl.pause else MediaControl.play,
        if (appSettings.notificationSettings.mediaControls
            .contains(NotificationMediaControl.fastForward))
          MediaControl.fastForward,
        if (appSettings.notificationSettings.mediaControls
                .contains(NotificationMediaControl.skipToNextChapter) &&
            state.hasNext)
          MediaControl.skipToNext,
        if (appSettings.notificationSettings.mediaControls
            .contains(NotificationMediaControl.stop))
          MediaControl.stop,
      ];
      return NotificationConfig(
        controls: controls,
        systemActions: const {
          MediaAction.seek,
          MediaAction.seekForward,
          MediaAction.seekBackward,
        },
      );
    },
  );
}
