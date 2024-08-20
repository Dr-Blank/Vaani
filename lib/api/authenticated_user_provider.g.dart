// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authenticated_user_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$authenticatedUserHash() => r'8578d7fda1755ecacce6853076da4149e4ebe3e7';

/// provides with a set of authenticated users
///
/// Copied from [AuthenticatedUser].
@ProviderFor(AuthenticatedUser)
final authenticatedUserProvider = AutoDisposeNotifierProvider<AuthenticatedUser,
    Set<model.AuthenticatedUser>>.internal(
  AuthenticatedUser.new,
  name: r'authenticatedUserProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$authenticatedUserHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AuthenticatedUser = AutoDisposeNotifier<Set<model.AuthenticatedUser>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
