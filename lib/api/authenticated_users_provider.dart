import 'package:logging/logging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vaani/api/server_provider.dart'
    show audiobookShelfServerProvider;
import 'package:vaani/db/storage.dart';
import 'package:vaani/settings/api_settings_provider.dart';
import 'package:vaani/settings/models/audiobookshelf_server.dart';
import 'package:vaani/settings/models/authenticated_user.dart' as model;
import 'package:vaani/shared/extensions/obfuscation.dart';

part 'authenticated_users_provider.g.dart';

final _box = AvailableHiveBoxes.authenticatedUserBox;

final _logger = Logger('authenticated_users_provider');

/// provides with a set of authenticated users
@riverpod
class AuthenticatedUsers extends _$AuthenticatedUsers {
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
      _logger.fine(
        'found users in box: ${foundData.obfuscate()}',
      );
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
    _logger.fine('writing state to box: ${state.obfuscate()}');
  }

  void addUser(model.AuthenticatedUser user, {bool setActive = false}) {
    state = state..add(user);
    ref.invalidateSelf();
    if (setActive) {
      final apiSettings = ref.read(apiSettingsProvider);
      ref.read(apiSettingsProvider.notifier).updateState(
            apiSettings.copyWith(
              activeUser: user,
            ),
          );
    }
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
      // replace the active user with the first user in the list
      // or null if there are no users left
      final newActiveUser = state.isNotEmpty ? state.first : null;
      ref.read(apiSettingsProvider.notifier).updateState(
            apiSettings.copyWith(
              activeUser: newActiveUser,
            ),
          );
    }
  }
}
