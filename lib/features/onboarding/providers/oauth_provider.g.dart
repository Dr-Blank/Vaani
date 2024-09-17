// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'oauth_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$loginInExchangeForCodeHash() =>
    r'e931254959d9eb8196439c6b0c884c26cbe17c2f';

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

/// the code returned by the server in exchange for the verifier
///
/// Copied from [loginInExchangeForCode].
@ProviderFor(loginInExchangeForCode)
const loginInExchangeForCodeProvider = LoginInExchangeForCodeFamily();

/// the code returned by the server in exchange for the verifier
///
/// Copied from [loginInExchangeForCode].
class LoginInExchangeForCodeFamily extends Family<AsyncValue<String?>> {
  /// the code returned by the server in exchange for the verifier
  ///
  /// Copied from [loginInExchangeForCode].
  const LoginInExchangeForCodeFamily();

  /// the code returned by the server in exchange for the verifier
  ///
  /// Copied from [loginInExchangeForCode].
  LoginInExchangeForCodeProvider call({
    required String oauthState,
    required String code,
    ErrorResponseHandler? responseHandler,
  }) {
    return LoginInExchangeForCodeProvider(
      oauthState: oauthState,
      code: code,
      responseHandler: responseHandler,
    );
  }

  @override
  LoginInExchangeForCodeProvider getProviderOverride(
    covariant LoginInExchangeForCodeProvider provider,
  ) {
    return call(
      oauthState: provider.oauthState,
      code: provider.code,
      responseHandler: provider.responseHandler,
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
  String? get name => r'loginInExchangeForCodeProvider';
}

/// the code returned by the server in exchange for the verifier
///
/// Copied from [loginInExchangeForCode].
class LoginInExchangeForCodeProvider
    extends AutoDisposeFutureProvider<String?> {
  /// the code returned by the server in exchange for the verifier
  ///
  /// Copied from [loginInExchangeForCode].
  LoginInExchangeForCodeProvider({
    required String oauthState,
    required String code,
    ErrorResponseHandler? responseHandler,
  }) : this._internal(
          (ref) => loginInExchangeForCode(
            ref as LoginInExchangeForCodeRef,
            oauthState: oauthState,
            code: code,
            responseHandler: responseHandler,
          ),
          from: loginInExchangeForCodeProvider,
          name: r'loginInExchangeForCodeProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$loginInExchangeForCodeHash,
          dependencies: LoginInExchangeForCodeFamily._dependencies,
          allTransitiveDependencies:
              LoginInExchangeForCodeFamily._allTransitiveDependencies,
          oauthState: oauthState,
          code: code,
          responseHandler: responseHandler,
        );

  LoginInExchangeForCodeProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.oauthState,
    required this.code,
    required this.responseHandler,
  }) : super.internal();

  final String oauthState;
  final String code;
  final ErrorResponseHandler? responseHandler;

  @override
  Override overrideWith(
    FutureOr<String?> Function(LoginInExchangeForCodeRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: LoginInExchangeForCodeProvider._internal(
        (ref) => create(ref as LoginInExchangeForCodeRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        oauthState: oauthState,
        code: code,
        responseHandler: responseHandler,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<String?> createElement() {
    return _LoginInExchangeForCodeProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is LoginInExchangeForCodeProvider &&
        other.oauthState == oauthState &&
        other.code == code &&
        other.responseHandler == responseHandler;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, oauthState.hashCode);
    hash = _SystemHash.combine(hash, code.hashCode);
    hash = _SystemHash.combine(hash, responseHandler.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin LoginInExchangeForCodeRef on AutoDisposeFutureProviderRef<String?> {
  /// The parameter `oauthState` of this provider.
  String get oauthState;

  /// The parameter `code` of this provider.
  String get code;

  /// The parameter `responseHandler` of this provider.
  ErrorResponseHandler? get responseHandler;
}

class _LoginInExchangeForCodeProviderElement
    extends AutoDisposeFutureProviderElement<String?>
    with LoginInExchangeForCodeRef {
  _LoginInExchangeForCodeProviderElement(super.provider);

  @override
  String get oauthState =>
      (origin as LoginInExchangeForCodeProvider).oauthState;
  @override
  String get code => (origin as LoginInExchangeForCodeProvider).code;
  @override
  ErrorResponseHandler? get responseHandler =>
      (origin as LoginInExchangeForCodeProvider).responseHandler;
}

String _$oauthFlowsHash() => r'4e278baa0bf26f2a10694ca2caadb68dd5b6156f';

/// See also [OauthFlows].
@ProviderFor(OauthFlows)
final oauthFlowsProvider =
    NotifierProvider<OauthFlows, Map<State, Flow>>.internal(
  OauthFlows.new,
  name: r'oauthFlowsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$oauthFlowsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$OauthFlows = Notifier<Map<State, Flow>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
