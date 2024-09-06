// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'api_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ApiSettings _$ApiSettingsFromJson(Map<String, dynamic> json) {
  return _ApiSettings.fromJson(json);
}

/// @nodoc
mixin _$ApiSettings {
  AudiobookShelfServer? get activeServer => throw _privateConstructorUsedError;
  AuthenticatedUser? get activeUser => throw _privateConstructorUsedError;
  String? get activeLibraryId => throw _privateConstructorUsedError;

  /// Serializes this ApiSettings to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ApiSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ApiSettingsCopyWith<ApiSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApiSettingsCopyWith<$Res> {
  factory $ApiSettingsCopyWith(
          ApiSettings value, $Res Function(ApiSettings) then) =
      _$ApiSettingsCopyWithImpl<$Res, ApiSettings>;
  @useResult
  $Res call(
      {AudiobookShelfServer? activeServer,
      AuthenticatedUser? activeUser,
      String? activeLibraryId});

  $AudiobookShelfServerCopyWith<$Res>? get activeServer;
  $AuthenticatedUserCopyWith<$Res>? get activeUser;
}

/// @nodoc
class _$ApiSettingsCopyWithImpl<$Res, $Val extends ApiSettings>
    implements $ApiSettingsCopyWith<$Res> {
  _$ApiSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ApiSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? activeServer = freezed,
    Object? activeUser = freezed,
    Object? activeLibraryId = freezed,
  }) {
    return _then(_value.copyWith(
      activeServer: freezed == activeServer
          ? _value.activeServer
          : activeServer // ignore: cast_nullable_to_non_nullable
              as AudiobookShelfServer?,
      activeUser: freezed == activeUser
          ? _value.activeUser
          : activeUser // ignore: cast_nullable_to_non_nullable
              as AuthenticatedUser?,
      activeLibraryId: freezed == activeLibraryId
          ? _value.activeLibraryId
          : activeLibraryId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  /// Create a copy of ApiSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AudiobookShelfServerCopyWith<$Res>? get activeServer {
    if (_value.activeServer == null) {
      return null;
    }

    return $AudiobookShelfServerCopyWith<$Res>(_value.activeServer!, (value) {
      return _then(_value.copyWith(activeServer: value) as $Val);
    });
  }

  /// Create a copy of ApiSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AuthenticatedUserCopyWith<$Res>? get activeUser {
    if (_value.activeUser == null) {
      return null;
    }

    return $AuthenticatedUserCopyWith<$Res>(_value.activeUser!, (value) {
      return _then(_value.copyWith(activeUser: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ApiSettingsImplCopyWith<$Res>
    implements $ApiSettingsCopyWith<$Res> {
  factory _$$ApiSettingsImplCopyWith(
          _$ApiSettingsImpl value, $Res Function(_$ApiSettingsImpl) then) =
      __$$ApiSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {AudiobookShelfServer? activeServer,
      AuthenticatedUser? activeUser,
      String? activeLibraryId});

  @override
  $AudiobookShelfServerCopyWith<$Res>? get activeServer;
  @override
  $AuthenticatedUserCopyWith<$Res>? get activeUser;
}

/// @nodoc
class __$$ApiSettingsImplCopyWithImpl<$Res>
    extends _$ApiSettingsCopyWithImpl<$Res, _$ApiSettingsImpl>
    implements _$$ApiSettingsImplCopyWith<$Res> {
  __$$ApiSettingsImplCopyWithImpl(
      _$ApiSettingsImpl _value, $Res Function(_$ApiSettingsImpl) _then)
      : super(_value, _then);

  /// Create a copy of ApiSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? activeServer = freezed,
    Object? activeUser = freezed,
    Object? activeLibraryId = freezed,
  }) {
    return _then(_$ApiSettingsImpl(
      activeServer: freezed == activeServer
          ? _value.activeServer
          : activeServer // ignore: cast_nullable_to_non_nullable
              as AudiobookShelfServer?,
      activeUser: freezed == activeUser
          ? _value.activeUser
          : activeUser // ignore: cast_nullable_to_non_nullable
              as AuthenticatedUser?,
      activeLibraryId: freezed == activeLibraryId
          ? _value.activeLibraryId
          : activeLibraryId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ApiSettingsImpl implements _ApiSettings {
  const _$ApiSettingsImpl(
      {this.activeServer, this.activeUser, this.activeLibraryId});

  factory _$ApiSettingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$ApiSettingsImplFromJson(json);

  @override
  final AudiobookShelfServer? activeServer;
  @override
  final AuthenticatedUser? activeUser;
  @override
  final String? activeLibraryId;

  @override
  String toString() {
    return 'ApiSettings(activeServer: $activeServer, activeUser: $activeUser, activeLibraryId: $activeLibraryId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApiSettingsImpl &&
            (identical(other.activeServer, activeServer) ||
                other.activeServer == activeServer) &&
            (identical(other.activeUser, activeUser) ||
                other.activeUser == activeUser) &&
            (identical(other.activeLibraryId, activeLibraryId) ||
                other.activeLibraryId == activeLibraryId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, activeServer, activeUser, activeLibraryId);

  /// Create a copy of ApiSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ApiSettingsImplCopyWith<_$ApiSettingsImpl> get copyWith =>
      __$$ApiSettingsImplCopyWithImpl<_$ApiSettingsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ApiSettingsImplToJson(
      this,
    );
  }
}

abstract class _ApiSettings implements ApiSettings {
  const factory _ApiSettings(
      {final AudiobookShelfServer? activeServer,
      final AuthenticatedUser? activeUser,
      final String? activeLibraryId}) = _$ApiSettingsImpl;

  factory _ApiSettings.fromJson(Map<String, dynamic> json) =
      _$ApiSettingsImpl.fromJson;

  @override
  AudiobookShelfServer? get activeServer;
  @override
  AuthenticatedUser? get activeUser;
  @override
  String? get activeLibraryId;

  /// Create a copy of ApiSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ApiSettingsImplCopyWith<_$ApiSettingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
