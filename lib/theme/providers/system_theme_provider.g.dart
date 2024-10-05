// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'system_theme_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$systemThemeHash() => r'0af4a012a2a2b2fa91642a1313515cba02cd3535';

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

/// copied from [DynamicColorBuilder]
///
/// Copied from [systemTheme].
@ProviderFor(systemTheme)
const systemThemeProvider = SystemThemeFamily();

/// copied from [DynamicColorBuilder]
///
/// Copied from [systemTheme].
class SystemThemeFamily
    extends Family<AsyncValue<(ColorScheme light, ColorScheme dark)?>> {
  /// copied from [DynamicColorBuilder]
  ///
  /// Copied from [systemTheme].
  const SystemThemeFamily();

  /// copied from [DynamicColorBuilder]
  ///
  /// Copied from [systemTheme].
  SystemThemeProvider call({
    bool highContrast = false,
  }) {
    return SystemThemeProvider(
      highContrast: highContrast,
    );
  }

  @override
  SystemThemeProvider getProviderOverride(
    covariant SystemThemeProvider provider,
  ) {
    return call(
      highContrast: provider.highContrast,
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
  String? get name => r'systemThemeProvider';
}

/// copied from [DynamicColorBuilder]
///
/// Copied from [systemTheme].
class SystemThemeProvider
    extends FutureProvider<(ColorScheme light, ColorScheme dark)?> {
  /// copied from [DynamicColorBuilder]
  ///
  /// Copied from [systemTheme].
  SystemThemeProvider({
    bool highContrast = false,
  }) : this._internal(
          (ref) => systemTheme(
            ref as SystemThemeRef,
            highContrast: highContrast,
          ),
          from: systemThemeProvider,
          name: r'systemThemeProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$systemThemeHash,
          dependencies: SystemThemeFamily._dependencies,
          allTransitiveDependencies:
              SystemThemeFamily._allTransitiveDependencies,
          highContrast: highContrast,
        );

  SystemThemeProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.highContrast,
  }) : super.internal();

  final bool highContrast;

  @override
  Override overrideWith(
    FutureOr<(ColorScheme light, ColorScheme dark)?> Function(
            SystemThemeRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SystemThemeProvider._internal(
        (ref) => create(ref as SystemThemeRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        highContrast: highContrast,
      ),
    );
  }

  @override
  FutureProviderElement<(ColorScheme light, ColorScheme dark)?>
      createElement() {
    return _SystemThemeProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SystemThemeProvider && other.highContrast == highContrast;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, highContrast.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SystemThemeRef
    on FutureProviderRef<(ColorScheme light, ColorScheme dark)?> {
  /// The parameter `highContrast` of this provider.
  bool get highContrast;
}

class _SystemThemeProviderElement
    extends FutureProviderElement<(ColorScheme light, ColorScheme dark)?>
    with SystemThemeRef {
  _SystemThemeProviderElement(super.provider);

  @override
  bool get highContrast => (origin as SystemThemeProvider).highContrast;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
