// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authenticated_users_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$authenticatedUsersHash() =>
    r'5fdd472f62fc3b73ff8417cdce9f02e86c33d00f';

/// provides with a set of authenticated users
///
/// Copied from [AuthenticatedUsers].
@ProviderFor(AuthenticatedUsers)
final authenticatedUsersProvider = AutoDisposeNotifierProvider<
    AuthenticatedUsers, Set<model.AuthenticatedUser>>.internal(
  AuthenticatedUsers.new,
  name: r'authenticatedUsersProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$authenticatedUsersHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AuthenticatedUsers
    = AutoDisposeNotifier<Set<model.AuthenticatedUser>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
