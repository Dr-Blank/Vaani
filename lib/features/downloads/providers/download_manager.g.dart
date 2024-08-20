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

String _$downloadStatusHash() => r'f37b4678d3c2a7c6e985b0149d72ea0f9b1b42ca';

/// See also [downloadStatus].
@ProviderFor(downloadStatus)
const downloadStatusProvider = DownloadStatusFamily();

/// See also [downloadStatus].
class DownloadStatusFamily extends Family<AsyncValue<bool>> {
  /// See also [downloadStatus].
  const DownloadStatusFamily();

  /// See also [downloadStatus].
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

/// See also [downloadStatus].
class DownloadStatusProvider extends AutoDisposeFutureProvider<bool> {
  /// See also [downloadStatus].
  DownloadStatusProvider(
    LibraryItemExpanded item,
  ) : this._internal(
          (ref) => downloadStatus(
            ref as DownloadStatusRef,
            item,
          ),
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
  Override overrideWith(
    FutureOr<bool> Function(DownloadStatusRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: DownloadStatusProvider._internal(
        (ref) => create(ref as DownloadStatusRef),
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
  AutoDisposeFutureProviderElement<bool> createElement() {
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

mixin DownloadStatusRef on AutoDisposeFutureProviderRef<bool> {
  /// The parameter `item` of this provider.
  LibraryItemExpanded get item;
}

class _DownloadStatusProviderElement
    extends AutoDisposeFutureProviderElement<bool> with DownloadStatusRef {
  _DownloadStatusProviderElement(super.provider);

  @override
  LibraryItemExpanded get item => (origin as DownloadStatusProvider).item;
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
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
