// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$coverImageHash() => r'89cc4783cbc76bb41beae34384d92fb277135c75';

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

abstract class _$CoverImage extends BuildlessStreamNotifier<Uint8List> {
  late final String itemId;

  Stream<Uint8List> build(
    String itemId,
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
    String itemId,
  ) {
    return CoverImageProvider(
      itemId,
    );
  }

  @override
  CoverImageProvider getProviderOverride(
    covariant CoverImageProvider provider,
  ) {
    return call(
      provider.itemId,
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
    extends StreamNotifierProviderImpl<CoverImage, Uint8List> {
  /// See also [CoverImage].
  CoverImageProvider(
    String itemId,
  ) : this._internal(
          () => CoverImage()..itemId = itemId,
          from: coverImageProvider,
          name: r'coverImageProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$coverImageHash,
          dependencies: CoverImageFamily._dependencies,
          allTransitiveDependencies:
              CoverImageFamily._allTransitiveDependencies,
          itemId: itemId,
        );

  CoverImageProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.itemId,
  }) : super.internal();

  final String itemId;

  @override
  Stream<Uint8List> runNotifierBuild(
    covariant CoverImage notifier,
  ) {
    return notifier.build(
      itemId,
    );
  }

  @override
  Override overrideWith(CoverImage Function() create) {
    return ProviderOverride(
      origin: this,
      override: CoverImageProvider._internal(
        () => create()..itemId = itemId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        itemId: itemId,
      ),
    );
  }

  @override
  StreamNotifierProviderElement<CoverImage, Uint8List> createElement() {
    return _CoverImageProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CoverImageProvider && other.itemId == itemId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, itemId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CoverImageRef on StreamNotifierProviderRef<Uint8List> {
  /// The parameter `itemId` of this provider.
  String get itemId;
}

class _CoverImageProviderElement
    extends StreamNotifierProviderElement<CoverImage, Uint8List>
    with CoverImageRef {
  _CoverImageProviderElement(super.provider);

  @override
  String get itemId => (origin as CoverImageProvider).itemId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
