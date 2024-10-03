// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'download_manager.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$downloadHistoryHash() => r'76c449e8abfa61d57566991686f534a06dc7fef7';

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

/// See also [downloadHistory].
@ProviderFor(downloadHistory)
const downloadHistoryProvider = DownloadHistoryFamily();

/// See also [downloadHistory].
class DownloadHistoryFamily extends Family<AsyncValue<List<TaskRecord>>> {
  /// See also [downloadHistory].
  const DownloadHistoryFamily();

  /// See also [downloadHistory].
  DownloadHistoryProvider call({
    String? group,
  }) {
    return DownloadHistoryProvider(
      group: group,
    );
  }

  @override
  DownloadHistoryProvider getProviderOverride(
    covariant DownloadHistoryProvider provider,
  ) {
    return call(
      group: provider.group,
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
  String? get name => r'downloadHistoryProvider';
}

/// See also [downloadHistory].
class DownloadHistoryProvider
    extends AutoDisposeFutureProvider<List<TaskRecord>> {
  /// See also [downloadHistory].
  DownloadHistoryProvider({
    String? group,
  }) : this._internal(
          (ref) => downloadHistory(
            ref as DownloadHistoryRef,
            group: group,
          ),
          from: downloadHistoryProvider,
          name: r'downloadHistoryProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$downloadHistoryHash,
          dependencies: DownloadHistoryFamily._dependencies,
          allTransitiveDependencies:
              DownloadHistoryFamily._allTransitiveDependencies,
          group: group,
        );

  DownloadHistoryProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.group,
  }) : super.internal();

  final String? group;

