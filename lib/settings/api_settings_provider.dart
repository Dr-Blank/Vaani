// this provider is used to provide the Api settings to the app

import 'package:logging/logging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vaani/db/available_boxes.dart';
import 'package:vaani/settings/models/api_settings.dart' as model;
import 'package:vaani/shared/extensions/obfuscation.dart';

part 'api_settings_provider.g.dart';

final _box = AvailableHiveBoxes.apiSettingsBox;

final _logger = Logger('ApiSettingsProvider');

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
      _logger.fine('found api settings in box: ${foundSettings.obfuscate()}');
      return foundSettings;
    } else {
      // create a new settings object
      const settings = model.ApiSettings();
      _logger.fine('created new api settings: $settings');
      return settings;
    }
  }

  // write the settings to the box
  void writeToBox() {
    _box.clear();
    _box.add(state);
    _logger.fine('wrote api settings to box: ${state.obfuscate()}');
  }

  void updateState(model.ApiSettings newSettings, {bool force = false}) {
    // check if the settings are different

    if (state == newSettings && !force) {
      return;
    }
    state = newSettings;
  }
}
