// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'flow.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Flow {
  Uri get serverUri => throw _privateConstructorUsedError;
  String get state => throw _privateConstructorUsedError;
  String get verifier => throw _privateConstructorUsedError;
  Cookie get cookie => throw _privateConstructorUsedError;
  bool get isFlowComplete => throw _privateConstructorUsedError;
  String? get authToken => throw _privateConstructorUsedError;

  /// Create a copy of Flow
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FlowCopyWith<Flow> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FlowCopyWith<$Res> {
  factory $FlowCopyWith(Flow value, $Res Function(Flow) then) =
      _$FlowCopyWithImpl<$Res, Flow>;
  @useResult
  $Res call(
      {Uri serverUri,
      String state,
      String verifier,
      Cookie cookie,
      bool isFlowComplete,
      String? authToken});
}

/// @nodoc
class _$FlowCopyWithImpl<$Res, $Val extends Flow>
    implements $FlowCopyWith<$Res> {
  _$FlowCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Flow
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? serverUri = null,
    Object? state = null,
    Object? verifier = null,
    Object? cookie = null,
    Object? isFlowComplete = null,
    Object? authToken = freezed,
  }) {
    return _then(_value.copyWith(
      serverUri: null == serverUri
          ? _value.serverUri
          : serverUri // ignore: cast_nullable_to_non_nullable
              as Uri,
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String,
      verifier: null == verifier
          ? _value.verifier
          : verifier // ignore: cast_nullable_to_non_nullable
              as String,
      cookie: null == cookie
          ? _value.cookie
          : cookie // ignore: cast_nullable_to_non_nullable
              as Cookie,
      isFlowComplete: null == isFlowComplete
          ? _value.isFlowComplete
          : isFlowComplete // ignore: cast_nullable_to_non_nullable
              as bool,
      authToken: freezed == authToken
          ? _value.authToken
          : authToken // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FlowImplCopyWith<$Res> implements $FlowCopyWith<$Res> {
  factory _$$FlowImplCopyWith(
          _$FlowImpl value, $Res Function(_$FlowImpl) then) =
      __$$FlowImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Uri serverUri,
      String state,
      String verifier,
      Cookie cookie,
      bool isFlowComplete,
      String? authToken});
}

/// @nodoc
class __$$FlowImplCopyWithImpl<$Res>
    extends _$FlowCopyWithImpl<$Res, _$FlowImpl>
    implements _$$FlowImplCopyWith<$Res> {
  __$$FlowImplCopyWithImpl(_$FlowImpl _value, $Res Function(_$FlowImpl) _then)
      : super(_value, _then);

  /// Create a copy of Flow
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? serverUri = null,
    Object? state = null,
    Object? verifier = null,
    Object? cookie = null,
    Object? isFlowComplete = null,
    Object? authToken = freezed,
  }) {
    return _then(_$FlowImpl(
      serverUri: null == serverUri
          ? _value.serverUri
          : serverUri // ignore: cast_nullable_to_non_nullable
              as Uri,
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String,
      verifier: null == verifier
          ? _value.verifier
          : verifier // ignore: cast_nullable_to_non_nullable
              as String,
      cookie: null == cookie
          ? _value.cookie
          : cookie // ignore: cast_nullable_to_non_nullable
              as Cookie,
      isFlowComplete: null == isFlowComplete
          ? _value.isFlowComplete
          : isFlowComplete // ignore: cast_nullable_to_non_nullable
              as bool,
      authToken: freezed == authToken
          ? _value.authToken
          : authToken // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$FlowImpl implements _Flow {
  const _$FlowImpl(
      {required this.serverUri,
      required this.state,
      required this.verifier,
      required this.cookie,
      this.isFlowComplete = false,
      this.authToken});

  @override
  final Uri serverUri;
  @override
  final String state;
  @override
  final String verifier;
  @override
  final Cookie cookie;
  @override
  @JsonKey()
  final bool isFlowComplete;
  @override
  final String? authToken;

  @override
  String toString() {
    return 'Flow(serverUri: $serverUri, state: $state, verifier: $verifier, cookie: $cookie, isFlowComplete: $isFlowComplete, authToken: $authToken)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FlowImpl &&
            (identical(other.serverUri, serverUri) ||
                other.serverUri == serverUri) &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.verifier, verifier) ||
                other.verifier == verifier) &&
            (identical(other.cookie, cookie) || other.cookie == cookie) &&
            (identical(other.isFlowComplete, isFlowComplete) ||
                other.isFlowComplete == isFlowComplete) &&
            (identical(other.authToken, authToken) ||
                other.authToken == authToken));
  }

  @override
  int get hashCode => Object.hash(runtimeType, serverUri, state, verifier,
      cookie, isFlowComplete, authToken);

  /// Create a copy of Flow
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FlowImplCopyWith<_$FlowImpl> get copyWith =>
      __$$FlowImplCopyWithImpl<_$FlowImpl>(this, _$identity);
}

abstract class _Flow implements Flow {
  const factory _Flow(
      {required final Uri serverUri,
      required final String state,
      required final String verifier,
      required final Cookie cookie,
      final bool isFlowComplete,
      final String? authToken}) = _$FlowImpl;

  @override
  Uri get serverUri;
  @override
  String get state;
  @override
  String get verifier;
  @override
  Cookie get cookie;
  @override
  bool get isFlowComplete;
  @override
  String? get authToken;

  /// Create a copy of Flow
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FlowImplCopyWith<_$FlowImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
