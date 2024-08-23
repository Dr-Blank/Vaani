// provider to provide the api instance

import 'dart:convert';

import 'package:logging/logging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shelfsdk/audiobookshelf_api.dart';
import 'package:whispering_pages/db/cache_manager.dart';
import 'package:whispering_pages/settings/api_settings_provider.dart';

part 'api_provider.g.dart';

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
  if (baseUrl == null) {
    throw ArgumentError.notNull('baseUrl');
  }
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
  // return (await ref.watch(audiobookshelfApiProvider).server.ping()) ?? false;
  // if address not starts with http or https, add https

  // !remove this line
  // return true;

  if (address.isEmpty) {
    return false;
  }
  if (!address.startsWith('http') && !address.startsWith('https')) {
    address = 'https://$address';
  }

  // check url is valid
  if (!Uri.parse(address).isAbsolute) {
    return false;
  }
  return await AudiobookshelfApi(baseUrl: Uri.parse(address)).server.ping() ??
      false;
}

/// fetch the personalized view
@riverpod
class PersonalizedView extends _$PersonalizedView {
  @override
  Stream<List<Shelf>> build() async* {
    final api = ref.watch(authenticatedApiProvider);
    final apiSettings = ref.watch(apiSettingsProvider);
    final user = apiSettings.activeUser;
    if (apiSettings.activeLibraryId == null) {
      // set it to default user library by logging in and getting the library id
      final login =
          await api.login(username: user!.username!, password: user.password!);
      ref.read(apiSettingsProvider.notifier).updateState(
            apiSettings.copyWith(activeLibraryId: login!.userDefaultLibraryId),
          );
    }
    // try to find in cache
    // final cacheKey = 'personalizedView:${apiSettings.activeLibraryId}';
    var key = 'personalizedView:${apiSettings.activeLibraryId! + user!.id!}';
    final cachedRes = await apiResponseCacheManager.getFileFromMemory(
          key,
        ) ??
        await apiResponseCacheManager.getFileFromCache(key);
    if (cachedRes != null) {
      final resJson = jsonDecode(await cachedRes.file.readAsString()) as List;
      final res = [
        for (final item in resJson)
          Shelf.fromJson(item as Map<String, dynamic>),
      ];
      _logger.fine('reading from cache: $cachedRes');
      yield res;
    }

    // ! exagerated delay
    // await Future.delayed(const Duration(seconds: 2));
    final res = await api.libraries
        .getPersonalized(libraryId: apiSettings.activeLibraryId!);
    // debugPrint('personalizedView: ${res!.map((e) => e).toSet()}');
    // save to cache
    final newFile = await apiResponseCacheManager.putFile(
      key,
      utf8.encode(jsonEncode(res)),
      fileExtension: 'json',
      key: key,
    );
    _logger.fine('writing to cache: $newFile');
    yield res!;
  }

  // method to force refresh the view and ignore the cache
  Future<void> forceRefresh() async {
    // clear the cache
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
  final res = await api.me.getUser();
  return res!;
}
