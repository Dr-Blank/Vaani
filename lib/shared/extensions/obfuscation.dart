import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:vaani/settings/models/api_settings.dart';
import 'package:vaani/settings/models/audiobookshelf_server.dart';
import 'package:vaani/settings/models/authenticated_user.dart';

// bool kReleaseMode = true;

extension ObfuscateString on String {
  String obfuscate() {
    if (!kReleaseMode) {
      return this;
    }
    return 'obfuscated';
  }
}

extension ObfuscateURI on Uri {
  /// keeps everything except the base url for security reasons
  Uri obfuscate() {
    if (!kReleaseMode) {
      return this;
    }

    // do not obfuscate the local host
    if ([null, 'localhost'].contains(host)) {
      return this;
    }

    // do not obfuscate file urls
    if (scheme == 'file') {
      return this;
    }

    return replace(
      userInfo: userInfo == '' ? '' : 'userInfoObfuscated',
      host: 'hostObfuscated',
    );
  }
}

extension ObfuscateList<T> on List<T> {
  List<T> obfuscate() {
    return map((e) {
      if (e is AuthenticatedUser) {
        return e.obfuscate() as T;
      } else if (e is AudiobookShelfServer) {
        return e.obfuscate() as T;
      } else if (e is Uri) {
        return e.obfuscate() as T;
      } else {
        return e;
      }
    }).toList();
  }
}

extension ObfuscateSet<T> on Set<T> {
  Set<T> obfuscate() {
    return toList().obfuscate().toSet();
  }
}

extension ObfuscateAuthenticatedUser on AuthenticatedUser {
  AuthenticatedUser obfuscate() {
    if (!kReleaseMode) {
      return this;
    }
    return copyWith(
      password: password == null ? null : 'passwordObfuscated',
      username: username == null ? null : 'usernameObfuscated',
      authToken: 'authTokenObfuscated',
      server: server.obfuscate(),
    );
  }
}

extension ObfuscateServer on AudiobookShelfServer {
  AudiobookShelfServer obfuscate() {
    if (!kReleaseMode) {
      return this;
    }
    return copyWith(
      serverUrl: serverUrl.obfuscate(),
    );
  }
}

extension ObfuscateApiSettings on ApiSettings {
  ApiSettings obfuscate() {
    if (!kReleaseMode) {
      return this;
    }
    return copyWith(
      activeServer: activeServer?.obfuscate(),
      activeUser: activeUser?.obfuscate(),
    );
  }
}

extension ObfuscateRequest on http.BaseRequest {
  http.BaseRequest obfuscate() {
    if (!kReleaseMode) {
      return this;
    }
    return http.Request(
      method,
      url.obfuscate(),
    );
  }
}

extension ObfuscateResponse on http.Response {
  http.Response obfuscate() {
    if (!kReleaseMode) {
      return this;
    }
    return http.Response(
      body,
      statusCode,
      headers: headers,
      request: request?.obfuscate(),
    );
  }
}
