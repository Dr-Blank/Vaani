// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audiobookshelf_server.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AudiobookShelfServerImpl _$$AudiobookShelfServerImplFromJson(
        Map<String, dynamic> json) =>
    _$AudiobookShelfServerImpl(
      serverUrl: Uri.parse(json['serverUrl'] as String),
    );

Map<String, dynamic> _$$AudiobookShelfServerImplToJson(
        _$AudiobookShelfServerImpl instance) =>
    <String, dynamic>{
      'serverUrl': instance.serverUrl.toString(),
    };
