// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audiobook_player.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$simpleAudiobookPlayerHash() =>
    r'5e94bbff4314adceb5affa704fc4d079d4016afa';

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
String _$audiobookPlayerHash() => r'0f180308067486896fec6a65a6afb0e6686ac4a0';

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
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
