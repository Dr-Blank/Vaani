// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currently_playing_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$currentlyPlayingBookHash() =>
    r'c777ea8b463d8441a0da5e08b4c41b501ce68aad';

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
    r'3a621260211cddecfd974b31d5c4820ed24b1545';

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
    r'02b462a051fce5bcbdad6fdb708b60256fbb588c';

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