  @override
  Override overrideWith(
    FutureOr<List<TaskRecord>> Function(DownloadHistoryRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: DownloadHistoryProvider._internal(
        (ref) => create(ref as DownloadHistoryRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        group: group,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<TaskRecord>> createElement() {
    return _DownloadHistoryProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DownloadHistoryProvider && other.group == group;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, group.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin DownloadHistoryRef on AutoDisposeFutureProviderRef<List<TaskRecord>> {
  /// The parameter `group` of this provider.
  String? get group;
}

class _DownloadHistoryProviderElement
    extends AutoDisposeFutureProviderElement<List<TaskRecord>>
    with DownloadHistoryRef {
  _DownloadHistoryProviderElement(super.provider);

  @override
  String? get group => (origin as DownloadHistoryProvider).group;
}

String _$simpleDownloadManagerHash() =>
    r'8ab13f06ec5f2f73b73064bd285813dc890b7f36';

/// See also [SimpleDownloadManager].
@ProviderFor(SimpleDownloadManager)
final simpleDownloadManagerProvider = NotifierProvider<SimpleDownloadManager,
    core.AudiobookDownloadManager>.internal(
  SimpleDownloadManager.new,
  name: r'simpleDownloadManagerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$simpleDownloadManagerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SimpleDownloadManager = Notifier<core.AudiobookDownloadManager>;
String _$downloadManagerHash() => r'852012e32e613f86445afc7f7e4e85bec808e982';

/// See also [DownloadManager].
@ProviderFor(DownloadManager)
final downloadManagerProvider =
    NotifierProvider<DownloadManager, core.AudiobookDownloadManager>.internal(
  DownloadManager.new,
  name: r'downloadManagerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$downloadManagerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$DownloadManager = Notifier<core.AudiobookDownloadManager>;
String _$isItemDownloadingHash() => r'ea43c06393beec828134e08d5f896ddbcfbac8f0';

abstract class _$IsItemDownloading extends BuildlessAutoDisposeNotifier<bool> {
  late final String id;

  bool build(
    String id,
  );
}

/// See also [IsItemDownloading].
@ProviderFor(IsItemDownloading)
const isItemDownloadingProvider = IsItemDownloadingFamily();

/// See also [IsItemDownloading].
class IsItemDownloadingFamily extends Family<bool> {
  /// See also [IsItemDownloading].
  const IsItemDownloadingFamily();

  /// See also [IsItemDownloading].
  IsItemDownloadingProvider call(
    String id,
  ) {
    return IsItemDownloadingProvider(
      id,
    );
  }

  @override
  IsItemDownloadingProvider getProviderOverride(
    covariant IsItemDownloadingProvider provider,
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
  String? get name => r'isItemDownloadingProvider';
}

/// See also [IsItemDownloading].
class IsItemDownloadingProvider
    extends AutoDisposeNotifierProviderImpl<IsItemDownloading, bool> {
  /// See also [IsItemDownloading].
  IsItemDownloadingProvider(
    String id,
  ) : this._internal(
          () => IsItemDownloading()..id = id,
          from: isItemDownloadingProvider,
          name: r'isItemDownloadingProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$isItemDownloadingHash,
          dependencies: IsItemDownloadingFamily._dependencies,
          allTransitiveDependencies:
              IsItemDownloadingFamily._allTransitiveDependencies,
          id: id,
        );

  IsItemDownloadingProvider._internal(
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
  bool runNotifierBuild(
    covariant IsItemDownloading notifier,
  ) {
    return notifier.build(
      id,
    );
  }

  @override
  Override overrideWith(IsItemDownloading Function() create) {
    return ProviderOverride(
      origin: this,
      override: IsItemDownloadingProvider._internal(
        () => create()..id = id,
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
  AutoDisposeNotifierProviderElement<IsItemDownloading, bool> createElement() {
    return _IsItemDownloadingProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is IsItemDownloadingProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin IsItemDownloadingRef on AutoDisposeNotifierProviderRef<bool> {
  /// The parameter `id` of this provider.
  String get id;
}

class _IsItemDownloadingProviderElement
    extends AutoDisposeNotifierProviderElement<IsItemDownloading, bool>
    with IsItemDownloadingRef {
  _IsItemDownloadingProviderElement(super.provider);

  @override
  String get id => (origin as IsItemDownloadingProvider).id;
}

String _$itemDownloadProgressHash() =>
    r'd007c55c6e2e4b992069d0306df8a600225d8598';

abstract class _$ItemDownloadProgress
    extends BuildlessAutoDisposeAsyncNotifier<double?> {
  late final String id;

  FutureOr<double?> build(
    String id,
  );
}

/// See also [ItemDownloadProgress].
@ProviderFor(ItemDownloadProgress)
const itemDownloadProgressProvider = ItemDownloadProgressFamily();

/// See also [ItemDownloadProgress].
class ItemDownloadProgressFamily extends Family<AsyncValue<double?>> {
  /// See also [ItemDownloadProgress].
  const ItemDownloadProgressFamily();

  /// See also [ItemDownloadProgress].
  ItemDownloadProgressProvider call(
    String id,
  ) {
    return ItemDownloadProgressProvider(
      id,
    );
  }

  @override
  ItemDownloadProgressProvider getProviderOverride(
    covariant ItemDownloadProgressProvider provider,
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
  String? get name => r'itemDownloadProgressProvider';
}

/// See also [ItemDownloadProgress].
class ItemDownloadProgressProvider extends AutoDisposeAsyncNotifierProviderImpl<
    ItemDownloadProgress, double?> {
  /// See also [ItemDownloadProgress].
  ItemDownloadProgressProvider(
    String id,
  ) : this._internal(
          () => ItemDownloadProgress()..id = id,
          from: itemDownloadProgressProvider,
          name: r'itemDownloadProgressProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$itemDownloadProgressHash,
          dependencies: ItemDownloadProgressFamily._dependencies,
          allTransitiveDependencies:
              ItemDownloadProgressFamily._allTransitiveDependencies,
          id: id,
        );

  ItemDownloadProgressProvider._internal(
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
  FutureOr<double?> runNotifierBuild(
    covariant ItemDownloadProgress notifier,
  ) {
    return notifier.build(
      id,
    );
  }

  @override
  Override overrideWith(ItemDownloadProgress Function() create) {
    return ProviderOverride(
      origin: this,
      override: ItemDownloadProgressProvider._internal(
        () => create()..id = id,
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
  AutoDisposeAsyncNotifierProviderElement<ItemDownloadProgress, double?>
      createElement() {
    return _ItemDownloadProgressProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ItemDownloadProgressProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ItemDownloadProgressRef on AutoDisposeAsyncNotifierProviderRef<double?> {
  /// The parameter `id` of this provider.
  String get id;
}

class _ItemDownloadProgressProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<ItemDownloadProgress,
        double?> with ItemDownloadProgressRef {
  _ItemDownloadProgressProviderElement(super.provider);

  @override
  String get id => (origin as ItemDownloadProgressProvider).id;
}

String _$isItemDownloadedHash() => r'9bb7ba28bdb73e1ba706e849fedc9c7bd67f4b67';

abstract class _$IsItemDownloaded
    extends BuildlessAutoDisposeAsyncNotifier<bool> {
  late final LibraryItemExpanded item;

  FutureOr<bool> build(
    LibraryItemExpanded item,
  );
}

/// See also [IsItemDownloaded].
@ProviderFor(IsItemDownloaded)
const isItemDownloadedProvider = IsItemDownloadedFamily();

/// See also [IsItemDownloaded].
class IsItemDownloadedFamily extends Family<AsyncValue<bool>> {
  /// See also [IsItemDownloaded].
  const IsItemDownloadedFamily();

  /// See also [IsItemDownloaded].
  IsItemDownloadedProvider call(
    LibraryItemExpanded item,
  ) {
    return IsItemDownloadedProvider(
      item,
    );
  }

  @override
  IsItemDownloadedProvider getProviderOverride(
    covariant IsItemDownloadedProvider provider,
  ) {
    return call(
      provider.item,
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
  String? get name => r'isItemDownloadedProvider';
}

/// See also [IsItemDownloaded].
class IsItemDownloadedProvider
    extends AutoDisposeAsyncNotifierProviderImpl<IsItemDownloaded, bool> {
  /// See also [IsItemDownloaded].
  IsItemDownloadedProvider(
    LibraryItemExpanded item,
  ) : this._internal(
          () => IsItemDownloaded()..item = item,
          from: isItemDownloadedProvider,
          name: r'isItemDownloadedProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$isItemDownloadedHash,
          dependencies: IsItemDownloadedFamily._dependencies,
          allTransitiveDependencies:
              IsItemDownloadedFamily._allTransitiveDependencies,
          item: item,
        );

  IsItemDownloadedProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.item,
  }) : super.internal();

  final LibraryItemExpanded item;

  @override
  FutureOr<bool> runNotifierBuild(
    covariant IsItemDownloaded notifier,
  ) {
    return notifier.build(
      item,
    );
  }

  @override
  Override overrideWith(IsItemDownloaded Function() create) {
    return ProviderOverride(
      origin: this,
      override: IsItemDownloadedProvider._internal(
        () => create()..item = item,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        item: item,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<IsItemDownloaded, bool>
      createElement() {
    return _IsItemDownloadedProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is IsItemDownloadedProvider && other.item == item;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, item.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin IsItemDownloadedRef on AutoDisposeAsyncNotifierProviderRef<bool> {
  /// The parameter `item` of this provider.
  LibraryItemExpanded get item;
}

class _IsItemDownloadedProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<IsItemDownloaded, bool>
    with IsItemDownloadedRef {
  _IsItemDownloadedProviderElement(super.provider);

  @override
  LibraryItemExpanded get item => (origin as IsItemDownloadedProvider).item;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
