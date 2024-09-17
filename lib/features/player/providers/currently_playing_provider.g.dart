// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currently_playing_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$currentlyPlayingBookHash() =>
    r'52334c7b4d68fd498a2a00208d8d7f1ba0085237';

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

typedef CurrentlyPlayingBookRef = AutoDisposeProviderRef<BookExpanded?>;
String _$currentPlayingChapterHash() =>
    r'a084da724e3d8bb1b1475e867ab3200d7d61d827';

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

typedef CurrentPlayingChapterRef = AutoDisposeProviderRef<BookChapter?>;
String _$currentBookMetadataHash() =>
    r'9088debba151894b61f2dcba1bba12a89244b9b1';

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

typedef CurrentBookMetadataRef = AutoDisposeProviderRef<BookMetadataExpanded?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
