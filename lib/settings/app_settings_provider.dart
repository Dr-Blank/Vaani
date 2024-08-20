// this provider is used to provide the app settings to the app

import 'package:logging/logging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:whispering_pages/db/available_boxes.dart';
import 'package:whispering_pages/settings/models/app_settings.dart' as model;

part 'app_settings_provider.g.dart';

final _box = AvailableHiveBoxes.userPrefsBox;

final _logger = Logger('AppSettingsProvider');

model.AppSettings readFromBoxOrCreate() {
  // see if the settings are already in the box
  if (_box.isNotEmpty) {
    final foundSettings = _box.getAt(0);
    _logger.fine('found settings in box: $foundSettings');
    return foundSettings;
  } else {
    // create a new settings object
    const settings = model.AppSettings();
    _logger.fine('created new settings: $settings');
    return settings;
  }
}

@Riverpod(keepAlive: true)
class AppSettings extends _$AppSettings {
  @override
  model.AppSettings build() {
    state = readFromBoxOrCreate();
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
    state = state.copyWith(isDarkMode: !state.isDarkMode);
  }

  void updateState(model.AppSettings newSettings) {
    state = newSettings;
  }

  void reset() {
    state = const model.AppSettings();
  }
}
