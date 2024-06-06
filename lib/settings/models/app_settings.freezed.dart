// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AppSettings _$AppSettingsFromJson(Map<String, dynamic> json) {
  return _AppSettings.fromJson(json);
}

/// @nodoc
mixin _$AppSettings {
  bool get isDarkMode => throw _privateConstructorUsedError;
  bool get useMaterialThemeOnItemPage => throw _privateConstructorUsedError;
  PlayerSettings get playerSettings => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AppSettingsCopyWith<AppSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppSettingsCopyWith<$Res> {
  factory $AppSettingsCopyWith(
          AppSettings value, $Res Function(AppSettings) then) =
      _$AppSettingsCopyWithImpl<$Res, AppSettings>;
  @useResult
  $Res call(
      {bool isDarkMode,
      bool useMaterialThemeOnItemPage,
      PlayerSettings playerSettings});

  $PlayerSettingsCopyWith<$Res> get playerSettings;
}

/// @nodoc
class _$AppSettingsCopyWithImpl<$Res, $Val extends AppSettings>
    implements $AppSettingsCopyWith<$Res> {
  _$AppSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isDarkMode = null,
    Object? useMaterialThemeOnItemPage = null,
    Object? playerSettings = null,
  }) {
    return _then(_value.copyWith(
      isDarkMode: null == isDarkMode
          ? _value.isDarkMode
          : isDarkMode // ignore: cast_nullable_to_non_nullable
              as bool,
      useMaterialThemeOnItemPage: null == useMaterialThemeOnItemPage
          ? _value.useMaterialThemeOnItemPage
          : useMaterialThemeOnItemPage // ignore: cast_nullable_to_non_nullable
              as bool,
      playerSettings: null == playerSettings
          ? _value.playerSettings
          : playerSettings // ignore: cast_nullable_to_non_nullable
              as PlayerSettings,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PlayerSettingsCopyWith<$Res> get playerSettings {
    return $PlayerSettingsCopyWith<$Res>(_value.playerSettings, (value) {
      return _then(_value.copyWith(playerSettings: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AppSettingsImplCopyWith<$Res>
    implements $AppSettingsCopyWith<$Res> {
  factory _$$AppSettingsImplCopyWith(
          _$AppSettingsImpl value, $Res Function(_$AppSettingsImpl) then) =
      __$$AppSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isDarkMode,
      bool useMaterialThemeOnItemPage,
      PlayerSettings playerSettings});

  @override
  $PlayerSettingsCopyWith<$Res> get playerSettings;
}

/// @nodoc
class __$$AppSettingsImplCopyWithImpl<$Res>
    extends _$AppSettingsCopyWithImpl<$Res, _$AppSettingsImpl>
    implements _$$AppSettingsImplCopyWith<$Res> {
  __$$AppSettingsImplCopyWithImpl(
      _$AppSettingsImpl _value, $Res Function(_$AppSettingsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isDarkMode = null,
    Object? useMaterialThemeOnItemPage = null,
    Object? playerSettings = null,
  }) {
    return _then(_$AppSettingsImpl(
      isDarkMode: null == isDarkMode
          ? _value.isDarkMode
          : isDarkMode // ignore: cast_nullable_to_non_nullable
              as bool,
      useMaterialThemeOnItemPage: null == useMaterialThemeOnItemPage
          ? _value.useMaterialThemeOnItemPage
          : useMaterialThemeOnItemPage // ignore: cast_nullable_to_non_nullable
              as bool,
      playerSettings: null == playerSettings
          ? _value.playerSettings
          : playerSettings // ignore: cast_nullable_to_non_nullable
              as PlayerSettings,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AppSettingsImpl implements _AppSettings {
  const _$AppSettingsImpl(
      {this.isDarkMode = true,
      this.useMaterialThemeOnItemPage = false,
      this.playerSettings = const PlayerSettings()});

  factory _$AppSettingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppSettingsImplFromJson(json);

  @override
  @JsonKey()
  final bool isDarkMode;
  @override
  @JsonKey()
  final bool useMaterialThemeOnItemPage;
  @override
  @JsonKey()
  final PlayerSettings playerSettings;

  @override
  String toString() {
    return 'AppSettings(isDarkMode: $isDarkMode, useMaterialThemeOnItemPage: $useMaterialThemeOnItemPage, playerSettings: $playerSettings)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppSettingsImpl &&
            (identical(other.isDarkMode, isDarkMode) ||
                other.isDarkMode == isDarkMode) &&
            (identical(other.useMaterialThemeOnItemPage,
                    useMaterialThemeOnItemPage) ||
                other.useMaterialThemeOnItemPage ==
                    useMaterialThemeOnItemPage) &&
            (identical(other.playerSettings, playerSettings) ||
                other.playerSettings == playerSettings));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, isDarkMode, useMaterialThemeOnItemPage, playerSettings);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AppSettingsImplCopyWith<_$AppSettingsImpl> get copyWith =>
      __$$AppSettingsImplCopyWithImpl<_$AppSettingsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AppSettingsImplToJson(
      this,
    );
  }
}

abstract class _AppSettings implements AppSettings {
  const factory _AppSettings(
      {final bool isDarkMode,
      final bool useMaterialThemeOnItemPage,
      final PlayerSettings playerSettings}) = _$AppSettingsImpl;

  factory _AppSettings.fromJson(Map<String, dynamic> json) =
      _$AppSettingsImpl.fromJson;

  @override
  bool get isDarkMode;
  @override
  bool get useMaterialThemeOnItemPage;
  @override
  PlayerSettings get playerSettings;
  @override
  @JsonKey(ignore: true)
  _$$AppSettingsImplCopyWith<_$AppSettingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PlayerSettings _$PlayerSettingsFromJson(Map<String, dynamic> json) {
  return _PlayerSettings.fromJson(json);
}

/// @nodoc
mixin _$PlayerSettings {
  MinimizedPlayerSettings get miniPlayerSettings =>
      throw _privateConstructorUsedError;
  ExpandedPlayerSettings get expandedPlayerSettings =>
      throw _privateConstructorUsedError;
  double get preferredDefaultVolume => throw _privateConstructorUsedError;
  double get preferredDefaultSpeed => throw _privateConstructorUsedError;
  List<double> get speedOptions => throw _privateConstructorUsedError;
  SleepTimerSettings get sleepTimerSettings =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PlayerSettingsCopyWith<PlayerSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlayerSettingsCopyWith<$Res> {
  factory $PlayerSettingsCopyWith(
          PlayerSettings value, $Res Function(PlayerSettings) then) =
      _$PlayerSettingsCopyWithImpl<$Res, PlayerSettings>;
  @useResult
  $Res call(
      {MinimizedPlayerSettings miniPlayerSettings,
      ExpandedPlayerSettings expandedPlayerSettings,
      double preferredDefaultVolume,
      double preferredDefaultSpeed,
      List<double> speedOptions,
      SleepTimerSettings sleepTimerSettings});

  $MinimizedPlayerSettingsCopyWith<$Res> get miniPlayerSettings;
  $ExpandedPlayerSettingsCopyWith<$Res> get expandedPlayerSettings;
  $SleepTimerSettingsCopyWith<$Res> get sleepTimerSettings;
}

/// @nodoc
class _$PlayerSettingsCopyWithImpl<$Res, $Val extends PlayerSettings>
    implements $PlayerSettingsCopyWith<$Res> {
  _$PlayerSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? miniPlayerSettings = null,
    Object? expandedPlayerSettings = null,
    Object? preferredDefaultVolume = null,
    Object? preferredDefaultSpeed = null,
    Object? speedOptions = null,
    Object? sleepTimerSettings = null,
  }) {
    return _then(_value.copyWith(
      miniPlayerSettings: null == miniPlayerSettings
          ? _value.miniPlayerSettings
          : miniPlayerSettings // ignore: cast_nullable_to_non_nullable
              as MinimizedPlayerSettings,
      expandedPlayerSettings: null == expandedPlayerSettings
          ? _value.expandedPlayerSettings
          : expandedPlayerSettings // ignore: cast_nullable_to_non_nullable
              as ExpandedPlayerSettings,
      preferredDefaultVolume: null == preferredDefaultVolume
          ? _value.preferredDefaultVolume
          : preferredDefaultVolume // ignore: cast_nullable_to_non_nullable
              as double,
      preferredDefaultSpeed: null == preferredDefaultSpeed
          ? _value.preferredDefaultSpeed
          : preferredDefaultSpeed // ignore: cast_nullable_to_non_nullable
              as double,
      speedOptions: null == speedOptions
          ? _value.speedOptions
          : speedOptions // ignore: cast_nullable_to_non_nullable
              as List<double>,
      sleepTimerSettings: null == sleepTimerSettings
          ? _value.sleepTimerSettings
          : sleepTimerSettings // ignore: cast_nullable_to_non_nullable
              as SleepTimerSettings,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $MinimizedPlayerSettingsCopyWith<$Res> get miniPlayerSettings {
    return $MinimizedPlayerSettingsCopyWith<$Res>(_value.miniPlayerSettings,
        (value) {
      return _then(_value.copyWith(miniPlayerSettings: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ExpandedPlayerSettingsCopyWith<$Res> get expandedPlayerSettings {
    return $ExpandedPlayerSettingsCopyWith<$Res>(_value.expandedPlayerSettings,
        (value) {
      return _then(_value.copyWith(expandedPlayerSettings: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $SleepTimerSettingsCopyWith<$Res> get sleepTimerSettings {
    return $SleepTimerSettingsCopyWith<$Res>(_value.sleepTimerSettings,
        (value) {
      return _then(_value.copyWith(sleepTimerSettings: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PlayerSettingsImplCopyWith<$Res>
    implements $PlayerSettingsCopyWith<$Res> {
  factory _$$PlayerSettingsImplCopyWith(_$PlayerSettingsImpl value,
          $Res Function(_$PlayerSettingsImpl) then) =
      __$$PlayerSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {MinimizedPlayerSettings miniPlayerSettings,
      ExpandedPlayerSettings expandedPlayerSettings,
      double preferredDefaultVolume,
      double preferredDefaultSpeed,
      List<double> speedOptions,
      SleepTimerSettings sleepTimerSettings});

  @override
  $MinimizedPlayerSettingsCopyWith<$Res> get miniPlayerSettings;
  @override
  $ExpandedPlayerSettingsCopyWith<$Res> get expandedPlayerSettings;
  @override
  $SleepTimerSettingsCopyWith<$Res> get sleepTimerSettings;
}

/// @nodoc
class __$$PlayerSettingsImplCopyWithImpl<$Res>
    extends _$PlayerSettingsCopyWithImpl<$Res, _$PlayerSettingsImpl>
    implements _$$PlayerSettingsImplCopyWith<$Res> {
  __$$PlayerSettingsImplCopyWithImpl(
      _$PlayerSettingsImpl _value, $Res Function(_$PlayerSettingsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? miniPlayerSettings = null,
    Object? expandedPlayerSettings = null,
    Object? preferredDefaultVolume = null,
    Object? preferredDefaultSpeed = null,
    Object? speedOptions = null,
    Object? sleepTimerSettings = null,
  }) {
    return _then(_$PlayerSettingsImpl(
      miniPlayerSettings: null == miniPlayerSettings
          ? _value.miniPlayerSettings
          : miniPlayerSettings // ignore: cast_nullable_to_non_nullable
              as MinimizedPlayerSettings,
      expandedPlayerSettings: null == expandedPlayerSettings
          ? _value.expandedPlayerSettings
          : expandedPlayerSettings // ignore: cast_nullable_to_non_nullable
              as ExpandedPlayerSettings,
      preferredDefaultVolume: null == preferredDefaultVolume
          ? _value.preferredDefaultVolume
          : preferredDefaultVolume // ignore: cast_nullable_to_non_nullable
              as double,
      preferredDefaultSpeed: null == preferredDefaultSpeed
          ? _value.preferredDefaultSpeed
          : preferredDefaultSpeed // ignore: cast_nullable_to_non_nullable
              as double,
      speedOptions: null == speedOptions
          ? _value._speedOptions
          : speedOptions // ignore: cast_nullable_to_non_nullable
              as List<double>,
      sleepTimerSettings: null == sleepTimerSettings
          ? _value.sleepTimerSettings
          : sleepTimerSettings // ignore: cast_nullable_to_non_nullable
              as SleepTimerSettings,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PlayerSettingsImpl implements _PlayerSettings {
  const _$PlayerSettingsImpl(
      {this.miniPlayerSettings = const MinimizedPlayerSettings(),
      this.expandedPlayerSettings = const ExpandedPlayerSettings(),
      this.preferredDefaultVolume = 1,
      this.preferredDefaultSpeed = 1,
      final List<double> speedOptions = const [0.75, 1, 1.25, 1.5, 1.75, 2],
      this.sleepTimerSettings = const SleepTimerSettings()})
      : _speedOptions = speedOptions;

  factory _$PlayerSettingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$PlayerSettingsImplFromJson(json);

  @override
  @JsonKey()
  final MinimizedPlayerSettings miniPlayerSettings;
  @override
  @JsonKey()
  final ExpandedPlayerSettings expandedPlayerSettings;
  @override
  @JsonKey()
  final double preferredDefaultVolume;
  @override
  @JsonKey()
  final double preferredDefaultSpeed;
  final List<double> _speedOptions;
  @override
  @JsonKey()
  List<double> get speedOptions {
    if (_speedOptions is EqualUnmodifiableListView) return _speedOptions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_speedOptions);
  }

  @override
  @JsonKey()
  final SleepTimerSettings sleepTimerSettings;

  @override
  String toString() {
    return 'PlayerSettings(miniPlayerSettings: $miniPlayerSettings, expandedPlayerSettings: $expandedPlayerSettings, preferredDefaultVolume: $preferredDefaultVolume, preferredDefaultSpeed: $preferredDefaultSpeed, speedOptions: $speedOptions, sleepTimerSettings: $sleepTimerSettings)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlayerSettingsImpl &&
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
                other.sleepTimerSettings == sleepTimerSettings));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      miniPlayerSettings,
      expandedPlayerSettings,
      preferredDefaultVolume,
      preferredDefaultSpeed,
      const DeepCollectionEquality().hash(_speedOptions),
      sleepTimerSettings);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PlayerSettingsImplCopyWith<_$PlayerSettingsImpl> get copyWith =>
      __$$PlayerSettingsImplCopyWithImpl<_$PlayerSettingsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PlayerSettingsImplToJson(
      this,
    );
  }
}

abstract class _PlayerSettings implements PlayerSettings {
  const factory _PlayerSettings(
      {final MinimizedPlayerSettings miniPlayerSettings,
      final ExpandedPlayerSettings expandedPlayerSettings,
      final double preferredDefaultVolume,
      final double preferredDefaultSpeed,
      final List<double> speedOptions,
      final SleepTimerSettings sleepTimerSettings}) = _$PlayerSettingsImpl;

  factory _PlayerSettings.fromJson(Map<String, dynamic> json) =
      _$PlayerSettingsImpl.fromJson;

  @override
  MinimizedPlayerSettings get miniPlayerSettings;
  @override
  ExpandedPlayerSettings get expandedPlayerSettings;
  @override
  double get preferredDefaultVolume;
  @override
  double get preferredDefaultSpeed;
  @override
  List<double> get speedOptions;
  @override
  SleepTimerSettings get sleepTimerSettings;
  @override
  @JsonKey(ignore: true)
  _$$PlayerSettingsImplCopyWith<_$PlayerSettingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ExpandedPlayerSettings _$ExpandedPlayerSettingsFromJson(
    Map<String, dynamic> json) {
  return _ExpandedPlayerSettings.fromJson(json);
}

/// @nodoc
mixin _$ExpandedPlayerSettings {
  bool get showTotalProgress => throw _privateConstructorUsedError;
  bool get showChapterProgress => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ExpandedPlayerSettingsCopyWith<ExpandedPlayerSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExpandedPlayerSettingsCopyWith<$Res> {
  factory $ExpandedPlayerSettingsCopyWith(ExpandedPlayerSettings value,
          $Res Function(ExpandedPlayerSettings) then) =
      _$ExpandedPlayerSettingsCopyWithImpl<$Res, ExpandedPlayerSettings>;
  @useResult
  $Res call({bool showTotalProgress, bool showChapterProgress});
}

/// @nodoc
class _$ExpandedPlayerSettingsCopyWithImpl<$Res,
        $Val extends ExpandedPlayerSettings>
    implements $ExpandedPlayerSettingsCopyWith<$Res> {
  _$ExpandedPlayerSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? showTotalProgress = null,
    Object? showChapterProgress = null,
  }) {
    return _then(_value.copyWith(
      showTotalProgress: null == showTotalProgress
          ? _value.showTotalProgress
          : showTotalProgress // ignore: cast_nullable_to_non_nullable
              as bool,
      showChapterProgress: null == showChapterProgress
          ? _value.showChapterProgress
          : showChapterProgress // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ExpandedPlayerSettingsImplCopyWith<$Res>
    implements $ExpandedPlayerSettingsCopyWith<$Res> {
  factory _$$ExpandedPlayerSettingsImplCopyWith(
          _$ExpandedPlayerSettingsImpl value,
          $Res Function(_$ExpandedPlayerSettingsImpl) then) =
      __$$ExpandedPlayerSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool showTotalProgress, bool showChapterProgress});
}

/// @nodoc
class __$$ExpandedPlayerSettingsImplCopyWithImpl<$Res>
    extends _$ExpandedPlayerSettingsCopyWithImpl<$Res,
        _$ExpandedPlayerSettingsImpl>
    implements _$$ExpandedPlayerSettingsImplCopyWith<$Res> {
  __$$ExpandedPlayerSettingsImplCopyWithImpl(
      _$ExpandedPlayerSettingsImpl _value,
      $Res Function(_$ExpandedPlayerSettingsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? showTotalProgress = null,
    Object? showChapterProgress = null,
  }) {
    return _then(_$ExpandedPlayerSettingsImpl(
      showTotalProgress: null == showTotalProgress
          ? _value.showTotalProgress
          : showTotalProgress // ignore: cast_nullable_to_non_nullable
              as bool,
      showChapterProgress: null == showChapterProgress
          ? _value.showChapterProgress
          : showChapterProgress // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ExpandedPlayerSettingsImpl implements _ExpandedPlayerSettings {
  const _$ExpandedPlayerSettingsImpl(
      {this.showTotalProgress = false, this.showChapterProgress = true});

  factory _$ExpandedPlayerSettingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExpandedPlayerSettingsImplFromJson(json);

  @override
  @JsonKey()
  final bool showTotalProgress;
  @override
  @JsonKey()
  final bool showChapterProgress;

  @override
  String toString() {
    return 'ExpandedPlayerSettings(showTotalProgress: $showTotalProgress, showChapterProgress: $showChapterProgress)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExpandedPlayerSettingsImpl &&
            (identical(other.showTotalProgress, showTotalProgress) ||
                other.showTotalProgress == showTotalProgress) &&
            (identical(other.showChapterProgress, showChapterProgress) ||
                other.showChapterProgress == showChapterProgress));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, showTotalProgress, showChapterProgress);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ExpandedPlayerSettingsImplCopyWith<_$ExpandedPlayerSettingsImpl>
      get copyWith => __$$ExpandedPlayerSettingsImplCopyWithImpl<
          _$ExpandedPlayerSettingsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ExpandedPlayerSettingsImplToJson(
      this,
    );
  }
}

abstract class _ExpandedPlayerSettings implements ExpandedPlayerSettings {
  const factory _ExpandedPlayerSettings(
      {final bool showTotalProgress,
      final bool showChapterProgress}) = _$ExpandedPlayerSettingsImpl;

  factory _ExpandedPlayerSettings.fromJson(Map<String, dynamic> json) =
      _$ExpandedPlayerSettingsImpl.fromJson;

  @override
  bool get showTotalProgress;
  @override
  bool get showChapterProgress;
  @override
  @JsonKey(ignore: true)
  _$$ExpandedPlayerSettingsImplCopyWith<_$ExpandedPlayerSettingsImpl>
      get copyWith => throw _privateConstructorUsedError;
}

MinimizedPlayerSettings _$MinimizedPlayerSettingsFromJson(
    Map<String, dynamic> json) {
  return _MinimizedPlayerSettings.fromJson(json);
}

/// @nodoc
mixin _$MinimizedPlayerSettings {
  bool get useChapterInfo => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MinimizedPlayerSettingsCopyWith<MinimizedPlayerSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MinimizedPlayerSettingsCopyWith<$Res> {
  factory $MinimizedPlayerSettingsCopyWith(MinimizedPlayerSettings value,
          $Res Function(MinimizedPlayerSettings) then) =
      _$MinimizedPlayerSettingsCopyWithImpl<$Res, MinimizedPlayerSettings>;
  @useResult
  $Res call({bool useChapterInfo});
}

/// @nodoc
class _$MinimizedPlayerSettingsCopyWithImpl<$Res,
        $Val extends MinimizedPlayerSettings>
    implements $MinimizedPlayerSettingsCopyWith<$Res> {
  _$MinimizedPlayerSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? useChapterInfo = null,
  }) {
    return _then(_value.copyWith(
      useChapterInfo: null == useChapterInfo
          ? _value.useChapterInfo
          : useChapterInfo // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MinimizedPlayerSettingsImplCopyWith<$Res>
    implements $MinimizedPlayerSettingsCopyWith<$Res> {
  factory _$$MinimizedPlayerSettingsImplCopyWith(
          _$MinimizedPlayerSettingsImpl value,
          $Res Function(_$MinimizedPlayerSettingsImpl) then) =
      __$$MinimizedPlayerSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool useChapterInfo});
}

/// @nodoc
class __$$MinimizedPlayerSettingsImplCopyWithImpl<$Res>
    extends _$MinimizedPlayerSettingsCopyWithImpl<$Res,
        _$MinimizedPlayerSettingsImpl>
    implements _$$MinimizedPlayerSettingsImplCopyWith<$Res> {
  __$$MinimizedPlayerSettingsImplCopyWithImpl(
      _$MinimizedPlayerSettingsImpl _value,
      $Res Function(_$MinimizedPlayerSettingsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? useChapterInfo = null,
  }) {
    return _then(_$MinimizedPlayerSettingsImpl(
      useChapterInfo: null == useChapterInfo
          ? _value.useChapterInfo
          : useChapterInfo // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MinimizedPlayerSettingsImpl implements _MinimizedPlayerSettings {
  const _$MinimizedPlayerSettingsImpl({this.useChapterInfo = false});

  factory _$MinimizedPlayerSettingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$MinimizedPlayerSettingsImplFromJson(json);

  @override
  @JsonKey()
  final bool useChapterInfo;

  @override
  String toString() {
    return 'MinimizedPlayerSettings(useChapterInfo: $useChapterInfo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MinimizedPlayerSettingsImpl &&
            (identical(other.useChapterInfo, useChapterInfo) ||
                other.useChapterInfo == useChapterInfo));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, useChapterInfo);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MinimizedPlayerSettingsImplCopyWith<_$MinimizedPlayerSettingsImpl>
      get copyWith => __$$MinimizedPlayerSettingsImplCopyWithImpl<
          _$MinimizedPlayerSettingsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MinimizedPlayerSettingsImplToJson(
      this,
    );
  }
}

abstract class _MinimizedPlayerSettings implements MinimizedPlayerSettings {
  const factory _MinimizedPlayerSettings({final bool useChapterInfo}) =
      _$MinimizedPlayerSettingsImpl;

  factory _MinimizedPlayerSettings.fromJson(Map<String, dynamic> json) =
      _$MinimizedPlayerSettingsImpl.fromJson;

  @override
  bool get useChapterInfo;
  @override
  @JsonKey(ignore: true)
  _$$MinimizedPlayerSettingsImplCopyWith<_$MinimizedPlayerSettingsImpl>
      get copyWith => throw _privateConstructorUsedError;
}

SleepTimerSettings _$SleepTimerSettingsFromJson(Map<String, dynamic> json) {
  return _SleepTimerSettings.fromJson(json);
}

/// @nodoc
mixin _$SleepTimerSettings {
  Duration get defaultDuration => throw _privateConstructorUsedError;
  SleepTimerShakeSenseMode get shakeSenseMode =>
      throw _privateConstructorUsedError;

  /// the duration in which the shake is detected before the end of the timer and after the timer ends
  /// only used if [shakeSenseMode] is [SleepTimerShakeSenseMode.nearEnds]
  Duration get shakeSenseDuration => throw _privateConstructorUsedError;
  bool get vibrateWhenReset => throw _privateConstructorUsedError;
  bool get beepWhenReset => throw _privateConstructorUsedError;
  bool get fadeOutAudio => throw _privateConstructorUsedError;
  double get shakeDetectThreshold => throw _privateConstructorUsedError;

  /// if true, the player will automatically rewind the audio when the sleep timer is stopped
  bool get autoRewindWhenStopped => throw _privateConstructorUsedError;

  /// the key is the duration in minutes
  Map<int, Duration> get autoRewindDurations =>
      throw _privateConstructorUsedError;

  /// auto turn on timer settings
  bool get autoTurnOnTimer => throw _privateConstructorUsedError;

  /// always auto turn on timer settings or during specific times
  bool get alwaysAutoTurnOnTimer => throw _privateConstructorUsedError;

  /// auto timer settings, only used if [alwaysAutoTurnOnTimer] is false
  ///
  /// duration is the time from 00:00
  Duration get autoTurnOnTime => throw _privateConstructorUsedError;
  Duration get autoTurnOffTime => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SleepTimerSettingsCopyWith<SleepTimerSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SleepTimerSettingsCopyWith<$Res> {
  factory $SleepTimerSettingsCopyWith(
          SleepTimerSettings value, $Res Function(SleepTimerSettings) then) =
      _$SleepTimerSettingsCopyWithImpl<$Res, SleepTimerSettings>;
  @useResult
  $Res call(
      {Duration defaultDuration,
      SleepTimerShakeSenseMode shakeSenseMode,
      Duration shakeSenseDuration,
      bool vibrateWhenReset,
      bool beepWhenReset,
      bool fadeOutAudio,
      double shakeDetectThreshold,
      bool autoRewindWhenStopped,
      Map<int, Duration> autoRewindDurations,
      bool autoTurnOnTimer,
      bool alwaysAutoTurnOnTimer,
      Duration autoTurnOnTime,
      Duration autoTurnOffTime});
}

/// @nodoc
class _$SleepTimerSettingsCopyWithImpl<$Res, $Val extends SleepTimerSettings>
    implements $SleepTimerSettingsCopyWith<$Res> {
  _$SleepTimerSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? defaultDuration = null,
    Object? shakeSenseMode = null,
    Object? shakeSenseDuration = null,
    Object? vibrateWhenReset = null,
    Object? beepWhenReset = null,
    Object? fadeOutAudio = null,
    Object? shakeDetectThreshold = null,
    Object? autoRewindWhenStopped = null,
    Object? autoRewindDurations = null,
    Object? autoTurnOnTimer = null,
    Object? alwaysAutoTurnOnTimer = null,
    Object? autoTurnOnTime = null,
    Object? autoTurnOffTime = null,
  }) {
    return _then(_value.copyWith(
      defaultDuration: null == defaultDuration
          ? _value.defaultDuration
          : defaultDuration // ignore: cast_nullable_to_non_nullable
              as Duration,
      shakeSenseMode: null == shakeSenseMode
          ? _value.shakeSenseMode
          : shakeSenseMode // ignore: cast_nullable_to_non_nullable
              as SleepTimerShakeSenseMode,
      shakeSenseDuration: null == shakeSenseDuration
          ? _value.shakeSenseDuration
          : shakeSenseDuration // ignore: cast_nullable_to_non_nullable
              as Duration,
      vibrateWhenReset: null == vibrateWhenReset
          ? _value.vibrateWhenReset
          : vibrateWhenReset // ignore: cast_nullable_to_non_nullable
              as bool,
      beepWhenReset: null == beepWhenReset
          ? _value.beepWhenReset
          : beepWhenReset // ignore: cast_nullable_to_non_nullable
              as bool,
      fadeOutAudio: null == fadeOutAudio
          ? _value.fadeOutAudio
          : fadeOutAudio // ignore: cast_nullable_to_non_nullable
              as bool,
      shakeDetectThreshold: null == shakeDetectThreshold
          ? _value.shakeDetectThreshold
          : shakeDetectThreshold // ignore: cast_nullable_to_non_nullable
              as double,
      autoRewindWhenStopped: null == autoRewindWhenStopped
          ? _value.autoRewindWhenStopped
          : autoRewindWhenStopped // ignore: cast_nullable_to_non_nullable
              as bool,
      autoRewindDurations: null == autoRewindDurations
          ? _value.autoRewindDurations
          : autoRewindDurations // ignore: cast_nullable_to_non_nullable
              as Map<int, Duration>,
      autoTurnOnTimer: null == autoTurnOnTimer
          ? _value.autoTurnOnTimer
          : autoTurnOnTimer // ignore: cast_nullable_to_non_nullable
              as bool,
      alwaysAutoTurnOnTimer: null == alwaysAutoTurnOnTimer
          ? _value.alwaysAutoTurnOnTimer
          : alwaysAutoTurnOnTimer // ignore: cast_nullable_to_non_nullable
              as bool,
      autoTurnOnTime: null == autoTurnOnTime
          ? _value.autoTurnOnTime
          : autoTurnOnTime // ignore: cast_nullable_to_non_nullable
              as Duration,
      autoTurnOffTime: null == autoTurnOffTime
          ? _value.autoTurnOffTime
          : autoTurnOffTime // ignore: cast_nullable_to_non_nullable
              as Duration,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SleepTimerSettingsImplCopyWith<$Res>
    implements $SleepTimerSettingsCopyWith<$Res> {
  factory _$$SleepTimerSettingsImplCopyWith(_$SleepTimerSettingsImpl value,
          $Res Function(_$SleepTimerSettingsImpl) then) =
      __$$SleepTimerSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Duration defaultDuration,
      SleepTimerShakeSenseMode shakeSenseMode,
      Duration shakeSenseDuration,
      bool vibrateWhenReset,
      bool beepWhenReset,
      bool fadeOutAudio,
      double shakeDetectThreshold,
      bool autoRewindWhenStopped,
      Map<int, Duration> autoRewindDurations,
      bool autoTurnOnTimer,
      bool alwaysAutoTurnOnTimer,
      Duration autoTurnOnTime,
      Duration autoTurnOffTime});
}

/// @nodoc
class __$$SleepTimerSettingsImplCopyWithImpl<$Res>
    extends _$SleepTimerSettingsCopyWithImpl<$Res, _$SleepTimerSettingsImpl>
    implements _$$SleepTimerSettingsImplCopyWith<$Res> {
  __$$SleepTimerSettingsImplCopyWithImpl(_$SleepTimerSettingsImpl _value,
      $Res Function(_$SleepTimerSettingsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? defaultDuration = null,
    Object? shakeSenseMode = null,
    Object? shakeSenseDuration = null,
    Object? vibrateWhenReset = null,
    Object? beepWhenReset = null,
    Object? fadeOutAudio = null,
    Object? shakeDetectThreshold = null,
    Object? autoRewindWhenStopped = null,
    Object? autoRewindDurations = null,
    Object? autoTurnOnTimer = null,
    Object? alwaysAutoTurnOnTimer = null,
    Object? autoTurnOnTime = null,
    Object? autoTurnOffTime = null,
  }) {
    return _then(_$SleepTimerSettingsImpl(
      defaultDuration: null == defaultDuration
          ? _value.defaultDuration
          : defaultDuration // ignore: cast_nullable_to_non_nullable
              as Duration,
      shakeSenseMode: null == shakeSenseMode
          ? _value.shakeSenseMode
          : shakeSenseMode // ignore: cast_nullable_to_non_nullable
              as SleepTimerShakeSenseMode,
      shakeSenseDuration: null == shakeSenseDuration
          ? _value.shakeSenseDuration
          : shakeSenseDuration // ignore: cast_nullable_to_non_nullable
              as Duration,
      vibrateWhenReset: null == vibrateWhenReset
          ? _value.vibrateWhenReset
          : vibrateWhenReset // ignore: cast_nullable_to_non_nullable
              as bool,
      beepWhenReset: null == beepWhenReset
          ? _value.beepWhenReset
          : beepWhenReset // ignore: cast_nullable_to_non_nullable
              as bool,
      fadeOutAudio: null == fadeOutAudio
          ? _value.fadeOutAudio
          : fadeOutAudio // ignore: cast_nullable_to_non_nullable
              as bool,
      shakeDetectThreshold: null == shakeDetectThreshold
          ? _value.shakeDetectThreshold
          : shakeDetectThreshold // ignore: cast_nullable_to_non_nullable
              as double,
      autoRewindWhenStopped: null == autoRewindWhenStopped
          ? _value.autoRewindWhenStopped
          : autoRewindWhenStopped // ignore: cast_nullable_to_non_nullable
              as bool,
      autoRewindDurations: null == autoRewindDurations
          ? _value._autoRewindDurations
          : autoRewindDurations // ignore: cast_nullable_to_non_nullable
              as Map<int, Duration>,
      autoTurnOnTimer: null == autoTurnOnTimer
          ? _value.autoTurnOnTimer
          : autoTurnOnTimer // ignore: cast_nullable_to_non_nullable
              as bool,
      alwaysAutoTurnOnTimer: null == alwaysAutoTurnOnTimer
          ? _value.alwaysAutoTurnOnTimer
          : alwaysAutoTurnOnTimer // ignore: cast_nullable_to_non_nullable
              as bool,
      autoTurnOnTime: null == autoTurnOnTime
          ? _value.autoTurnOnTime
          : autoTurnOnTime // ignore: cast_nullable_to_non_nullable
              as Duration,
      autoTurnOffTime: null == autoTurnOffTime
          ? _value.autoTurnOffTime
          : autoTurnOffTime // ignore: cast_nullable_to_non_nullable
              as Duration,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SleepTimerSettingsImpl implements _SleepTimerSettings {
  const _$SleepTimerSettingsImpl(
      {this.defaultDuration = const Duration(minutes: 15),
      this.shakeSenseMode = SleepTimerShakeSenseMode.always,
      this.shakeSenseDuration = const Duration(seconds: 30),
      this.vibrateWhenReset = true,
      this.beepWhenReset = false,
      this.fadeOutAudio = false,
      this.shakeDetectThreshold = 0.5,
      this.autoRewindWhenStopped = false,
      final Map<int, Duration> autoRewindDurations = const {
        5: Duration(seconds: 10),
        15: Duration(seconds: 30),
        45: Duration(seconds: 45),
        60: Duration(minutes: 1),
        120: Duration(minutes: 2)
      },
      this.autoTurnOnTimer = false,
      this.alwaysAutoTurnOnTimer = true,
      this.autoTurnOnTime = const Duration(hours: 22, minutes: 0),
      this.autoTurnOffTime = const Duration(hours: 6, minutes: 0)})
      : _autoRewindDurations = autoRewindDurations;

  factory _$SleepTimerSettingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$SleepTimerSettingsImplFromJson(json);

  @override
  @JsonKey()
  final Duration defaultDuration;
  @override
  @JsonKey()
  final SleepTimerShakeSenseMode shakeSenseMode;

  /// the duration in which the shake is detected before the end of the timer and after the timer ends
  /// only used if [shakeSenseMode] is [SleepTimerShakeSenseMode.nearEnds]
  @override
  @JsonKey()
  final Duration shakeSenseDuration;
  @override
  @JsonKey()
  final bool vibrateWhenReset;
  @override
  @JsonKey()
  final bool beepWhenReset;
  @override
  @JsonKey()
  final bool fadeOutAudio;
  @override
  @JsonKey()
  final double shakeDetectThreshold;

  /// if true, the player will automatically rewind the audio when the sleep timer is stopped
  @override
  @JsonKey()
  final bool autoRewindWhenStopped;

  /// the key is the duration in minutes
  final Map<int, Duration> _autoRewindDurations;

  /// the key is the duration in minutes
  @override
  @JsonKey()
  Map<int, Duration> get autoRewindDurations {
    if (_autoRewindDurations is EqualUnmodifiableMapView)
      return _autoRewindDurations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_autoRewindDurations);
  }

  /// auto turn on timer settings
  @override
  @JsonKey()
  final bool autoTurnOnTimer;

  /// always auto turn on timer settings or during specific times
  @override
  @JsonKey()
  final bool alwaysAutoTurnOnTimer;

  /// auto timer settings, only used if [alwaysAutoTurnOnTimer] is false
  ///
  /// duration is the time from 00:00
  @override
  @JsonKey()
  final Duration autoTurnOnTime;
  @override
  @JsonKey()
  final Duration autoTurnOffTime;

  @override
  String toString() {
    return 'SleepTimerSettings(defaultDuration: $defaultDuration, shakeSenseMode: $shakeSenseMode, shakeSenseDuration: $shakeSenseDuration, vibrateWhenReset: $vibrateWhenReset, beepWhenReset: $beepWhenReset, fadeOutAudio: $fadeOutAudio, shakeDetectThreshold: $shakeDetectThreshold, autoRewindWhenStopped: $autoRewindWhenStopped, autoRewindDurations: $autoRewindDurations, autoTurnOnTimer: $autoTurnOnTimer, alwaysAutoTurnOnTimer: $alwaysAutoTurnOnTimer, autoTurnOnTime: $autoTurnOnTime, autoTurnOffTime: $autoTurnOffTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SleepTimerSettingsImpl &&
            (identical(other.defaultDuration, defaultDuration) ||
                other.defaultDuration == defaultDuration) &&
            (identical(other.shakeSenseMode, shakeSenseMode) ||
                other.shakeSenseMode == shakeSenseMode) &&
            (identical(other.shakeSenseDuration, shakeSenseDuration) ||
                other.shakeSenseDuration == shakeSenseDuration) &&
            (identical(other.vibrateWhenReset, vibrateWhenReset) ||
                other.vibrateWhenReset == vibrateWhenReset) &&
            (identical(other.beepWhenReset, beepWhenReset) ||
                other.beepWhenReset == beepWhenReset) &&
            (identical(other.fadeOutAudio, fadeOutAudio) ||
                other.fadeOutAudio == fadeOutAudio) &&
            (identical(other.shakeDetectThreshold, shakeDetectThreshold) ||
                other.shakeDetectThreshold == shakeDetectThreshold) &&
            (identical(other.autoRewindWhenStopped, autoRewindWhenStopped) ||
                other.autoRewindWhenStopped == autoRewindWhenStopped) &&
            const DeepCollectionEquality()
                .equals(other._autoRewindDurations, _autoRewindDurations) &&
            (identical(other.autoTurnOnTimer, autoTurnOnTimer) ||
                other.autoTurnOnTimer == autoTurnOnTimer) &&
            (identical(other.alwaysAutoTurnOnTimer, alwaysAutoTurnOnTimer) ||
                other.alwaysAutoTurnOnTimer == alwaysAutoTurnOnTimer) &&
            (identical(other.autoTurnOnTime, autoTurnOnTime) ||
                other.autoTurnOnTime == autoTurnOnTime) &&
            (identical(other.autoTurnOffTime, autoTurnOffTime) ||
                other.autoTurnOffTime == autoTurnOffTime));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      defaultDuration,
      shakeSenseMode,
      shakeSenseDuration,
      vibrateWhenReset,
      beepWhenReset,
      fadeOutAudio,
      shakeDetectThreshold,
      autoRewindWhenStopped,
      const DeepCollectionEquality().hash(_autoRewindDurations),
      autoTurnOnTimer,
      alwaysAutoTurnOnTimer,
      autoTurnOnTime,
      autoTurnOffTime);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SleepTimerSettingsImplCopyWith<_$SleepTimerSettingsImpl> get copyWith =>
      __$$SleepTimerSettingsImplCopyWithImpl<_$SleepTimerSettingsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SleepTimerSettingsImplToJson(
      this,
    );
  }
}

abstract class _SleepTimerSettings implements SleepTimerSettings {
  const factory _SleepTimerSettings(
      {final Duration defaultDuration,
      final SleepTimerShakeSenseMode shakeSenseMode,
      final Duration shakeSenseDuration,
      final bool vibrateWhenReset,
      final bool beepWhenReset,
      final bool fadeOutAudio,
      final double shakeDetectThreshold,
      final bool autoRewindWhenStopped,
      final Map<int, Duration> autoRewindDurations,
      final bool autoTurnOnTimer,
      final bool alwaysAutoTurnOnTimer,
      final Duration autoTurnOnTime,
      final Duration autoTurnOffTime}) = _$SleepTimerSettingsImpl;

  factory _SleepTimerSettings.fromJson(Map<String, dynamic> json) =
      _$SleepTimerSettingsImpl.fromJson;

  @override
  Duration get defaultDuration;
  @override
  SleepTimerShakeSenseMode get shakeSenseMode;
  @override

  /// the duration in which the shake is detected before the end of the timer and after the timer ends
  /// only used if [shakeSenseMode] is [SleepTimerShakeSenseMode.nearEnds]
  Duration get shakeSenseDuration;
  @override
  bool get vibrateWhenReset;
  @override
  bool get beepWhenReset;
  @override
  bool get fadeOutAudio;
  @override
  double get shakeDetectThreshold;
  @override

  /// if true, the player will automatically rewind the audio when the sleep timer is stopped
  bool get autoRewindWhenStopped;
  @override

  /// the key is the duration in minutes
  Map<int, Duration> get autoRewindDurations;
  @override

  /// auto turn on timer settings
  bool get autoTurnOnTimer;
  @override

  /// always auto turn on timer settings or during specific times
  bool get alwaysAutoTurnOnTimer;
  @override

  /// auto timer settings, only used if [alwaysAutoTurnOnTimer] is false
  ///
  /// duration is the time from 00:00
  Duration get autoTurnOnTime;
  @override
  Duration get autoTurnOffTime;
  @override
  @JsonKey(ignore: true)
  _$$SleepTimerSettingsImplCopyWith<_$SleepTimerSettingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
