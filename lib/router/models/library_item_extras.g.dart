// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'library_item_extras.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LibraryItemExtrasImpl _$$LibraryItemExtrasImplFromJson(
        Map<String, dynamic> json) =>
    _$LibraryItemExtrasImpl(
      book: json['book'] == null
          ? null
          : BookMinified.fromJson(json['book'] as Map<String, dynamic>),
      heroTagSuffix: json['heroTagSuffix'] as String?,
    );

Map<String, dynamic> _$$LibraryItemExtrasImplToJson(
        _$LibraryItemExtrasImpl instance) =>
    <String, dynamic>{
      'book': instance.book,
      'heroTagSuffix': instance.heroTagSuffix,
    };
