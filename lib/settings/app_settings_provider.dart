// this provider is used to provide the app settings to the app

import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:whispering_pages/settings/models/app_settings.dart' as model;
import 'package:whispering_pages/db/available_boxes.dart';

part 'app_settings_provider.g.dart';

final _box = AvailableHiveBoxes.userPrefsBox;

@riverpod
class AppSettings extends _$AppSettings {
  @override
  model.AppSettings build() {
    state = readFromBoxOrCreate();
    ref.listenSelf((_, __) {
      writeToBox();
    });
    return state;
  }

  model.AppSettings readFromBoxOrCreate() {
    // see if the settings are already in the box
    if (_box.isNotEmpty) {
      final foundSettings = _box.getAt(0);
      debugPrint('found settings in box: $foundSettings');
      return foundSettings;
    } else {
      // create a new settings object
      const settings = model.AppSettings();
      debugPrint('created new settings: $settings');
      return settings;
    }
  }

  // write the settings to the box
  void writeToBox() {
    _box.clear();
    _box.add(state);
    debugPrint('wrote settings to box: $state');
  }

  void toggleDarkMode() {
    state = state.copyWith(isDarkMode: !state.isDarkMode);
  }

  void updateState(model.AppSettings newSettings) {
    state = newSettings;
  }
}
