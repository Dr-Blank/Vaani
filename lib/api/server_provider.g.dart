// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$audiobookShelfServerHash() =>
    r'f0d645bb42233c59886bc43fdc473897484ceca1';

/// provides with a set of servers added by the user
///
/// Copied from [AudiobookShelfServer].
@ProviderFor(AudiobookShelfServer)
final audiobookShelfServerProvider = AutoDisposeNotifierProvider<
    AudiobookShelfServer, Set<model.AudiobookShelfServer>>.internal(
  AudiobookShelfServer.new,
  name: r'audiobookShelfServerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$audiobookShelfServerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AudiobookShelfServer
    = AutoDisposeNotifier<Set<model.AudiobookShelfServer>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
