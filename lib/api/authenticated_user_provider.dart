import 'package:logging/logging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:whispering_pages/api/server_provider.dart'
    show audiobookShelfServerProvider;
import 'package:whispering_pages/db/storage.dart';
import 'package:whispering_pages/settings/api_settings_provider.dart';
import 'package:whispering_pages/settings/models/audiobookshelf_server.dart';
import 'package:whispering_pages/settings/models/authenticated_user.dart'
    as model;

part 'authenticated_user_provider.g.dart';

final _box = AvailableHiveBoxes.authenticatedUserBox;

final _logger = Logger('authenticated_user_provider');

/// provides with a set of authenticated users
@riverpod
class AuthenticatedUser extends _$AuthenticatedUser {
  @override
  Set<model.AuthenticatedUser> build() {
    ref.listenSelf((_, __) {
      writeStateToBox();
    });
    // get the app settings
    final apiSettings = ref.read(apiSettingsProvider);

    final availUsers = readFromBoxOrCreate();
    if (apiSettings.activeUser != null) {
      availUsers.add(apiSettings.activeUser!);
    }
    return availUsers;
  }

  Set<model.AuthenticatedUser> readFromBoxOrCreate() {
    if (_box.isNotEmpty) {
      final foundData = _box.getRange(0, _box.length);
      _logger.fine('found users in box: $foundData');
      return foundData.toSet();
    } else {
      _logger.fine('no settings found in box');
      return {};
    }
  }

  void writeStateToBox() {
    _box.clear();
    if (state.isEmpty) {
      return;
    }
    _box.addAll(state);
    _logger.fine('writing state to box: $state');
  }

  void addUser(model.AuthenticatedUser user) {
    state = state..add(user);
  }

  void removeUsersOfServer(AudiobookShelfServer registeredServer) {
    state = state.where((user) => user.server != registeredServer).toSet();
    // remove the server from the server provider
    final serverProvider = ref.read(audiobookShelfServerProvider);
    if (serverProvider.contains(registeredServer)) {
      ref
          .read(audiobookShelfServerProvider.notifier)
          .removeServer(registeredServer);
    }
  }

  void removeUser(model.AuthenticatedUser user) {
    state = state.where((u) => u != user).toSet();
    // also remove the user from the active user
    final apiSettings = ref.read(apiSettingsProvider);
    if (apiSettings.activeUser == user) {
      ref.read(apiSettingsProvider.notifier).updateState(
            apiSettings.copyWith(
              activeUser: null,
            ),
          );
    }
  }
}
