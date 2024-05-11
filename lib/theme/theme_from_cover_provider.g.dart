// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_from_cover_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$themeFromCoverHash() => r'b1d56a4add77d157a803424d02ef52c4d8c3f1d7';

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
class ThemeFromCoverProvider
    extends AutoDisposeFutureProvider<FutureOr<ColorScheme?>> {
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
  AutoDisposeFutureProviderElement<FutureOr<ColorScheme?>> createElement() {
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

mixin ThemeFromCoverRef
    on AutoDisposeFutureProviderRef<FutureOr<ColorScheme?>> {
  /// The parameter `img` of this provider.
  ImageProvider<Object> get img;

  /// The parameter `brightness` of this provider.
  Brightness get brightness;
}

class _ThemeFromCoverProviderElement
    extends AutoDisposeFutureProviderElement<FutureOr<ColorScheme?>>
    with ThemeFromCoverRef {
  _ThemeFromCoverProviderElement(super.provider);

  @override
  ImageProvider<Object> get img => (origin as ThemeFromCoverProvider).img;
  @override
  Brightness get brightness => (origin as ThemeFromCoverProvider).brightness;
}

String _$themeOfLibraryItemHash() =>
    r'53be78f35075ced924e7b2f3cb7310a09d4cd232';

/// See also [themeOfLibraryItem].
@ProviderFor(themeOfLibraryItem)
const themeOfLibraryItemProvider = ThemeOfLibraryItemFamily();

/// See also [themeOfLibraryItem].
class ThemeOfLibraryItemFamily extends Family<AsyncValue<ColorScheme?>> {
  /// See also [themeOfLibraryItem].
  const ThemeOfLibraryItemFamily();

  /// See also [themeOfLibraryItem].
  ThemeOfLibraryItemProvider call(
    LibraryItem? item, {
    Brightness brightness = Brightness.dark,
  }) {
    return ThemeOfLibraryItemProvider(
      item,
      brightness: brightness,
    );
  }

  @override
  ThemeOfLibraryItemProvider getProviderOverride(
    covariant ThemeOfLibraryItemProvider provider,
  ) {
    return call(
      provider.item,
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
class ThemeOfLibraryItemProvider
    extends AutoDisposeFutureProvider<ColorScheme?> {
  /// See also [themeOfLibraryItem].
  ThemeOfLibraryItemProvider(
    LibraryItem? item, {
    Brightness brightness = Brightness.dark,
  }) : this._internal(
          (ref) => themeOfLibraryItem(
            ref as ThemeOfLibraryItemRef,
            item,
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
          item: item,
          brightness: brightness,
        );

  ThemeOfLibraryItemProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.item,
    required this.brightness,
  }) : super.internal();

  final LibraryItem? item;
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
        item: item,
        brightness: brightness,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<ColorScheme?> createElement() {
    return _ThemeOfLibraryItemProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ThemeOfLibraryItemProvider &&
        other.item == item &&
        other.brightness == brightness;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, item.hashCode);
    hash = _SystemHash.combine(hash, brightness.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ThemeOfLibraryItemRef on AutoDisposeFutureProviderRef<ColorScheme?> {
  /// The parameter `item` of this provider.
  LibraryItem? get item;

  /// The parameter `brightness` of this provider.
  Brightness get brightness;
}

class _ThemeOfLibraryItemProviderElement
    extends AutoDisposeFutureProviderElement<ColorScheme?>
    with ThemeOfLibraryItemRef {
  _ThemeOfLibraryItemProviderElement(super.provider);

  @override
  LibraryItem? get item => (origin as ThemeOfLibraryItemProvider).item;
  @override
  Brightness get brightness =>
      (origin as ThemeOfLibraryItemProvider).brightness;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
