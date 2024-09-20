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
    r'cec95717c86e422f88f78aa014d29e800e5a2089';

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
String _$downloadManagerHash() => r'bf08bdeda54773a4b6713ad77abb75add3ed30ee';

/// See also [DownloadManager].
@ProviderFor(DownloadManager)
final downloadManagerProvider = AutoDisposeNotifierProvider<DownloadManager,
    core.AudiobookDownloadManager>.internal(
  DownloadManager.new,
  name: r'downloadManagerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$downloadManagerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$DownloadManager = AutoDisposeNotifier<core.AudiobookDownloadManager>;
String _$isItemDownloadingHash() => r'07e35ae25c096e9c9071667c6303a43f7b5e4cff';

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

String _$downloadProgressHash() => r'1677f45191181765f6efebdb74206a438a47a4b7';

abstract class _$DownloadProgress extends BuildlessNotifier<double> {
  late final String id;

  double build(
    String id,
  );
}

/// See also [DownloadProgress].
@ProviderFor(DownloadProgress)
const downloadProgressProvider = DownloadProgressFamily();

/// See also [DownloadProgress].
class DownloadProgressFamily extends Family<double> {
  /// See also [DownloadProgress].
  const DownloadProgressFamily();

  /// See also [DownloadProgress].
  DownloadProgressProvider call(
    String id,
  ) {
    return DownloadProgressProvider(
      id,
    );
  }

  @override
  DownloadProgressProvider getProviderOverride(
    covariant DownloadProgressProvider provider,
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
  String? get name => r'downloadProgressProvider';
}

/// See also [DownloadProgress].
class DownloadProgressProvider
    extends NotifierProviderImpl<DownloadProgress, double> {
  /// See also [DownloadProgress].
  DownloadProgressProvider(
    String id,
  ) : this._internal(
          () => DownloadProgress()..id = id,
          from: downloadProgressProvider,
          name: r'downloadProgressProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$downloadProgressHash,
          dependencies: DownloadProgressFamily._dependencies,
          allTransitiveDependencies:
              DownloadProgressFamily._allTransitiveDependencies,
          id: id,
        );

  DownloadProgressProvider._internal(
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
  double runNotifierBuild(
    covariant DownloadProgress notifier,
  ) {
    return notifier.build(
      id,
    );
  }

  @override
  Override overrideWith(DownloadProgress Function() create) {
    return ProviderOverride(
      origin: this,
      override: DownloadProgressProvider._internal(
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
  NotifierProviderElement<DownloadProgress, double> createElement() {
    return _DownloadProgressProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DownloadProgressProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin DownloadProgressRef on NotifierProviderRef<double> {
  /// The parameter `id` of this provider.
  String get id;
}

class _DownloadProgressProviderElement
    extends NotifierProviderElement<DownloadProgress, double>
    with DownloadProgressRef {
  _DownloadProgressProviderElement(super.provider);

  @override
  String get id => (origin as DownloadProgressProvider).id;
}

String _$downloadStatusHash() => r'3f2bf4e7fb01b9329d31f4797537a307aff70397';

abstract class _$DownloadStatus
    extends BuildlessAutoDisposeAsyncNotifier<bool> {
  late final LibraryItemExpanded item;

  FutureOr<bool> build(
    LibraryItemExpanded item,
  );
}

/// See also [DownloadStatus].
@ProviderFor(DownloadStatus)
const downloadStatusProvider = DownloadStatusFamily();

/// See also [DownloadStatus].
class DownloadStatusFamily extends Family<AsyncValue<bool>> {
  /// See also [DownloadStatus].
  const DownloadStatusFamily();

  /// See also [DownloadStatus].
  DownloadStatusProvider call(
    LibraryItemExpanded item,
  ) {
    return DownloadStatusProvider(
      item,
    );
  }

  @override
  DownloadStatusProvider getProviderOverride(
    covariant DownloadStatusProvider provider,
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
  String? get name => r'downloadStatusProvider';
}

/// See also [DownloadStatus].
class DownloadStatusProvider
    extends AutoDisposeAsyncNotifierProviderImpl<DownloadStatus, bool> {
  /// See also [DownloadStatus].
  DownloadStatusProvider(
    LibraryItemExpanded item,
  ) : this._internal(
          () => DownloadStatus()..item = item,
          from: downloadStatusProvider,
          name: r'downloadStatusProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$downloadStatusHash,
          dependencies: DownloadStatusFamily._dependencies,
          allTransitiveDependencies:
              DownloadStatusFamily._allTransitiveDependencies,
          item: item,
        );

  DownloadStatusProvider._internal(
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
    covariant DownloadStatus notifier,
  ) {
    return notifier.build(
      item,
    );
  }

  @override
  Override overrideWith(DownloadStatus Function() create) {
    return ProviderOverride(
      origin: this,
      override: DownloadStatusProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<DownloadStatus, bool>
      createElement() {
    return _DownloadStatusProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DownloadStatusProvider && other.item == item;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, item.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin DownloadStatusRef on AutoDisposeAsyncNotifierProviderRef<bool> {
  /// The parameter `item` of this provider.
  LibraryItemExpanded get item;
}

class _DownloadStatusProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<DownloadStatus, bool>
    with DownloadStatusRef {
  _DownloadStatusProviderElement(super.provider);

  @override
  LibraryItemExpanded get item => (origin as DownloadStatusProvider).item;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
