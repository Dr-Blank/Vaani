// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_from_cover_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$themeFromCoverHash() => r'a549513a0dcdff76be94488baf38a8b886ce63eb';

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

/// See also [themeFromCover].
@ProviderFor(themeFromCover)
const themeFromCoverProvider = ThemeFromCoverFamily();

/// See also [themeFromCover].
class ThemeFromCoverFamily extends Family<AsyncValue<FutureOr<ColorScheme?>>> {
  /// See also [themeFromCover].
  const ThemeFromCoverFamily();

  /// See also [themeFromCover].
  ThemeFromCoverProvider call(
    ImageProvider<Object> img, {
    Brightness brightness = Brightness.dark,
  }) {
    return ThemeFromCoverProvider(
      img,
      brightness: brightness,
    );
  }

  @override
  ThemeFromCoverProvider getProviderOverride(
    covariant ThemeFromCoverProvider provider,
  ) {
    return call(
      provider.img,
      brightness: provider.brightness,
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
  String? get name => r'themeFromCoverProvider';
}

/// See also [themeFromCover].
class ThemeFromCoverProvider extends FutureProvider<FutureOr<ColorScheme?>> {
  /// See also [themeFromCover].
  ThemeFromCoverProvider(
    ImageProvider<Object> img, {
    Brightness brightness = Brightness.dark,
  }) : this._internal(
          (ref) => themeFromCover(
            ref as ThemeFromCoverRef,
            img,
            brightness: brightness,
          ),
          from: themeFromCoverProvider,
          name: r'themeFromCoverProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$themeFromCoverHash,
          dependencies: ThemeFromCoverFamily._dependencies,
          allTransitiveDependencies:
              ThemeFromCoverFamily._allTransitiveDependencies,
          img: img,
          brightness: brightness,
        );

  ThemeFromCoverProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.img,
    required this.brightness,
  }) : super.internal();

  final ImageProvider<Object> img;
  final Brightness brightness;

  @override
  Override overrideWith(
    FutureOr<FutureOr<ColorScheme?>> Function(ThemeFromCoverRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ThemeFromCoverProvider._internal(
        (ref) => create(ref as ThemeFromCoverRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        img: img,
        brightness: brightness,
      ),
    );
  }

  @override
  FutureProviderElement<FutureOr<ColorScheme?>> createElement() {
    return _ThemeFromCoverProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ThemeFromCoverProvider &&
        other.img == img &&
        other.brightness == brightness;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, img.hashCode);
    hash = _SystemHash.combine(hash, brightness.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ThemeFromCoverRef on FutureProviderRef<FutureOr<ColorScheme?>> {
  /// The parameter `img` of this provider.
  ImageProvider<Object> get img;

  /// The parameter `brightness` of this provider.
  Brightness get brightness;
}

class _ThemeFromCoverProviderElement
    extends FutureProviderElement<FutureOr<ColorScheme?>>
    with ThemeFromCoverRef {
  _ThemeFromCoverProviderElement(super.provider);

  @override
  ImageProvider<Object> get img => (origin as ThemeFromCoverProvider).img;
  @override
  Brightness get brightness => (origin as ThemeFromCoverProvider).brightness;
}

String _$themeOfLibraryItemHash() =>
    r'a1d0e5d81f4debe88d5a6ce46c3af28623ad4273';

/// See also [themeOfLibraryItem].
@ProviderFor(themeOfLibraryItem)
const themeOfLibraryItemProvider = ThemeOfLibraryItemFamily();

/// See also [themeOfLibraryItem].
class ThemeOfLibraryItemFamily extends Family<AsyncValue<ColorScheme?>> {
  /// See also [themeOfLibraryItem].
  const ThemeOfLibraryItemFamily();

  /// See also [themeOfLibraryItem].
  ThemeOfLibraryItemProvider call(
    String? itemId, {
    Brightness brightness = Brightness.dark,
  }) {
    return ThemeOfLibraryItemProvider(
      itemId,
      brightness: brightness,
    );
  }

  @override
  ThemeOfLibraryItemProvider getProviderOverride(
    covariant ThemeOfLibraryItemProvider provider,
  ) {
    return call(
      provider.itemId,
      brightness: provider.brightness,
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
  String? get name => r'themeOfLibraryItemProvider';
}

/// See also [themeOfLibraryItem].
class ThemeOfLibraryItemProvider extends FutureProvider<ColorScheme?> {
  /// See also [themeOfLibraryItem].
  ThemeOfLibraryItemProvider(
    String? itemId, {
    Brightness brightness = Brightness.dark,
  }) : this._internal(
          (ref) => themeOfLibraryItem(
            ref as ThemeOfLibraryItemRef,
            itemId,
            brightness: brightness,
          ),
          from: themeOfLibraryItemProvider,
          name: r'themeOfLibraryItemProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$themeOfLibraryItemHash,
          dependencies: ThemeOfLibraryItemFamily._dependencies,
          allTransitiveDependencies:
              ThemeOfLibraryItemFamily._allTransitiveDependencies,
          itemId: itemId,
          brightness: brightness,
        );

  ThemeOfLibraryItemProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.itemId,
    required this.brightness,
  }) : super.internal();

  final String? itemId;
  final Brightness brightness;

  @override
  Override overrideWith(
    FutureOr<ColorScheme?> Function(ThemeOfLibraryItemRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ThemeOfLibraryItemProvider._internal(
        (ref) => create(ref as ThemeOfLibraryItemRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        itemId: itemId,
        brightness: brightness,
      ),
    );
  }

  @override
  FutureProviderElement<ColorScheme?> createElement() {
    return _ThemeOfLibraryItemProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ThemeOfLibraryItemProvider &&
        other.itemId == itemId &&
        other.brightness == brightness;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, itemId.hashCode);
    hash = _SystemHash.combine(hash, brightness.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ThemeOfLibraryItemRef on FutureProviderRef<ColorScheme?> {
  /// The parameter `itemId` of this provider.
  String? get itemId;

  /// The parameter `brightness` of this provider.
  Brightness get brightness;
}

class _ThemeOfLibraryItemProviderElement
    extends FutureProviderElement<ColorScheme?> with ThemeOfLibraryItemRef {
  _ThemeOfLibraryItemProviderElement(super.provider);

  @override
  String? get itemId => (origin as ThemeOfLibraryItemProvider).itemId;
  @override
  Brightness get brightness =>
      (origin as ThemeOfLibraryItemProvider).brightness;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
