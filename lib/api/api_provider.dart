// provider to provide the api instance

import 'dart:convert';

import 'package:http/http.dart';
import 'package:logging/logging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shelfsdk/audiobookshelf_api.dart';
import 'package:vaani/db/cache_manager.dart';
import 'package:vaani/models/error_response.dart';
import 'package:vaani/settings/api_settings_provider.dart';
import 'package:vaani/settings/models/authenticated_user.dart';
import 'package:vaani/shared/extensions/obfuscation.dart';

part 'api_provider.g.dart';

// TODO: workaround for https://github.com/rrousselGit/riverpod/issues/3718
typedef ResponseErrorHandler = void Function(
  Response response, [
  Object? error,
]);

final _logger = Logger('api_provider');

Uri makeBaseUrl(String address) {
  if (!address.startsWith('http') && !address.startsWith('https')) {
    address = 'https://$address';
  }
  if (!Uri.parse(address).isAbsolute) {
    throw ArgumentError.value(address, 'address', 'Invalid address');
  }
  return Uri.parse(address);
}

/// get the api instance for the given base url
@riverpod
AudiobookshelfApi audiobookshelfApi(AudiobookshelfApiRef ref, Uri? baseUrl) {
  // try to get the base url from app settings
  final apiSettings = ref.watch(apiSettingsProvider);
  baseUrl ??= apiSettings.activeServer?.serverUrl;
  return AudiobookshelfApi(
    baseUrl: makeBaseUrl(baseUrl.toString()),
  );
}

/// get the api instance for the authenticated user
///
/// if the user is not authenticated throw an error
@Riverpod(keepAlive: true)
AudiobookshelfApi authenticatedApi(AuthenticatedApiRef ref) {
  final apiSettings = ref.watch(apiSettingsProvider);
  final user = apiSettings.activeUser;
  if (user == null) {
    _logger.severe('No active user can not provide authenticated api');
    throw StateError('No active user');
  }
  return AudiobookshelfApi(
    baseUrl: makeBaseUrl(user.server.serverUrl.toString()),
    token: user.authToken,
  );
}

/// ping the server to check if it is reachable
@riverpod
FutureOr<bool> isServerAlive(IsServerAliveRef ref, String address) async {
  if (address.isEmpty) {
    return false;
  }

  try {
    return await AudiobookshelfApi(baseUrl: makeBaseUrl(address))
            .server
            .ping() ??
        false;
  } catch (e) {
    return false;
  }
}

/// fetch status of server
@riverpod
FutureOr<ServerStatusResponse?> serverStatus(
  ServerStatusRef ref,
  Uri baseUrl, [
  ResponseErrorHandler? responseErrorHandler,
]) async {
  _logger.fine('fetching server status: ${baseUrl.obfuscate()}');
  final api = ref.watch(audiobookshelfApiProvider(baseUrl));
  final res =
      await api.server.status(responseErrorHandler: responseErrorHandler);
  _logger.fine('server status: $res');
  return res;
}

/// fetch the personalized view
@riverpod
class PersonalizedView extends _$PersonalizedView {
  @override
  Stream<List<Shelf>> build() async* {
    final api = ref.watch(authenticatedApiProvider);
    final apiSettings = ref.watch(apiSettingsProvider);
    final user = apiSettings.activeUser;
    if (user == null) {
      _logger.warning('no active user');
      yield [];
      return;
    }
    if (apiSettings.activeLibraryId == null) {
      // set it to default user library by logging in and getting the library id
      final login = await ref.read(loginProvider().future);
      if (login == null) {
        _logger.shout('failed to login, not building personalized view');
        yield [];
        return;
      }
      ref.read(apiSettingsProvider.notifier).updateState(
            apiSettings.copyWith(activeLibraryId: login.userDefaultLibraryId),
          );
      yield [];
      return;
    }
    // try to find in cache
    // final cacheKey = 'personalizedView:${apiSettings.activeLibraryId}';
    final key = 'personalizedView:${apiSettings.activeLibraryId! + user.id}';
    final cachedRes = await apiResponseCacheManager.getFileFromMemory(
          key,
        ) ??
        await apiResponseCacheManager.getFileFromCache(key);
    if (cachedRes != null) {
      _logger.fine('reading from cache: $cachedRes for key: $key');
      try {
        final resJson = jsonDecode(await cachedRes.file.readAsString()) as List;
        final res = [
          for (final item in resJson)
            Shelf.fromJson(item as Map<String, dynamic>),
        ];
        _logger.fine('successfully read from cache key: $key');
        yield res;
      } catch (e) {
        _logger.warning('error reading from cache: $e\n$cachedRes');
      }
    }

    // ! exaggerated delay
    // await Future.delayed(const Duration(seconds: 2));
    final res = await api.libraries
        .getPersonalized(libraryId: apiSettings.activeLibraryId!);
    // debugPrint('personalizedView: ${res!.map((e) => e).toSet()}');
    // save to cache
    if (res != null) {
      final newFile = await apiResponseCacheManager.putFile(
        key,
        utf8.encode(jsonEncode(res)),
        fileExtension: 'json',
        key: key,
      );
      _logger.fine('writing to cache: $newFile');
      yield res;
    } else {
      _logger.warning('failed to fetch personalized view');
      yield [];
    }
  }

  // method to force refresh the view and ignore the cache
  Future<void> forceRefresh() async {
    // clear the cache
    // TODO: find a better way to clear the cache for only personalized view key
    return apiResponseCacheManager.emptyCache();
  }
}

/// fetch continue listening audiobooks
@riverpod
FutureOr<GetUserSessionsResponse> fetchContinueListening(
  FetchContinueListeningRef ref,
) async {
  final api = ref.watch(authenticatedApiProvider);
  final res = await api.me.getSessions();
  // debugPrint(
  //   'fetchContinueListening: ${res.sessions.map((e) => e.libraryItemId).toSet()}',
  // );
  return res!;
}

@riverpod
FutureOr<User> me(
  MeRef ref,
) async {
  final api = ref.watch(authenticatedApiProvider);
  final errorResponseHandler = ErrorResponseHandler();
  final res = await api.me.getUser(
    responseErrorHandler: errorResponseHandler.storeError,
  );
  if (res == null) {
    _logger.severe(
      'me failed, got response: ${errorResponseHandler.response.obfuscate()}',
    );
    throw StateError('me failed');
  }
  return res;
}

@riverpod
FutureOr<LoginResponse?> login(
  LoginRef ref, {
  AuthenticatedUser? user,
}) async {
  if (user == null) {
    // try to get the user from settings
    final apiSettings = ref.watch(apiSettingsProvider);
    user = apiSettings.activeUser;
    if (user == null) {
      _logger.severe('no active user to login');
      return null;
    }
    _logger.fine('no user provided, using active user: ${user.obfuscate()}');
  }
  final api = ref.watch(audiobookshelfApiProvider(user.server.serverUrl));
  api.token = user.authToken;
  var errorResponseHandler = ErrorResponseHandler();
  _logger.fine('logging in with authenticated api');
  final res = await api.misc.authorize(
    responseErrorHandler: errorResponseHandler.storeError,
  );
  if (res == null) {
    _logger.severe(
      'login failed, got response: ${errorResponseHandler.response.obfuscate()}',
    );
    return null;
  }
  _logger.fine('login response: ${res.obfuscate()}');
  return res;
}
