import 'package:freezed_annotation/freezed_annotation.dart';

part 'audiobookshelf_server.freezed.dart';
part 'audiobookshelf_server.g.dart';

typedef AudiobookShelfUri = Uri;

/// Represents a audiobookshelf server
@freezed
class AudiobookShelfServer with _$AudiobookShelfServer {
  const factory AudiobookShelfServer({
    required AudiobookShelfUri serverUrl,
    // String? serverName,
  }) = _AudiobookShelfServer;

  factory AudiobookShelfServer.fromJson(Map<String, dynamic> json) =>
      _$AudiobookShelfServerFromJson(json);
}
