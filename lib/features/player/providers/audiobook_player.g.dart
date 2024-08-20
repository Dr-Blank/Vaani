// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audiobook_player.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$simpleAudiobookPlayerHash() =>
    r'9e11ed2791d35e308f8cbe61a79a45cf51466ebb';

/// Simple because it doesn't rebuild when the player state changes
/// it only rebuilds when the token changes
///
/// Copied from [SimpleAudiobookPlayer].
@ProviderFor(SimpleAudiobookPlayer)
final simpleAudiobookPlayerProvider =
    NotifierProvider<SimpleAudiobookPlayer, core.AudiobookPlayer>.internal(
  SimpleAudiobookPlayer.new,
  name: r'simpleAudiobookPlayerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$simpleAudiobookPlayerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SimpleAudiobookPlayer = Notifier<core.AudiobookPlayer>;
String _$audiobookPlayerHash() => r'44394b1dbbf85eb19ef1f693717e8cbc15b768e5';

/// See also [AudiobookPlayer].
@ProviderFor(AudiobookPlayer)
final audiobookPlayerProvider =
    NotifierProvider<AudiobookPlayer, core.AudiobookPlayer>.internal(
  AudiobookPlayer.new,
  name: r'audiobookPlayerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$audiobookPlayerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AudiobookPlayer = Notifier<core.AudiobookPlayer>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
