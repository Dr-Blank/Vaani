// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_settings_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$bookSettingsHash() => r'b976df954edf98ec6ccb3eb41e9d07dd4a9193eb';

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

abstract class _$BookSettings
    extends BuildlessAutoDisposeNotifier<model.BookSettings> {
  late final String bookId;

  model.BookSettings build(
    String bookId,
  );
}

/// See also [BookSettings].
@ProviderFor(BookSettings)
const bookSettingsProvider = BookSettingsFamily();

/// See also [BookSettings].
class BookSettingsFamily extends Family<model.BookSettings> {
  /// See also [BookSettings].
  const BookSettingsFamily();

  /// See also [BookSettings].
  BookSettingsProvider call(
    String bookId,
  ) {
    return BookSettingsProvider(
      bookId,
    );
  }

  @override
  BookSettingsProvider getProviderOverride(
    covariant BookSettingsProvider provider,
  ) {
    return call(
      provider.bookId,
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
  String? get name => r'bookSettingsProvider';
}

/// See also [BookSettings].
class BookSettingsProvider
    extends AutoDisposeNotifierProviderImpl<BookSettings, model.BookSettings> {
  /// See also [BookSettings].
  BookSettingsProvider(
    String bookId,
  ) : this._internal(
          () => BookSettings()..bookId = bookId,
          from: bookSettingsProvider,
          name: r'bookSettingsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$bookSettingsHash,
          dependencies: BookSettingsFamily._dependencies,
          allTransitiveDependencies:
              BookSettingsFamily._allTransitiveDependencies,
          bookId: bookId,
        );

  BookSettingsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.bookId,
  }) : super.internal();

  final String bookId;

  @override
  model.BookSettings runNotifierBuild(
    covariant BookSettings notifier,
  ) {
    return notifier.build(
      bookId,
    );
  }

  @override
  Override overrideWith(BookSettings Function() create) {
    return ProviderOverride(
      origin: this,
      override: BookSettingsProvider._internal(
        () => create()..bookId = bookId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        bookId: bookId,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<BookSettings, model.BookSettings>
      createElement() {
    return _BookSettingsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is BookSettingsProvider && other.bookId == bookId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, bookId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin BookSettingsRef on AutoDisposeNotifierProviderRef<model.BookSettings> {
  /// The parameter `bookId` of this provider.
  String get bookId;
}

class _BookSettingsProviderElement
    extends AutoDisposeNotifierProviderElement<BookSettings, model.BookSettings>
    with BookSettingsRef {
  _BookSettingsProviderElement(super.provider);

  @override
  String get bookId => (origin as BookSettingsProvider).bookId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
