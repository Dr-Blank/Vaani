// this provider is used to provide the Api settings to the app

import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:whispering_pages/settings/models/api_settings.dart' as model;
import 'package:whispering_pages/db/available_boxes.dart';

part 'api_settings_provider.g.dart';

final _box = AvailableHiveBoxes.apiSettingsBox;

@riverpod
class ApiSettings extends _$ApiSettings {
  @override
  model.ApiSettings build() {
    state = readFromBoxOrCreate();
    ref.listenSelf((_, __) {
      writeToBox();
    });
    return state;
  }

  model.ApiSettings readFromBoxOrCreate() {
    // see if the settings are already in the box
    if (_box.isNotEmpty) {
      final foundSettings = _box.getAt(0);
      debugPrint('found api settings in box: $foundSettings');
      return foundSettings;
    } else {
      // create a new settings object
      const settings = model.ApiSettings();
      debugPrint('created new api settings: $settings');
      return settings;
    }
  }

  // write the settings to the box
  void writeToBox() {
    _box.clear();
    _box.add(state);
    debugPrint('wrote api settings to box: $state');
  }

  void updateState(model.ApiSettings newSettings) {
    state = newSettings;
  }
}
