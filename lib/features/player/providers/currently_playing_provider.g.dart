// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currently_playing_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$currentlyPlayingBookHash() =>
    r'e4258694c8f0d1e89651b330fae0f672ca13a484';

/// See also [currentlyPlayingBook].
@ProviderFor(currentlyPlayingBook)
final currentlyPlayingBookProvider =
    AutoDisposeProvider<BookExpanded?>.internal(
  currentlyPlayingBook,
  name: r'currentlyPlayingBookProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentlyPlayingBookHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CurrentlyPlayingBookRef = AutoDisposeProviderRef<BookExpanded?>;
String _$currentPlayingChapterHash() =>
    r'73db8b8a9058573bb0c68ec5d5f8aba9306f3d24';

/// provided the current chapter of the book being played
///
/// Copied from [currentPlayingChapter].
@ProviderFor(currentPlayingChapter)
final currentPlayingChapterProvider =
    AutoDisposeProvider<BookChapter?>.internal(
  currentPlayingChapter,
  name: r'currentPlayingChapterProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentPlayingChapterHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CurrentPlayingChapterRef = AutoDisposeProviderRef<BookChapter?>;
String _$currentBookMetadataHash() =>
    r'f537ef4ef19280bc952de658ecf6520c535ae344';

/// provides the book metadata of the currently playing book
///
/// Copied from [currentBookMetadata].
@ProviderFor(currentBookMetadata)
final currentBookMetadataProvider =
    AutoDisposeProvider<BookMetadataExpanded?>.internal(
  currentBookMetadata,
  name: r'currentBookMetadataProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentBookMetadataHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CurrentBookMetadataRef = AutoDisposeProviderRef<BookMetadataExpanded?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
