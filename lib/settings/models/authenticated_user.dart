import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vaani/settings/models/audiobookshelf_server.dart';

part 'authenticated_user.freezed.dart';
part 'authenticated_user.g.dart';

/// authenticated user with server and credentials
@freezed
class AuthenticatedUser with _$AuthenticatedUser {
  const factory AuthenticatedUser({
    required AudiobookShelfServer server,
    required String authToken,
    String? id,
    String? username,
    String? password,
  }) = _AuthenticatedUser;

  factory AuthenticatedUser.fromJson(Map<String, dynamic> json) =>
      _$AuthenticatedUserFromJson(json);
}
