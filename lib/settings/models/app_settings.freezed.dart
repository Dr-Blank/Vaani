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
  Duration get sleepTimer => throw _privateConstructorUsedError;

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
      Duration sleepTimer});

  $MinimizedPlayerSettingsCopyWith<$Res> get miniPlayerSettings;
  $ExpandedPlayerSettingsCopyWith<$Res> get expandedPlayerSettings;
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
    Object? sleepTimer = null,
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
      sleepTimer: null == sleepTimer
          ? _value.sleepTimer
          : sleepTimer // ignore: cast_nullable_to_non_nullable
              as Duration,
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
      Duration sleepTimer});

  @override
  $MinimizedPlayerSettingsCopyWith<$Res> get miniPlayerSettings;
  @override
  $ExpandedPlayerSettingsCopyWith<$Res> get expandedPlayerSettings;
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
    Object? sleepTimer = null,
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
      sleepTimer: null == sleepTimer
          ? _value.sleepTimer
          : sleepTimer // ignore: cast_nullable_to_non_nullable
              as Duration,
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
      this.sleepTimer = const Duration(minutes: 15)})
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
  final Duration sleepTimer;

  @override
  String toString() {
    return 'PlayerSettings(miniPlayerSettings: $miniPlayerSettings, expandedPlayerSettings: $expandedPlayerSettings, preferredDefaultVolume: $preferredDefaultVolume, preferredDefaultSpeed: $preferredDefaultSpeed, speedOptions: $speedOptions, sleepTimer: $sleepTimer)';
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
            (identical(other.sleepTimer, sleepTimer) ||
                other.sleepTimer == sleepTimer));
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
      sleepTimer);

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
      final Duration sleepTimer}) = _$PlayerSettingsImpl;

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
  Duration get sleepTimer;
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
