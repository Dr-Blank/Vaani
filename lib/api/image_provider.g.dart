// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$coverImageHash() => r'34c6aaf6831fea198984d22ecdf2c5b74e110891';

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

abstract class _$CoverImage
    extends BuildlessAutoDisposeStreamNotifier<Uint8List> {
  late final LibraryItem libraryItem;

  Stream<Uint8List> build(
    LibraryItem libraryItem,
  );
}

/// See also [CoverImage].
@ProviderFor(CoverImage)
const coverImageProvider = CoverImageFamily();

/// See also [CoverImage].
class CoverImageFamily extends Family<AsyncValue<Uint8List>> {
  /// See also [CoverImage].
  const CoverImageFamily();

  /// See also [CoverImage].
  CoverImageProvider call(
    LibraryItem libraryItem,
  ) {
    return CoverImageProvider(
      libraryItem,
    );
  }

  @override
  CoverImageProvider getProviderOverride(
    covariant CoverImageProvider provider,
  ) {
    return call(
      provider.libraryItem,
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
  String? get name => r'coverImageProvider';
}

/// See also [CoverImage].
class CoverImageProvider
    extends AutoDisposeStreamNotifierProviderImpl<CoverImage, Uint8List> {
  /// See also [CoverImage].
  CoverImageProvider(
    LibraryItem libraryItem,
  ) : this._internal(
          () => CoverImage()..libraryItem = libraryItem,
          from: coverImageProvider,
          name: r'coverImageProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$coverImageHash,
          dependencies: CoverImageFamily._dependencies,
          allTransitiveDependencies:
              CoverImageFamily._allTransitiveDependencies,
          libraryItem: libraryItem,
        );

  CoverImageProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.libraryItem,
  }) : super.internal();

  final LibraryItem libraryItem;

  @override
  Stream<Uint8List> runNotifierBuild(
    covariant CoverImage notifier,
  ) {
    return notifier.build(
      libraryItem,
    );
  }

  @override
  Override overrideWith(CoverImage Function() create) {
    return ProviderOverride(
      origin: this,
      override: CoverImageProvider._internal(
        () => create()..libraryItem = libraryItem,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        libraryItem: libraryItem,
      ),
    );
  }

  @override
  AutoDisposeStreamNotifierProviderElement<CoverImage, Uint8List>
      createElement() {
    return _CoverImageProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CoverImageProvider && other.libraryItem == libraryItem;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, libraryItem.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin CoverImageRef on AutoDisposeStreamNotifierProviderRef<Uint8List> {
  /// The parameter `libraryItem` of this provider.
  LibraryItem get libraryItem;
}

class _CoverImageProviderElement
    extends AutoDisposeStreamNotifierProviderElement<CoverImage, Uint8List>
    with CoverImageRef {
  _CoverImageProviderElement(super.provider);

  @override
  LibraryItem get libraryItem => (origin as CoverImageProvider).libraryItem;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
