// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BookSettingsImpl _$$BookSettingsImplFromJson(Map<String, dynamic> json) =>
    _$BookSettingsImpl(
      bookId: json['bookId'] as String,
      playerSettings: json['playerSettings'] == null
          ? const NullablePlayerSettings()
          : NullablePlayerSettings.fromJson(
              json['playerSettings'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$BookSettingsImplToJson(_$BookSettingsImpl instance) =>
    <String, dynamic>{
      'bookId': instance.bookId,
      'playerSettings': instance.playerSettings,
    };
