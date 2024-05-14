// this provider is used to provide the Api settings to the app

import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:whispering_pages/db/available_boxes.dart';
import 'package:whispering_pages/settings/models/api_settings.dart' as model;

part 'api_settings_provider.g.dart';

final _box = AvailableHiveBoxes.apiSettingsBox;

@Riverpod(keepAlive: true)
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
      var foundSettings = _box.getAt(0);
      // foundSettings.activeServer ??= foundSettings.activeUser?.server;
      // foundSettings =foundSettings.copyWith(activeServer: foundSettings.activeUser?.server);
      if (foundSettings.activeServer == null) {
        foundSettings = foundSettings.copyWith(
          activeServer: foundSettings.activeUser?.server,
        );
      }
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

  void updateState(model.ApiSettings newSettings, {bool force = false}) {
    // check if the settings are different

    if (state == newSettings && !force) {
      return;
    }
    state = newSettings;
  }
}
