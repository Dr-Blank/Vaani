// this provider is used to provide the app settings to the app

import 'package:logging/logging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vaani/db/available_boxes.dart';
import 'package:vaani/settings/models/app_settings.dart' as model;

part 'app_settings_provider.g.dart';

final _box = AvailableHiveBoxes.userPrefsBox;

final _logger = Logger('AppSettingsProvider');

model.AppSettings loadOrCreateAppSettings() {
  // see if the settings are already in the box
  model.AppSettings? settings;
  if (_box.isNotEmpty) {
    try {
      settings = _box.getAt(0);
      _logger.fine('found settings in box: $settings');
    } catch (e) {
      _logger.warning('error reading settings from box: $e'
          '\nclearing box');
      _box.clear();
    }
  } else {
    _logger.fine('no settings found in box, creating new settings');
  }
  return settings ?? const model.AppSettings();
}

@Riverpod(keepAlive: true)
class AppSettings extends _$AppSettings {
  @override
  model.AppSettings build() {
    state = loadOrCreateAppSettings();
    ref.listenSelf((_, __) {
      writeToBox();
    });
    return state;
  }

  // write the settings to the box
  void writeToBox() {
    _box.clear();
    _box.add(state);
    _logger.fine('wrote settings to box: $state');
  }

  void toggleDarkMode() {
    state = state.copyWith
        .themeSettings(isDarkMode: !state.themeSettings.isDarkMode);
  }

  void update(model.AppSettings newSettings) {
    state = newSettings;
  }

  void reset() {
    state = const model.AppSettings();
  }
}

// SleepTimerSettings provider but only rebuilds when the sleep timer settings change
@Riverpod(keepAlive: true)
class SleepTimerSettings extends _$SleepTimerSettings {
  @override
  model.SleepTimerSettings build() {
    final settings = ref.read(appSettingsProvider).sleepTimerSettings;
    state = settings;
    ref.listen(appSettingsProvider, (a, b) {
      if (a?.sleepTimerSettings != b.sleepTimerSettings) {
        state = b.sleepTimerSettings;
      }
    });
    return state;
  }
}
