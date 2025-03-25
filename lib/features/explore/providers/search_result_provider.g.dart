// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_result_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$searchResultHash() => r'33785de298ad0d53c9d21e8fec88ba2f22f1363f';

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

/// The provider for the search result.
///
/// Copied from [searchResult].
@ProviderFor(searchResult)
const searchResultProvider = SearchResultFamily();

/// The provider for the search result.
///
/// Copied from [searchResult].
class SearchResultFamily extends Family<AsyncValue<LibrarySearchResponse?>> {
  /// The provider for the search result.
  ///
  /// Copied from [searchResult].
  const SearchResultFamily();

  /// The provider for the search result.
  ///
  /// Copied from [searchResult].
  SearchResultProvider call(
    String query, {
    int limit = 25,
  }) {
    return SearchResultProvider(
      query,
      limit: limit,
    );
  }

  @override
  SearchResultProvider getProviderOverride(
    covariant SearchResultProvider provider,
  ) {
    return call(
      provider.query,
      limit: provider.limit,
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
  String? get name => r'searchResultProvider';
}

/// The provider for the search result.
///
/// Copied from [searchResult].
class SearchResultProvider
    extends AutoDisposeFutureProvider<LibrarySearchResponse?> {
  /// The provider for the search result.
  ///
  /// Copied from [searchResult].
  SearchResultProvider(
    String query, {
    int limit = 25,
  }) : this._internal(
          (ref) => searchResult(
            ref as SearchResultRef,
            query,
            limit: limit,
          ),
          from: searchResultProvider,
          name: r'searchResultProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$searchResultHash,
          dependencies: SearchResultFamily._dependencies,
          allTransitiveDependencies:
              SearchResultFamily._allTransitiveDependencies,
          query: query,
          limit: limit,
        );

  SearchResultProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.query,
    required this.limit,
  }) : super.internal();

  final String query;
  final int limit;

  @override
  Override overrideWith(
    FutureOr<LibrarySearchResponse?> Function(SearchResultRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SearchResultProvider._internal(
        (ref) => create(ref as SearchResultRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        query: query,
        limit: limit,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<LibrarySearchResponse?> createElement() {
    return _SearchResultProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SearchResultProvider &&
        other.query == query &&
        other.limit == limit;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, query.hashCode);
    hash = _SystemHash.combine(hash, limit.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SearchResultRef on AutoDisposeFutureProviderRef<LibrarySearchResponse?> {
  /// The parameter `query` of this provider.
  String get query;

  /// The parameter `limit` of this provider.
  int get limit;
}

class _SearchResultProviderElement
    extends AutoDisposeFutureProviderElement<LibrarySearchResponse?>
    with SearchResultRef {
  _SearchResultProviderElement(super.provider);

  @override
  String get query => (origin as SearchResultProvider).query;
  @override
  int get limit => (origin as SearchResultProvider).limit;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
