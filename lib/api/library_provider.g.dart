// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'library_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$currentLibraryHash() => r'1b41abb16566d91cd5961973e45bccaad7c49c9a';

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

/// See also [currentLibrary].
@ProviderFor(currentLibrary)
const currentLibraryProvider = CurrentLibraryFamily();

/// See also [currentLibrary].
class CurrentLibraryFamily extends Family<AsyncValue<Library?>> {
  /// See also [currentLibrary].
  const CurrentLibraryFamily();

  /// See also [currentLibrary].
  CurrentLibraryProvider call(
    String id,
  ) {
    return CurrentLibraryProvider(
      id,
    );
  }

  @override
  CurrentLibraryProvider getProviderOverride(
    covariant CurrentLibraryProvider provider,
  ) {
    return call(
      provider.id,
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
  String? get name => r'currentLibraryProvider';
}

/// See also [currentLibrary].
class CurrentLibraryProvider extends AutoDisposeFutureProvider<Library?> {
  /// See also [currentLibrary].
  CurrentLibraryProvider(
    String id,
  ) : this._internal(
          (ref) => currentLibrary(
            ref as CurrentLibraryRef,
            id,
          ),
          from: currentLibraryProvider,
          name: r'currentLibraryProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$currentLibraryHash,
          dependencies: CurrentLibraryFamily._dependencies,
          allTransitiveDependencies:
              CurrentLibraryFamily._allTransitiveDependencies,
          id: id,
        );

  CurrentLibraryProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String id;

  @override
  Override overrideWith(
    FutureOr<Library?> Function(CurrentLibraryRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CurrentLibraryProvider._internal(
        (ref) => create(ref as CurrentLibraryRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Library?> createElement() {
    return _CurrentLibraryProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CurrentLibraryProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CurrentLibraryRef on AutoDisposeFutureProviderRef<Library?> {
  /// The parameter `id` of this provider.
  String get id;
}

class _CurrentLibraryProviderElement
    extends AutoDisposeFutureProviderElement<Library?> with CurrentLibraryRef {
  _CurrentLibraryProviderElement(super.provider);

  @override
  String get id => (origin as CurrentLibraryProvider).id;
}

String _$librariesHash() => r'a57828f3b875d56db6c5815d051eca93695aefe2';

/// See also [Libraries].
@ProviderFor(Libraries)
final librariesProvider =
    AutoDisposeAsyncNotifierProvider<Libraries, List<Library>>.internal(
  Libraries.new,
  name: r'librariesProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$librariesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Libraries = AutoDisposeAsyncNotifier<List<Library>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
