// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'nullable_player_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

NullablePlayerSettings _$NullablePlayerSettingsFromJson(
    Map<String, dynamic> json) {
  return _NullablePlayerSettings.fromJson(json);
}

/// @nodoc
mixin _$NullablePlayerSettings {
  MinimizedPlayerSettings? get miniPlayerSettings =>
      throw _privateConstructorUsedError;
  ExpandedPlayerSettings? get expandedPlayerSettings =>
      throw _privateConstructorUsedError;
  double? get preferredDefaultVolume => throw _privateConstructorUsedError;
  double? get preferredDefaultSpeed => throw _privateConstructorUsedError;
  List<double>? get speedOptions => throw _privateConstructorUsedError;
  SleepTimerSettings? get sleepTimerSettings =>
      throw _privateConstructorUsedError;
  Duration? get playbackReportInterval => throw _privateConstructorUsedError;

  /// Serializes this NullablePlayerSettings to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NullablePlayerSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NullablePlayerSettingsCopyWith<NullablePlayerSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NullablePlayerSettingsCopyWith<$Res> {
  factory $NullablePlayerSettingsCopyWith(NullablePlayerSettings value,
          $Res Function(NullablePlayerSettings) then) =
      _$NullablePlayerSettingsCopyWithImpl<$Res, NullablePlayerSettings>;
  @useResult
  $Res call(
      {MinimizedPlayerSettings? miniPlayerSettings,
      ExpandedPlayerSettings? expandedPlayerSettings,
      double? preferredDefaultVolume,
      double? preferredDefaultSpeed,
      List<double>? speedOptions,
      SleepTimerSettings? sleepTimerSettings,
      Duration? playbackReportInterval});

  $MinimizedPlayerSettingsCopyWith<$Res>? get miniPlayerSettings;
  $ExpandedPlayerSettingsCopyWith<$Res>? get expandedPlayerSettings;
  $SleepTimerSettingsCopyWith<$Res>? get sleepTimerSettings;
}

