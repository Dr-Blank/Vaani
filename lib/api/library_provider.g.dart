// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'library_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$libraryHash() => r'f8a34100acb58f02fa958c71a629577bf815710e';

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

/// See also [library].
@ProviderFor(library)
const libraryProvider = LibraryFamily();

/// See also [library].
class LibraryFamily extends Family<AsyncValue<Library?>> {
  /// See also [library].
  const LibraryFamily();

  /// See also [library].
  LibraryProvider call(
    String id,
  ) {
    return LibraryProvider(
      id,
    );
  }

  @override
  LibraryProvider getProviderOverride(
    covariant LibraryProvider provider,
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
  String? get name => r'libraryProvider';
}

/// See also [library].
class LibraryProvider extends AutoDisposeFutureProvider<Library?> {
  /// See also [library].
  LibraryProvider(
    String id,
  ) : this._internal(
          (ref) => library(
            ref as LibraryRef,
            id,
          ),
          from: libraryProvider,
          name: r'libraryProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$libraryHash,
          dependencies: LibraryFamily._dependencies,
          allTransitiveDependencies: LibraryFamily._allTransitiveDependencies,
          id: id,
        );

  LibraryProvider._internal(
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
    FutureOr<Library?> Function(LibraryRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: LibraryProvider._internal(
        (ref) => create(ref as LibraryRef),
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
    return _LibraryProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is LibraryProvider && other.id == id;
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
mixin LibraryRef on AutoDisposeFutureProviderRef<Library?> {
  /// The parameter `id` of this provider.
  String get id;
}

class _LibraryProviderElement extends AutoDisposeFutureProviderElement<Library?>
    with LibraryRef {
  _LibraryProviderElement(super.provider);

  @override
  String get id => (origin as LibraryProvider).id;
}

String _$currentLibraryHash() => r'658498a531e04a01e2b3915a3319101285601118';

/// See also [currentLibrary].
@ProviderFor(currentLibrary)
final currentLibraryProvider = AutoDisposeFutureProvider<Library?>.internal(
  currentLibrary,
  name: r'currentLibraryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentLibraryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CurrentLibraryRef = AutoDisposeFutureProviderRef<Library?>;
String _$librariesHash() => r'95ebd4d1ac0cc2acf7617dc22895eff0ca30600f';

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
