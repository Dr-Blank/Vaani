// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'audiobookshelf_server.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AudiobookShelfServer _$AudiobookShelfServerFromJson(Map<String, dynamic> json) {
  return _AudiobookShelfServer.fromJson(json);
}

/// @nodoc
mixin _$AudiobookShelfServer {
  Uri get serverUrl => throw _privateConstructorUsedError;

  /// Serializes this AudiobookShelfServer to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AudiobookShelfServer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AudiobookShelfServerCopyWith<AudiobookShelfServer> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AudiobookShelfServerCopyWith<$Res> {
  factory $AudiobookShelfServerCopyWith(AudiobookShelfServer value,
          $Res Function(AudiobookShelfServer) then) =
      _$AudiobookShelfServerCopyWithImpl<$Res, AudiobookShelfServer>;
  @useResult
  $Res call({Uri serverUrl});
}

/// @nodoc
class _$AudiobookShelfServerCopyWithImpl<$Res,
        $Val extends AudiobookShelfServer>
    implements $AudiobookShelfServerCopyWith<$Res> {
  _$AudiobookShelfServerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AudiobookShelfServer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? serverUrl = null,
  }) {
    return _then(_value.copyWith(
      serverUrl: null == serverUrl
          ? _value.serverUrl
          : serverUrl // ignore: cast_nullable_to_non_nullable
              as Uri,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AudiobookShelfServerImplCopyWith<$Res>
    implements $AudiobookShelfServerCopyWith<$Res> {
  factory _$$AudiobookShelfServerImplCopyWith(_$AudiobookShelfServerImpl value,
          $Res Function(_$AudiobookShelfServerImpl) then) =
      __$$AudiobookShelfServerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Uri serverUrl});
}

/// @nodoc
class __$$AudiobookShelfServerImplCopyWithImpl<$Res>
    extends _$AudiobookShelfServerCopyWithImpl<$Res, _$AudiobookShelfServerImpl>
    implements _$$AudiobookShelfServerImplCopyWith<$Res> {
  __$$AudiobookShelfServerImplCopyWithImpl(_$AudiobookShelfServerImpl _value,
      $Res Function(_$AudiobookShelfServerImpl) _then)
      : super(_value, _then);

  /// Create a copy of AudiobookShelfServer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? serverUrl = null,
  }) {
    return _then(_$AudiobookShelfServerImpl(
      serverUrl: null == serverUrl
          ? _value.serverUrl
          : serverUrl // ignore: cast_nullable_to_non_nullable
              as Uri,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AudiobookShelfServerImpl implements _AudiobookShelfServer {
  const _$AudiobookShelfServerImpl({required this.serverUrl});

  factory _$AudiobookShelfServerImpl.fromJson(Map<String, dynamic> json) =>
      _$$AudiobookShelfServerImplFromJson(json);

  @override
  final Uri serverUrl;

  @override
  String toString() {
    return 'AudiobookShelfServer(serverUrl: $serverUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AudiobookShelfServerImpl &&
            (identical(other.serverUrl, serverUrl) ||
                other.serverUrl == serverUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, serverUrl);

  /// Create a copy of AudiobookShelfServer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AudiobookShelfServerImplCopyWith<_$AudiobookShelfServerImpl>
      get copyWith =>
          __$$AudiobookShelfServerImplCopyWithImpl<_$AudiobookShelfServerImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AudiobookShelfServerImplToJson(
      this,
    );
  }
}

abstract class _AudiobookShelfServer implements AudiobookShelfServer {
  const factory _AudiobookShelfServer({required final Uri serverUrl}) =
      _$AudiobookShelfServerImpl;

  factory _AudiobookShelfServer.fromJson(Map<String, dynamic> json) =
      _$AudiobookShelfServerImpl.fromJson;

  @override
  Uri get serverUrl;

  /// Create a copy of AudiobookShelfServer
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AudiobookShelfServerImplCopyWith<_$AudiobookShelfServerImpl>
      get copyWith => throw _privateConstructorUsedError;
}
