import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:whispering_pages/api/authenticated_user_provider.dart';
import 'package:whispering_pages/settings/models/audiobookshelf_server.dart' as model;
import 'package:whispering_pages/settings/api_settings_provider.dart';
import 'package:whispering_pages/db/storage.dart';

part 'server_provider.g.dart';

final _box = AvailableHiveBoxes.serverBox;

class ServerAlreadyExistsException implements Exception {
  final model.AudiobookShelfServer server;

  ServerAlreadyExistsException(this.server);

  @override
  String toString() {
    return 'Server $server already exists';
  }
}

/// provides with a set of servers added by the user
@riverpod
class AudiobookShelfServer extends _$AudiobookShelfServer {
  @override
  Set<model.AudiobookShelfServer> build() {
    ref.listenSelf((_, __) {
      writeStateToBox();
    });
    // get the app settings
    final apiSettings = ref.read(apiSettingsProvider);
    // is default server is present, add it to the set
    final availableServers = readFromBoxOrCreate();
    if (apiSettings.activeServer != null) {
      availableServers.add(apiSettings.activeServer!);
    }
    // also add server of the user
    if (apiSettings.activeUser != null) {
      availableServers.add(apiSettings.activeUser!.server);
    }
    return availableServers;
  }

  Set<model.AudiobookShelfServer> readFromBoxOrCreate() {
    if (_box.isNotEmpty) {
      final foundServers = _box.getRange(0, _box.length);
      debugPrint('found servers in box: $foundServers');
      return foundServers.whereNotNull().toSet();
    } else {
      debugPrint('no settings found in box');
      return {};
    }
  }

  void writeStateToBox() {
    _box.clear();
    if (state.isEmpty) {
      return;
    }
    _box.addAll(state);
    debugPrint('writing state to box: $state');
  }

  void addServer(model.AudiobookShelfServer server) {
    if (state.contains(server)) {
      throw ServerAlreadyExistsException(server);
    }
    state = {...state, server};
  }

  void removeServer(model.AudiobookShelfServer server,
      {
    bool removeUsers = false,
  }) {
    state = state.where((s) => s != server).toSet();
    // remove the server from the active server
    final apiSettings = ref.read(apiSettingsProvider);
    if (apiSettings.activeServer == server) {
      ref.read(apiSettingsProvider.notifier).updateState(
            apiSettings.copyWith(
              activeServer: null,
            ),
          );
    }
    // remove the users of this server
    if (removeUsers) {
      ref.read(authenticatedUserProvider.notifier).removeUsersOfServer(server);
    }
  }

  // ? this doesn't seem to be useful
  void updateServer(model.AudiobookShelfServer newServer) {
    state = state
        .map(
          (existingServer) =>
              existingServer == newServer ? newServer : existingServer,
        )
        .toSet();
  }
}