/// @nodoc
class _$NullablePlayerSettingsCopyWithImpl<$Res,
        $Val extends NullablePlayerSettings>
    implements $NullablePlayerSettingsCopyWith<$Res> {
  _$NullablePlayerSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NullablePlayerSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? miniPlayerSettings = freezed,
    Object? expandedPlayerSettings = freezed,
    Object? preferredDefaultVolume = freezed,
    Object? preferredDefaultSpeed = freezed,
    Object? speedOptions = freezed,
    Object? sleepTimerSettings = freezed,
    Object? playbackReportInterval = freezed,
  }) {
    return _then(_value.copyWith(
      miniPlayerSettings: freezed == miniPlayerSettings
          ? _value.miniPlayerSettings
          : miniPlayerSettings // ignore: cast_nullable_to_non_nullable
              as MinimizedPlayerSettings?,
      expandedPlayerSettings: freezed == expandedPlayerSettings
          ? _value.expandedPlayerSettings
          : expandedPlayerSettings // ignore: cast_nullable_to_non_nullable
              as ExpandedPlayerSettings?,
      preferredDefaultVolume: freezed == preferredDefaultVolume
          ? _value.preferredDefaultVolume
          : preferredDefaultVolume // ignore: cast_nullable_to_non_nullable
              as double?,
      preferredDefaultSpeed: freezed == preferredDefaultSpeed
          ? _value.preferredDefaultSpeed
          : preferredDefaultSpeed // ignore: cast_nullable_to_non_nullable
              as double?,
      speedOptions: freezed == speedOptions
          ? _value.speedOptions
          : speedOptions // ignore: cast_nullable_to_non_nullable
              as List<double>?,
      sleepTimerSettings: freezed == sleepTimerSettings
          ? _value.sleepTimerSettings
          : sleepTimerSettings // ignore: cast_nullable_to_non_nullable
              as SleepTimerSettings?,
      playbackReportInterval: freezed == playbackReportInterval
          ? _value.playbackReportInterval
          : playbackReportInterval // ignore: cast_nullable_to_non_nullable
              as Duration?,
    ) as $Val);
  }

  /// Create a copy of NullablePlayerSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MinimizedPlayerSettingsCopyWith<$Res>? get miniPlayerSettings {
    if (_value.miniPlayerSettings == null) {
      return null;
    }

    return $MinimizedPlayerSettingsCopyWith<$Res>(_value.miniPlayerSettings!,
        (value) {
      return _then(_value.copyWith(miniPlayerSettings: value) as $Val);
    });
  }

  /// Create a copy of NullablePlayerSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ExpandedPlayerSettingsCopyWith<$Res>? get expandedPlayerSettings {
    if (_value.expandedPlayerSettings == null) {
      return null;
    }

    return $ExpandedPlayerSettingsCopyWith<$Res>(_value.expandedPlayerSettings!,
        (value) {
      return _then(_value.copyWith(expandedPlayerSettings: value) as $Val);
    });
  }

  /// Create a copy of NullablePlayerSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SleepTimerSettingsCopyWith<$Res>? get sleepTimerSettings {
    if (_value.sleepTimerSettings == null) {
      return null;
    }

    return $SleepTimerSettingsCopyWith<$Res>(_value.sleepTimerSettings!,
        (value) {
      return _then(_value.copyWith(sleepTimerSettings: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$NullablePlayerSettingsImplCopyWith<$Res>
    implements $NullablePlayerSettingsCopyWith<$Res> {
  factory _$$NullablePlayerSettingsImplCopyWith(
          _$NullablePlayerSettingsImpl value,
          $Res Function(_$NullablePlayerSettingsImpl) then) =
      __$$NullablePlayerSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {MinimizedPlayerSettings? miniPlayerSettings,
      ExpandedPlayerSettings? expandedPlayerSettings,
      double? preferredDefaultVolume,
      double? preferredDefaultSpeed,
      List<double>? speedOptions,
      SleepTimerSettings? sleepTimerSettings,
      Duration? playbackReportInterval});

  @override
  $MinimizedPlayerSettingsCopyWith<$Res>? get miniPlayerSettings;
  @override
  $ExpandedPlayerSettingsCopyWith<$Res>? get expandedPlayerSettings;
  @override
  $SleepTimerSettingsCopyWith<$Res>? get sleepTimerSettings;
}

/// @nodoc
class __$$NullablePlayerSettingsImplCopyWithImpl<$Res>
    extends _$NullablePlayerSettingsCopyWithImpl<$Res,
        _$NullablePlayerSettingsImpl>
    implements _$$NullablePlayerSettingsImplCopyWith<$Res> {
  __$$NullablePlayerSettingsImplCopyWithImpl(
      _$NullablePlayerSettingsImpl _value,
      $Res Function(_$NullablePlayerSettingsImpl) _then)
      : super(_value, _then);

  /// Create a copy of NullablePlayerSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? miniPlayerSettings = freezed,
    Object? expandedPlayerSettings = freezed,
    Object? preferredDefaultVolume = freezed,
    Object? preferredDefaultSpeed = freezed,
    Object? speedOptions = freezed,
    Object? sleepTimerSettings = freezed,
    Object? playbackReportInterval = freezed,
  }) {
    return _then(_$NullablePlayerSettingsImpl(
      miniPlayerSettings: freezed == miniPlayerSettings
          ? _value.miniPlayerSettings
          : miniPlayerSettings // ignore: cast_nullable_to_non_nullable
              as MinimizedPlayerSettings?,
      expandedPlayerSettings: freezed == expandedPlayerSettings
          ? _value.expandedPlayerSettings
          : expandedPlayerSettings // ignore: cast_nullable_to_non_nullable
              as ExpandedPlayerSettings?,
      preferredDefaultVolume: freezed == preferredDefaultVolume
          ? _value.preferredDefaultVolume
          : preferredDefaultVolume // ignore: cast_nullable_to_non_nullable
              as double?,
      preferredDefaultSpeed: freezed == preferredDefaultSpeed
          ? _value.preferredDefaultSpeed
          : preferredDefaultSpeed // ignore: cast_nullable_to_non_nullable
              as double?,
      speedOptions: freezed == speedOptions
          ? _value._speedOptions
          : speedOptions // ignore: cast_nullable_to_non_nullable
              as List<double>?,
      sleepTimerSettings: freezed == sleepTimerSettings
          ? _value.sleepTimerSettings
          : sleepTimerSettings // ignore: cast_nullable_to_non_nullable
              as SleepTimerSettings?,
      playbackReportInterval: freezed == playbackReportInterval
          ? _value.playbackReportInterval
          : playbackReportInterval // ignore: cast_nullable_to_non_nullable
              as Duration?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NullablePlayerSettingsImpl implements _NullablePlayerSettings {
  const _$NullablePlayerSettingsImpl(
      {this.miniPlayerSettings,
      this.expandedPlayerSettings,
      this.preferredDefaultVolume,
      this.preferredDefaultSpeed,
      final List<double>? speedOptions,
      this.sleepTimerSettings,
      this.playbackReportInterval})
      : _speedOptions = speedOptions;

  factory _$NullablePlayerSettingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$NullablePlayerSettingsImplFromJson(json);

  @override
  final MinimizedPlayerSettings? miniPlayerSettings;
  @override
  final ExpandedPlayerSettings? expandedPlayerSettings;
  @override
  final double? preferredDefaultVolume;
  @override
  final double? preferredDefaultSpeed;
  final List<double>? _speedOptions;
  @override
  List<double>? get speedOptions {
    final value = _speedOptions;
    if (value == null) return null;
    if (_speedOptions is EqualUnmodifiableListView) return _speedOptions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final SleepTimerSettings? sleepTimerSettings;
  @override
  final Duration? playbackReportInterval;

  @override
  String toString() {
    return 'NullablePlayerSettings(miniPlayerSettings: $miniPlayerSettings, expandedPlayerSettings: $expandedPlayerSettings, preferredDefaultVolume: $preferredDefaultVolume, preferredDefaultSpeed: $preferredDefaultSpeed, speedOptions: $speedOptions, sleepTimerSettings: $sleepTimerSettings, playbackReportInterval: $playbackReportInterval)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NullablePlayerSettingsImpl &&
            (identical(other.miniPlayerSettings, miniPlayerSettings) ||
                other.miniPlayerSettings == miniPlayerSettings) &&
            (identical(other.expandedPlayerSettings, expandedPlayerSettings) ||
                other.expandedPlayerSettings == expandedPlayerSettings) &&
            (identical(other.preferredDefaultVolume, preferredDefaultVolume) ||
                other.preferredDefaultVolume == preferredDefaultVolume) &&
            (identical(other.preferredDefaultSpeed, preferredDefaultSpeed) ||
                other.preferredDefaultSpeed == preferredDefaultSpeed) &&
            const DeepCollectionEquality()
                .equals(other._speedOptions, _speedOptions) &&
            (identical(other.sleepTimerSettings, sleepTimerSettings) ||
                other.sleepTimerSettings == sleepTimerSettings) &&
            (identical(other.playbackReportInterval, playbackReportInterval) ||
                other.playbackReportInterval == playbackReportInterval));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      miniPlayerSettings,
      expandedPlayerSettings,
      preferredDefaultVolume,
      preferredDefaultSpeed,
      const DeepCollectionEquality().hash(_speedOptions),
      sleepTimerSettings,
      playbackReportInterval);

  /// Create a copy of NullablePlayerSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NullablePlayerSettingsImplCopyWith<_$NullablePlayerSettingsImpl>
      get copyWith => __$$NullablePlayerSettingsImplCopyWithImpl<
          _$NullablePlayerSettingsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NullablePlayerSettingsImplToJson(
      this,
    );
  }
}

abstract class _NullablePlayerSettings implements NullablePlayerSettings {
  const factory _NullablePlayerSettings(
      {final MinimizedPlayerSettings? miniPlayerSettings,
      final ExpandedPlayerSettings? expandedPlayerSettings,
      final double? preferredDefaultVolume,
      final double? preferredDefaultSpeed,
      final List<double>? speedOptions,
      final SleepTimerSettings? sleepTimerSettings,
      final Duration? playbackReportInterval}) = _$NullablePlayerSettingsImpl;

  factory _NullablePlayerSettings.fromJson(Map<String, dynamic> json) =
      _$NullablePlayerSettingsImpl.fromJson;

  @override
  MinimizedPlayerSettings? get miniPlayerSettings;
  @override
  ExpandedPlayerSettings? get expandedPlayerSettings;
  @override
  double? get preferredDefaultVolume;
  @override
  double? get preferredDefaultSpeed;
  @override
  List<double>? get speedOptions;
  @override
  SleepTimerSettings? get sleepTimerSettings;
  @override
  Duration? get playbackReportInterval;

  /// Create a copy of NullablePlayerSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NullablePlayerSettingsImplCopyWith<_$NullablePlayerSettingsImpl>
      get copyWith => throw _privateConstructorUsedError;
}
