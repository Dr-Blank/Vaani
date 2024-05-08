// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ApiSettingsImpl _$$ApiSettingsImplFromJson(Map<String, dynamic> json) =>
    _$ApiSettingsImpl(
      activeServer: json['activeServer'] == null
          ? null
          : AudiobookShelfServer.fromJson(
              json['activeServer'] as Map<String, dynamic>),
      activeUser: json['activeUser'] == null
          ? null
          : AuthenticatedUser.fromJson(
              json['activeUser'] as Map<String, dynamic>),
      activeLibraryId: json['activeLibraryId'] as String?,
    );

Map<String, dynamic> _$$ApiSettingsImplToJson(_$ApiSettingsImpl instance) =>
    <String, dynamic>{
      'activeServer': instance.activeServer,
      'activeUser': instance.activeUser,
      'activeLibraryId': instance.activeLibraryId,
    };
