// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'book_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BookSettings _$BookSettingsFromJson(Map<String, dynamic> json) {
  return _BookSettings.fromJson(json);
}

/// @nodoc
mixin _$BookSettings {
  String get bookId => throw _privateConstructorUsedError;
  NullablePlayerSettings get playerSettings =>
      throw _privateConstructorUsedError;

  /// Serializes this BookSettings to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BookSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BookSettingsCopyWith<BookSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookSettingsCopyWith<$Res> {
  factory $BookSettingsCopyWith(
          BookSettings value, $Res Function(BookSettings) then) =
      _$BookSettingsCopyWithImpl<$Res, BookSettings>;
  @useResult
  $Res call({String bookId, NullablePlayerSettings playerSettings});

  $NullablePlayerSettingsCopyWith<$Res> get playerSettings;
}

/// @nodoc
class _$BookSettingsCopyWithImpl<$Res, $Val extends BookSettings>
    implements $BookSettingsCopyWith<$Res> {
  _$BookSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BookSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bookId = null,
    Object? playerSettings = null,
  }) {
    return _then(_value.copyWith(
      bookId: null == bookId
          ? _value.bookId
          : bookId // ignore: cast_nullable_to_non_nullable
              as String,
      playerSettings: null == playerSettings
          ? _value.playerSettings
          : playerSettings // ignore: cast_nullable_to_non_nullable
              as NullablePlayerSettings,
    ) as $Val);
  }

  /// Create a copy of BookSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $NullablePlayerSettingsCopyWith<$Res> get playerSettings {
    return $NullablePlayerSettingsCopyWith<$Res>(_value.playerSettings,
        (value) {
      return _then(_value.copyWith(playerSettings: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$BookSettingsImplCopyWith<$Res>
    implements $BookSettingsCopyWith<$Res> {
  factory _$$BookSettingsImplCopyWith(
          _$BookSettingsImpl value, $Res Function(_$BookSettingsImpl) then) =
      __$$BookSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String bookId, NullablePlayerSettings playerSettings});

  @override
  $NullablePlayerSettingsCopyWith<$Res> get playerSettings;
}

/// @nodoc
class __$$BookSettingsImplCopyWithImpl<$Res>
    extends _$BookSettingsCopyWithImpl<$Res, _$BookSettingsImpl>
    implements _$$BookSettingsImplCopyWith<$Res> {
  __$$BookSettingsImplCopyWithImpl(
      _$BookSettingsImpl _value, $Res Function(_$BookSettingsImpl) _then)
      : super(_value, _then);

  /// Create a copy of BookSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bookId = null,
    Object? playerSettings = null,
  }) {
    return _then(_$BookSettingsImpl(
      bookId: null == bookId
          ? _value.bookId
          : bookId // ignore: cast_nullable_to_non_nullable
              as String,
      playerSettings: null == playerSettings
          ? _value.playerSettings
          : playerSettings // ignore: cast_nullable_to_non_nullable
              as NullablePlayerSettings,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BookSettingsImpl implements _BookSettings {
  const _$BookSettingsImpl(
      {required this.bookId,
      this.playerSettings = const NullablePlayerSettings()});

  factory _$BookSettingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$BookSettingsImplFromJson(json);

  @override
  final String bookId;
  @override
  @JsonKey()
  final NullablePlayerSettings playerSettings;

  @override
  String toString() {
    return 'BookSettings(bookId: $bookId, playerSettings: $playerSettings)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BookSettingsImpl &&
            (identical(other.bookId, bookId) || other.bookId == bookId) &&
            (identical(other.playerSettings, playerSettings) ||
                other.playerSettings == playerSettings));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, bookId, playerSettings);

  /// Create a copy of BookSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BookSettingsImplCopyWith<_$BookSettingsImpl> get copyWith =>
      __$$BookSettingsImplCopyWithImpl<_$BookSettingsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BookSettingsImplToJson(
      this,
    );
  }
}

abstract class _BookSettings implements BookSettings {
  const factory _BookSettings(
      {required final String bookId,
      final NullablePlayerSettings playerSettings}) = _$BookSettingsImpl;

  factory _BookSettings.fromJson(Map<String, dynamic> json) =
      _$BookSettingsImpl.fromJson;

  @override
  String get bookId;
  @override
  NullablePlayerSettings get playerSettings;

  /// Create a copy of BookSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BookSettingsImplCopyWith<_$BookSettingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
