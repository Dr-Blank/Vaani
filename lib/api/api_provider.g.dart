// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$audiobookshelfApiHash() => r'2c310ea77fea9918ccf96180a92075acd037bd95';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// get the api instance for the given base url
///
/// Copied from [audiobookshelfApi].
@ProviderFor(audiobookshelfApi)
const audiobookshelfApiProvider = AudiobookshelfApiFamily();

/// get the api instance for the given base url
///
/// Copied from [audiobookshelfApi].
class AudiobookshelfApiFamily extends Family<AudiobookshelfApi> {
  /// get the api instance for the given base url
  ///
  /// Copied from [audiobookshelfApi].
  const AudiobookshelfApiFamily();

  /// get the api instance for the given base url
  ///
  /// Copied from [audiobookshelfApi].
  AudiobookshelfApiProvider call(
    Uri? baseUrl,
  ) {
    return AudiobookshelfApiProvider(
      baseUrl,
    );
  }

  @override
  AudiobookshelfApiProvider getProviderOverride(
    covariant AudiobookshelfApiProvider provider,
  ) {
    return call(
      provider.baseUrl,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'audiobookshelfApiProvider';
}

/// get the api instance for the given base url
///
/// Copied from [audiobookshelfApi].
class AudiobookshelfApiProvider extends AutoDisposeProvider<AudiobookshelfApi> {
  /// get the api instance for the given base url
  ///
  /// Copied from [audiobookshelfApi].
  AudiobookshelfApiProvider(
    Uri? baseUrl,
  ) : this._internal(
          (ref) => audiobookshelfApi(
            ref as AudiobookshelfApiRef,
            baseUrl,
          ),
          from: audiobookshelfApiProvider,
          name: r'audiobookshelfApiProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$audiobookshelfApiHash,
          dependencies: AudiobookshelfApiFamily._dependencies,
          allTransitiveDependencies:
              AudiobookshelfApiFamily._allTransitiveDependencies,
          baseUrl: baseUrl,
        );

  AudiobookshelfApiProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.baseUrl,
  }) : super.internal();

  final Uri? baseUrl;

