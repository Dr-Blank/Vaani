// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audiobook_player.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$simpleAudiobookPlayerHash() =>
    r'b65e6d779476a2c1fa38f617771bf997acb4f5b8';

/// Simple because it doesn't rebuild when the player state changes
/// it only rebuilds when the token changes
///
/// Copied from [SimpleAudiobookPlayer].
@ProviderFor(SimpleAudiobookPlayer)
final simpleAudiobookPlayerProvider =
    NotifierProvider<SimpleAudiobookPlayer, abp.AudiobookPlayer>.internal(
  SimpleAudiobookPlayer.new,
  name: r'simpleAudiobookPlayerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$simpleAudiobookPlayerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SimpleAudiobookPlayer = Notifier<abp.AudiobookPlayer>;
String _$audiobookPlayerHash() => r'38042d0c93034e6907677fdb614a9af1b9d636af';

/// See also [AudiobookPlayer].
@ProviderFor(AudiobookPlayer)
final audiobookPlayerProvider =
    NotifierProvider<AudiobookPlayer, abp.AudiobookPlayer>.internal(
  AudiobookPlayer.new,
  name: r'audiobookPlayerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$audiobookPlayerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AudiobookPlayer = Notifier<abp.AudiobookPlayer>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