  @override
  Override overrideWith(
    AudiobookshelfApi Function(AudiobookshelfApiRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: AudiobookshelfApiProvider._internal(
        (ref) => create(ref as AudiobookshelfApiRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        baseUrl: baseUrl,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<AudiobookshelfApi> createElement() {
    return _AudiobookshelfApiProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AudiobookshelfApiProvider && other.baseUrl == baseUrl;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, baseUrl.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin AudiobookshelfApiRef on AutoDisposeProviderRef<AudiobookshelfApi> {
  /// The parameter `baseUrl` of this provider.
  Uri? get baseUrl;
}

class _AudiobookshelfApiProviderElement
    extends AutoDisposeProviderElement<AudiobookshelfApi>
    with AudiobookshelfApiRef {
  _AudiobookshelfApiProviderElement(super.provider);

  @override
  Uri? get baseUrl => (origin as AudiobookshelfApiProvider).baseUrl;
}

String _$authenticatedApiHash() => r'f555efb6eede590b5a8d60cad2e6bfc2847e2d14';

/// get the api instance for the authenticated user
///
/// if the user is not authenticated throw an error
///
/// Copied from [authenticatedApi].
@ProviderFor(authenticatedApi)
final authenticatedApiProvider = Provider<AudiobookshelfApi>.internal(
  authenticatedApi,
  name: r'authenticatedApiProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$authenticatedApiHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AuthenticatedApiRef = ProviderRef<AudiobookshelfApi>;
String _$isServerAliveHash() => r'6ff90b6e0febd2cd4a4d3a5209a59afc778cd3b6';

/// ping the server to check if it is reachable
///
/// Copied from [isServerAlive].
@ProviderFor(isServerAlive)
const isServerAliveProvider = IsServerAliveFamily();

/// ping the server to check if it is reachable
///
/// Copied from [isServerAlive].
class IsServerAliveFamily extends Family<AsyncValue<bool>> {
  /// ping the server to check if it is reachable
  ///
  /// Copied from [isServerAlive].
  const IsServerAliveFamily();

  /// ping the server to check if it is reachable
  ///
  /// Copied from [isServerAlive].
  IsServerAliveProvider call(
    String address,
  ) {
    return IsServerAliveProvider(
      address,
    );
  }

  @override
  IsServerAliveProvider getProviderOverride(
    covariant IsServerAliveProvider provider,
  ) {
    return call(
      provider.address,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'isServerAliveProvider';
}

/// ping the server to check if it is reachable
///
/// Copied from [isServerAlive].
class IsServerAliveProvider extends AutoDisposeFutureProvider<bool> {
  /// ping the server to check if it is reachable
  ///
  /// Copied from [isServerAlive].
  IsServerAliveProvider(
    String address,
  ) : this._internal(
          (ref) => isServerAlive(
            ref as IsServerAliveRef,
            address,
          ),
          from: isServerAliveProvider,
          name: r'isServerAliveProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$isServerAliveHash,
          dependencies: IsServerAliveFamily._dependencies,
          allTransitiveDependencies:
              IsServerAliveFamily._allTransitiveDependencies,
          address: address,
        );

  IsServerAliveProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.address,
  }) : super.internal();

  final String address;

  @override
  Override overrideWith(
    FutureOr<bool> Function(IsServerAliveRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: IsServerAliveProvider._internal(
        (ref) => create(ref as IsServerAliveRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        address: address,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<bool> createElement() {
    return _IsServerAliveProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is IsServerAliveProvider && other.address == address;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, address.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin IsServerAliveRef on AutoDisposeFutureProviderRef<bool> {
  /// The parameter `address` of this provider.
  String get address;
}

class _IsServerAliveProviderElement
    extends AutoDisposeFutureProviderElement<bool> with IsServerAliveRef {
  _IsServerAliveProviderElement(super.provider);

  @override
  String get address => (origin as IsServerAliveProvider).address;
}

String _$serverStatusHash() => r'2739906a1862d09b098588ebd16749a09032ee99';

/// fetch status of server
///
/// Copied from [serverStatus].
@ProviderFor(serverStatus)
const serverStatusProvider = ServerStatusFamily();

/// fetch status of server
///
/// Copied from [serverStatus].
class ServerStatusFamily extends Family<AsyncValue<ServerStatusResponse?>> {
  /// fetch status of server
  ///
  /// Copied from [serverStatus].
  const ServerStatusFamily();

  /// fetch status of server
  ///
  /// Copied from [serverStatus].
  ServerStatusProvider call(
    Uri baseUrl, [
    void Function(Response, [Object?])? responseErrorHandler,
  ]) {
    return ServerStatusProvider(
      baseUrl,
      responseErrorHandler,
    );
  }

  @override
  ServerStatusProvider getProviderOverride(
    covariant ServerStatusProvider provider,
  ) {
    return call(
      provider.baseUrl,
      provider.responseErrorHandler,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'serverStatusProvider';
}

/// fetch status of server
///
/// Copied from [serverStatus].
class ServerStatusProvider
    extends AutoDisposeFutureProvider<ServerStatusResponse?> {
  /// fetch status of server
  ///
  /// Copied from [serverStatus].
  ServerStatusProvider(
    Uri baseUrl, [
    void Function(Response, [Object?])? responseErrorHandler,
  ]) : this._internal(
          (ref) => serverStatus(
            ref as ServerStatusRef,
            baseUrl,
            responseErrorHandler,
          ),
          from: serverStatusProvider,
          name: r'serverStatusProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$serverStatusHash,
          dependencies: ServerStatusFamily._dependencies,
          allTransitiveDependencies:
              ServerStatusFamily._allTransitiveDependencies,
          baseUrl: baseUrl,
          responseErrorHandler: responseErrorHandler,
        );

  ServerStatusProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.baseUrl,
    required this.responseErrorHandler,
  }) : super.internal();

  final Uri baseUrl;
  final void Function(Response, [Object?])? responseErrorHandler;

  @override
  Override overrideWith(
    FutureOr<ServerStatusResponse?> Function(ServerStatusRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ServerStatusProvider._internal(
        (ref) => create(ref as ServerStatusRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        baseUrl: baseUrl,
        responseErrorHandler: responseErrorHandler,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<ServerStatusResponse?> createElement() {
    return _ServerStatusProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ServerStatusProvider &&
        other.baseUrl == baseUrl &&
        other.responseErrorHandler == responseErrorHandler;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, baseUrl.hashCode);
    hash = _SystemHash.combine(hash, responseErrorHandler.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ServerStatusRef on AutoDisposeFutureProviderRef<ServerStatusResponse?> {
  /// The parameter `baseUrl` of this provider.
  Uri get baseUrl;

  /// The parameter `responseErrorHandler` of this provider.
  void Function(Response, [Object?])? get responseErrorHandler;
}

class _ServerStatusProviderElement
    extends AutoDisposeFutureProviderElement<ServerStatusResponse?>
    with ServerStatusRef {
  _ServerStatusProviderElement(super.provider);

  @override
  Uri get baseUrl => (origin as ServerStatusProvider).baseUrl;
  @override
  void Function(Response, [Object?])? get responseErrorHandler =>
      (origin as ServerStatusProvider).responseErrorHandler;
}

String _$fetchContinueListeningHash() =>
    r'f65fe3ac3a31b8ac074330525c5d2cc4b526802d';

/// fetch continue listening audiobooks
///
/// Copied from [fetchContinueListening].
@ProviderFor(fetchContinueListening)
final fetchContinueListeningProvider =
    AutoDisposeFutureProvider<GetUserSessionsResponse>.internal(
  fetchContinueListening,
  name: r'fetchContinueListeningProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$fetchContinueListeningHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FetchContinueListeningRef
    = AutoDisposeFutureProviderRef<GetUserSessionsResponse>;
String _$meHash() => r'bdc664c4fd867ad13018fa769ce7a6913248c44f';

/// See also [me].
@ProviderFor(me)
final meProvider = AutoDisposeFutureProvider<User>.internal(
  me,
  name: r'meProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$meHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef MeRef = AutoDisposeFutureProviderRef<User>;
String _$personalizedViewHash() => r'4c392ece4650bdc36d7195a0ddb8810e8fe4caa9';

/// fetch the personalized view
///
/// Copied from [PersonalizedView].
@ProviderFor(PersonalizedView)
final personalizedViewProvider =
    AutoDisposeStreamNotifierProvider<PersonalizedView, List<Shelf>>.internal(
  PersonalizedView.new,
  name: r'personalizedViewProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$personalizedViewHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$PersonalizedView = AutoDisposeStreamNotifier<List<Shelf>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
