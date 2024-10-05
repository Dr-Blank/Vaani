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
  ThemeSettings get themeSettings => throw _privateConstructorUsedError;
  PlayerSettings get playerSettings => throw _privateConstructorUsedError;
  SleepTimerSettings get sleepTimerSettings =>
      throw _privateConstructorUsedError;
  DownloadSettings get downloadSettings => throw _privateConstructorUsedError;
  NotificationSettings get notificationSettings =>
      throw _privateConstructorUsedError;
  ShakeDetectionSettings get shakeDetectionSettings =>
      throw _privateConstructorUsedError;

  /// Serializes this AppSettings to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AppSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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
      {ThemeSettings themeSettings,
      PlayerSettings playerSettings,
      SleepTimerSettings sleepTimerSettings,
      DownloadSettings downloadSettings,
      NotificationSettings notificationSettings,
      ShakeDetectionSettings shakeDetectionSettings});

  $ThemeSettingsCopyWith<$Res> get themeSettings;
  $PlayerSettingsCopyWith<$Res> get playerSettings;
  $SleepTimerSettingsCopyWith<$Res> get sleepTimerSettings;
  $DownloadSettingsCopyWith<$Res> get downloadSettings;
  $NotificationSettingsCopyWith<$Res> get notificationSettings;
  $ShakeDetectionSettingsCopyWith<$Res> get shakeDetectionSettings;
}

/// @nodoc
class _$AppSettingsCopyWithImpl<$Res, $Val extends AppSettings>
    implements $AppSettingsCopyWith<$Res> {
  _$AppSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AppSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? themeSettings = null,
    Object? playerSettings = null,
    Object? sleepTimerSettings = null,
    Object? downloadSettings = null,
    Object? notificationSettings = null,
    Object? shakeDetectionSettings = null,
  }) {
    return _then(_value.copyWith(
      themeSettings: null == themeSettings
          ? _value.themeSettings
          : themeSettings // ignore: cast_nullable_to_non_nullable
              as ThemeSettings,
      playerSettings: null == playerSettings
          ? _value.playerSettings
          : playerSettings // ignore: cast_nullable_to_non_nullable
              as PlayerSettings,
      sleepTimerSettings: null == sleepTimerSettings
          ? _value.sleepTimerSettings
          : sleepTimerSettings // ignore: cast_nullable_to_non_nullable
              as SleepTimerSettings,
      downloadSettings: null == downloadSettings
          ? _value.downloadSettings
          : downloadSettings // ignore: cast_nullable_to_non_nullable
              as DownloadSettings,
      notificationSettings: null == notificationSettings
          ? _value.notificationSettings
          : notificationSettings // ignore: cast_nullable_to_non_nullable
              as NotificationSettings,
      shakeDetectionSettings: null == shakeDetectionSettings
          ? _value.shakeDetectionSettings
          : shakeDetectionSettings // ignore: cast_nullable_to_non_nullable
              as ShakeDetectionSettings,
    ) as $Val);
  }

  /// Create a copy of AppSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ThemeSettingsCopyWith<$Res> get themeSettings {
    return $ThemeSettingsCopyWith<$Res>(_value.themeSettings, (value) {
      return _then(_value.copyWith(themeSettings: value) as $Val);
    });
  }

  /// Create a copy of AppSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PlayerSettingsCopyWith<$Res> get playerSettings {
    return $PlayerSettingsCopyWith<$Res>(_value.playerSettings, (value) {
      return _then(_value.copyWith(playerSettings: value) as $Val);
    });
  }

  /// Create a copy of AppSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SleepTimerSettingsCopyWith<$Res> get sleepTimerSettings {
    return $SleepTimerSettingsCopyWith<$Res>(_value.sleepTimerSettings,
        (value) {
      return _then(_value.copyWith(sleepTimerSettings: value) as $Val);
    });
  }

  /// Create a copy of AppSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DownloadSettingsCopyWith<$Res> get downloadSettings {
    return $DownloadSettingsCopyWith<$Res>(_value.downloadSettings, (value) {
      return _then(_value.copyWith(downloadSettings: value) as $Val);
    });
  }

  /// Create a copy of AppSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $NotificationSettingsCopyWith<$Res> get notificationSettings {
    return $NotificationSettingsCopyWith<$Res>(_value.notificationSettings,
        (value) {
      return _then(_value.copyWith(notificationSettings: value) as $Val);
    });
  }

  /// Create a copy of AppSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ShakeDetectionSettingsCopyWith<$Res> get shakeDetectionSettings {
    return $ShakeDetectionSettingsCopyWith<$Res>(_value.shakeDetectionSettings,
        (value) {
      return _then(_value.copyWith(shakeDetectionSettings: value) as $Val);
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
      {ThemeSettings themeSettings,
      PlayerSettings playerSettings,
      SleepTimerSettings sleepTimerSettings,
      DownloadSettings downloadSettings,
      NotificationSettings notificationSettings,
      ShakeDetectionSettings shakeDetectionSettings});

  @override
  $ThemeSettingsCopyWith<$Res> get themeSettings;
  @override
  $PlayerSettingsCopyWith<$Res> get playerSettings;
  @override
  $SleepTimerSettingsCopyWith<$Res> get sleepTimerSettings;
  @override
  $DownloadSettingsCopyWith<$Res> get downloadSettings;
  @override
  $NotificationSettingsCopyWith<$Res> get notificationSettings;
  @override
  $ShakeDetectionSettingsCopyWith<$Res> get shakeDetectionSettings;
}

/// @nodoc
class __$$AppSettingsImplCopyWithImpl<$Res>
    extends _$AppSettingsCopyWithImpl<$Res, _$AppSettingsImpl>
    implements _$$AppSettingsImplCopyWith<$Res> {
  __$$AppSettingsImplCopyWithImpl(
      _$AppSettingsImpl _value, $Res Function(_$AppSettingsImpl) _then)
      : super(_value, _then);

  /// Create a copy of AppSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? themeSettings = null,
    Object? playerSettings = null,
    Object? sleepTimerSettings = null,
    Object? downloadSettings = null,
    Object? notificationSettings = null,
    Object? shakeDetectionSettings = null,
  }) {
    return _then(_$AppSettingsImpl(
      themeSettings: null == themeSettings
          ? _value.themeSettings
          : themeSettings // ignore: cast_nullable_to_non_nullable
              as ThemeSettings,
      playerSettings: null == playerSettings
          ? _value.playerSettings
          : playerSettings // ignore: cast_nullable_to_non_nullable
              as PlayerSettings,
      sleepTimerSettings: null == sleepTimerSettings
          ? _value.sleepTimerSettings
          : sleepTimerSettings // ignore: cast_nullable_to_non_nullable
              as SleepTimerSettings,
      downloadSettings: null == downloadSettings
          ? _value.downloadSettings
          : downloadSettings // ignore: cast_nullable_to_non_nullable
              as DownloadSettings,
      notificationSettings: null == notificationSettings
          ? _value.notificationSettings
          : notificationSettings // ignore: cast_nullable_to_non_nullable
              as NotificationSettings,
      shakeDetectionSettings: null == shakeDetectionSettings
          ? _value.shakeDetectionSettings
          : shakeDetectionSettings // ignore: cast_nullable_to_non_nullable
              as ShakeDetectionSettings,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AppSettingsImpl implements _AppSettings {
  const _$AppSettingsImpl(
      {this.themeSettings = const ThemeSettings(),
      this.playerSettings = const PlayerSettings(),
      this.sleepTimerSettings = const SleepTimerSettings(),
      this.downloadSettings = const DownloadSettings(),
      this.notificationSettings = const NotificationSettings(),
      this.shakeDetectionSettings = const ShakeDetectionSettings()});

  factory _$AppSettingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppSettingsImplFromJson(json);

  @override
  @JsonKey()
  final ThemeSettings themeSettings;
  @override
  @JsonKey()
  final PlayerSettings playerSettings;
  @override
  @JsonKey()
  final SleepTimerSettings sleepTimerSettings;
  @override
  @JsonKey()
  final DownloadSettings downloadSettings;
  @override
  @JsonKey()
  final NotificationSettings notificationSettings;
  @override
  @JsonKey()
  final ShakeDetectionSettings shakeDetectionSettings;

  @override
  String toString() {
    return 'AppSettings(themeSettings: $themeSettings, playerSettings: $playerSettings, sleepTimerSettings: $sleepTimerSettings, downloadSettings: $downloadSettings, notificationSettings: $notificationSettings, shakeDetectionSettings: $shakeDetectionSettings)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppSettingsImpl &&
            (identical(other.themeSettings, themeSettings) ||
                other.themeSettings == themeSettings) &&
            (identical(other.playerSettings, playerSettings) ||
                other.playerSettings == playerSettings) &&
            (identical(other.sleepTimerSettings, sleepTimerSettings) ||
                other.sleepTimerSettings == sleepTimerSettings) &&
            (identical(other.downloadSettings, downloadSettings) ||
                other.downloadSettings == downloadSettings) &&
            (identical(other.notificationSettings, notificationSettings) ||
                other.notificationSettings == notificationSettings) &&
            (identical(other.shakeDetectionSettings, shakeDetectionSettings) ||
                other.shakeDetectionSettings == shakeDetectionSettings));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      themeSettings,
      playerSettings,
      sleepTimerSettings,
      downloadSettings,
      notificationSettings,
      shakeDetectionSettings);

  /// Create a copy of AppSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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
      {final ThemeSettings themeSettings,
      final PlayerSettings playerSettings,
      final SleepTimerSettings sleepTimerSettings,
      final DownloadSettings downloadSettings,
      final NotificationSettings notificationSettings,
      final ShakeDetectionSettings shakeDetectionSettings}) = _$AppSettingsImpl;

  factory _AppSettings.fromJson(Map<String, dynamic> json) =
      _$AppSettingsImpl.fromJson;

  @override
  ThemeSettings get themeSettings;
  @override
  PlayerSettings get playerSettings;
  @override
  SleepTimerSettings get sleepTimerSettings;
  @override
  DownloadSettings get downloadSettings;
  @override
  NotificationSettings get notificationSettings;
  @override
  ShakeDetectionSettings get shakeDetectionSettings;

  /// Create a copy of AppSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AppSettingsImplCopyWith<_$AppSettingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ThemeSettings _$ThemeSettingsFromJson(Map<String, dynamic> json) {
  return _ThemeSettings.fromJson(json);
}

/// @nodoc
mixin _$ThemeSettings {
  ThemeMode get themeMode => throw _privateConstructorUsedError;
  bool get highContrast => throw _privateConstructorUsedError;
  bool get useMaterialThemeFromSystem => throw _privateConstructorUsedError;
  String get customThemeColor => throw _privateConstructorUsedError;
  bool get useMaterialThemeOfPlayingItem => throw _privateConstructorUsedError;
  bool get useMaterialThemeOnItemPage => throw _privateConstructorUsedError;

  /// Serializes this ThemeSettings to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ThemeSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ThemeSettingsCopyWith<ThemeSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ThemeSettingsCopyWith<$Res> {
  factory $ThemeSettingsCopyWith(
          ThemeSettings value, $Res Function(ThemeSettings) then) =
      _$ThemeSettingsCopyWithImpl<$Res, ThemeSettings>;
  @useResult
  $Res call(
      {ThemeMode themeMode,
      bool highContrast,
      bool useMaterialThemeFromSystem,
      String customThemeColor,
      bool useMaterialThemeOfPlayingItem,
      bool useMaterialThemeOnItemPage});
}

/// @nodoc
class _$ThemeSettingsCopyWithImpl<$Res, $Val extends ThemeSettings>
    implements $ThemeSettingsCopyWith<$Res> {
  _$ThemeSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ThemeSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? themeMode = null,
    Object? highContrast = null,
    Object? useMaterialThemeFromSystem = null,
    Object? customThemeColor = null,
    Object? useMaterialThemeOfPlayingItem = null,
    Object? useMaterialThemeOnItemPage = null,
  }) {
    return _then(_value.copyWith(
      themeMode: null == themeMode
          ? _value.themeMode
          : themeMode // ignore: cast_nullable_to_non_nullable
              as ThemeMode,
      highContrast: null == highContrast
          ? _value.highContrast
          : highContrast // ignore: cast_nullable_to_non_nullable
              as bool,
      useMaterialThemeFromSystem: null == useMaterialThemeFromSystem
          ? _value.useMaterialThemeFromSystem
          : useMaterialThemeFromSystem // ignore: cast_nullable_to_non_nullable
              as bool,
      customThemeColor: null == customThemeColor
          ? _value.customThemeColor
          : customThemeColor // ignore: cast_nullable_to_non_nullable
              as String,
      useMaterialThemeOfPlayingItem: null == useMaterialThemeOfPlayingItem
          ? _value.useMaterialThemeOfPlayingItem
          : useMaterialThemeOfPlayingItem // ignore: cast_nullable_to_non_nullable
              as bool,
      useMaterialThemeOnItemPage: null == useMaterialThemeOnItemPage
          ? _value.useMaterialThemeOnItemPage
          : useMaterialThemeOnItemPage // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ThemeSettingsImplCopyWith<$Res>
    implements $ThemeSettingsCopyWith<$Res> {
  factory _$$ThemeSettingsImplCopyWith(
          _$ThemeSettingsImpl value, $Res Function(_$ThemeSettingsImpl) then) =
      __$$ThemeSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {ThemeMode themeMode,
      bool highContrast,
      bool useMaterialThemeFromSystem,
      String customThemeColor,
      bool useMaterialThemeOfPlayingItem,
      bool useMaterialThemeOnItemPage});
}

/// @nodoc
class __$$ThemeSettingsImplCopyWithImpl<$Res>
    extends _$ThemeSettingsCopyWithImpl<$Res, _$ThemeSettingsImpl>
    implements _$$ThemeSettingsImplCopyWith<$Res> {
  __$$ThemeSettingsImplCopyWithImpl(
      _$ThemeSettingsImpl _value, $Res Function(_$ThemeSettingsImpl) _then)
      : super(_value, _then);

  /// Create a copy of ThemeSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? themeMode = null,
    Object? highContrast = null,
    Object? useMaterialThemeFromSystem = null,
    Object? customThemeColor = null,
    Object? useMaterialThemeOfPlayingItem = null,
    Object? useMaterialThemeOnItemPage = null,
  }) {
    return _then(_$ThemeSettingsImpl(
      themeMode: null == themeMode
          ? _value.themeMode
          : themeMode // ignore: cast_nullable_to_non_nullable
              as ThemeMode,
      highContrast: null == highContrast
          ? _value.highContrast
          : highContrast // ignore: cast_nullable_to_non_nullable
              as bool,
      useMaterialThemeFromSystem: null == useMaterialThemeFromSystem
          ? _value.useMaterialThemeFromSystem
          : useMaterialThemeFromSystem // ignore: cast_nullable_to_non_nullable
              as bool,
      customThemeColor: null == customThemeColor
          ? _value.customThemeColor
          : customThemeColor // ignore: cast_nullable_to_non_nullable
              as String,
      useMaterialThemeOfPlayingItem: null == useMaterialThemeOfPlayingItem
          ? _value.useMaterialThemeOfPlayingItem
          : useMaterialThemeOfPlayingItem // ignore: cast_nullable_to_non_nullable
              as bool,
      useMaterialThemeOnItemPage: null == useMaterialThemeOnItemPage
          ? _value.useMaterialThemeOnItemPage
          : useMaterialThemeOnItemPage // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ThemeSettingsImpl implements _ThemeSettings {
  const _$ThemeSettingsImpl(
      {this.themeMode = ThemeMode.system,
      this.highContrast = false,
      this.useMaterialThemeFromSystem = false,
      this.customThemeColor = '#FF311B92',
      this.useMaterialThemeOfPlayingItem = true,
      this.useMaterialThemeOnItemPage = true});

  factory _$ThemeSettingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$ThemeSettingsImplFromJson(json);

  @override
  @JsonKey()
  final ThemeMode themeMode;
  @override
  @JsonKey()
  final bool highContrast;
  @override
  @JsonKey()
  final bool useMaterialThemeFromSystem;
  @override
  @JsonKey()
  final String customThemeColor;
  @override
  @JsonKey()
  final bool useMaterialThemeOfPlayingItem;
  @override
  @JsonKey()
  final bool useMaterialThemeOnItemPage;

  @override
  String toString() {
    return 'ThemeSettings(themeMode: $themeMode, highContrast: $highContrast, useMaterialThemeFromSystem: $useMaterialThemeFromSystem, customThemeColor: $customThemeColor, useMaterialThemeOfPlayingItem: $useMaterialThemeOfPlayingItem, useMaterialThemeOnItemPage: $useMaterialThemeOnItemPage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ThemeSettingsImpl &&
            (identical(other.themeMode, themeMode) ||
                other.themeMode == themeMode) &&
            (identical(other.highContrast, highContrast) ||
                other.highContrast == highContrast) &&
            (identical(other.useMaterialThemeFromSystem,
                    useMaterialThemeFromSystem) ||
                other.useMaterialThemeFromSystem ==
                    useMaterialThemeFromSystem) &&
            (identical(other.customThemeColor, customThemeColor) ||
                other.customThemeColor == customThemeColor) &&
            (identical(other.useMaterialThemeOfPlayingItem,
                    useMaterialThemeOfPlayingItem) ||
                other.useMaterialThemeOfPlayingItem ==
                    useMaterialThemeOfPlayingItem) &&
            (identical(other.useMaterialThemeOnItemPage,
                    useMaterialThemeOnItemPage) ||
                other.useMaterialThemeOnItemPage ==
                    useMaterialThemeOnItemPage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      themeMode,
      highContrast,
      useMaterialThemeFromSystem,
      customThemeColor,
      useMaterialThemeOfPlayingItem,
      useMaterialThemeOnItemPage);

  /// Create a copy of ThemeSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ThemeSettingsImplCopyWith<_$ThemeSettingsImpl> get copyWith =>
      __$$ThemeSettingsImplCopyWithImpl<_$ThemeSettingsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ThemeSettingsImplToJson(
      this,
    );
  }
}

abstract class _ThemeSettings implements ThemeSettings {
  const factory _ThemeSettings(
      {final ThemeMode themeMode,
      final bool highContrast,
      final bool useMaterialThemeFromSystem,
      final String customThemeColor,
      final bool useMaterialThemeOfPlayingItem,
      final bool useMaterialThemeOnItemPage}) = _$ThemeSettingsImpl;

  factory _ThemeSettings.fromJson(Map<String, dynamic> json) =
      _$ThemeSettingsImpl.fromJson;

  @override
  ThemeMode get themeMode;
  @override
  bool get highContrast;
  @override
  bool get useMaterialThemeFromSystem;
  @override
  String get customThemeColor;
  @override
  bool get useMaterialThemeOfPlayingItem;
  @override
  bool get useMaterialThemeOnItemPage;

  /// Create a copy of ThemeSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ThemeSettingsImplCopyWith<_$ThemeSettingsImpl> get copyWith =>
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
  double get speedIncrement => throw _privateConstructorUsedError;
  double get minSpeed => throw _privateConstructorUsedError;
  double get maxSpeed => throw _privateConstructorUsedError;
  Duration get minimumPositionForReporting =>
      throw _privateConstructorUsedError;
  Duration get playbackReportInterval => throw _privateConstructorUsedError;
  Duration get markCompleteWhenTimeLeft => throw _privateConstructorUsedError;
  bool get configurePlayerForEveryBook => throw _privateConstructorUsedError;

  /// Serializes this PlayerSettings to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PlayerSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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
      double speedIncrement,
      double minSpeed,
      double maxSpeed,
      Duration minimumPositionForReporting,
      Duration playbackReportInterval,
      Duration markCompleteWhenTimeLeft,
      bool configurePlayerForEveryBook});

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

  /// Create a copy of PlayerSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? miniPlayerSettings = null,
    Object? expandedPlayerSettings = null,
    Object? preferredDefaultVolume = null,
    Object? preferredDefaultSpeed = null,
    Object? speedOptions = null,
    Object? speedIncrement = null,
    Object? minSpeed = null,
    Object? maxSpeed = null,
    Object? minimumPositionForReporting = null,
    Object? playbackReportInterval = null,
    Object? markCompleteWhenTimeLeft = null,
    Object? configurePlayerForEveryBook = null,
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
      speedIncrement: null == speedIncrement
          ? _value.speedIncrement
          : speedIncrement // ignore: cast_nullable_to_non_nullable
              as double,
      minSpeed: null == minSpeed
          ? _value.minSpeed
          : minSpeed // ignore: cast_nullable_to_non_nullable
              as double,
      maxSpeed: null == maxSpeed
          ? _value.maxSpeed
          : maxSpeed // ignore: cast_nullable_to_non_nullable
              as double,
      minimumPositionForReporting: null == minimumPositionForReporting
          ? _value.minimumPositionForReporting
          : minimumPositionForReporting // ignore: cast_nullable_to_non_nullable
              as Duration,
      playbackReportInterval: null == playbackReportInterval
          ? _value.playbackReportInterval
          : playbackReportInterval // ignore: cast_nullable_to_non_nullable
              as Duration,
      markCompleteWhenTimeLeft: null == markCompleteWhenTimeLeft
          ? _value.markCompleteWhenTimeLeft
          : markCompleteWhenTimeLeft // ignore: cast_nullable_to_non_nullable
              as Duration,
      configurePlayerForEveryBook: null == configurePlayerForEveryBook
          ? _value.configurePlayerForEveryBook
          : configurePlayerForEveryBook // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  /// Create a copy of PlayerSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MinimizedPlayerSettingsCopyWith<$Res> get miniPlayerSettings {
    return $MinimizedPlayerSettingsCopyWith<$Res>(_value.miniPlayerSettings,
        (value) {
      return _then(_value.copyWith(miniPlayerSettings: value) as $Val);
    });
  }

  /// Create a copy of PlayerSettings
  /// with the given fields replaced by the non-null parameter values.
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
      double speedIncrement,
      double minSpeed,
      double maxSpeed,
      Duration minimumPositionForReporting,
      Duration playbackReportInterval,
      Duration markCompleteWhenTimeLeft,
      bool configurePlayerForEveryBook});

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

  /// Create a copy of PlayerSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? miniPlayerSettings = null,
    Object? expandedPlayerSettings = null,
    Object? preferredDefaultVolume = null,
    Object? preferredDefaultSpeed = null,
    Object? speedOptions = null,
    Object? speedIncrement = null,
    Object? minSpeed = null,
    Object? maxSpeed = null,
    Object? minimumPositionForReporting = null,
    Object? playbackReportInterval = null,
    Object? markCompleteWhenTimeLeft = null,
    Object? configurePlayerForEveryBook = null,
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
      speedIncrement: null == speedIncrement
          ? _value.speedIncrement
          : speedIncrement // ignore: cast_nullable_to_non_nullable
              as double,
      minSpeed: null == minSpeed
          ? _value.minSpeed
          : minSpeed // ignore: cast_nullable_to_non_nullable
              as double,
      maxSpeed: null == maxSpeed
          ? _value.maxSpeed
          : maxSpeed // ignore: cast_nullable_to_non_nullable
              as double,
      minimumPositionForReporting: null == minimumPositionForReporting
          ? _value.minimumPositionForReporting
          : minimumPositionForReporting // ignore: cast_nullable_to_non_nullable
              as Duration,
      playbackReportInterval: null == playbackReportInterval
          ? _value.playbackReportInterval
          : playbackReportInterval // ignore: cast_nullable_to_non_nullable
              as Duration,
      markCompleteWhenTimeLeft: null == markCompleteWhenTimeLeft
          ? _value.markCompleteWhenTimeLeft
          : markCompleteWhenTimeLeft // ignore: cast_nullable_to_non_nullable
              as Duration,
      configurePlayerForEveryBook: null == configurePlayerForEveryBook
          ? _value.configurePlayerForEveryBook
          : configurePlayerForEveryBook // ignore: cast_nullable_to_non_nullable
              as bool,
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
      final List<double> speedOptions = const [1, 1.25, 1.5, 1.75, 2],
      this.speedIncrement = 0.05,
      this.minSpeed = 0.1,
      this.maxSpeed = 4,
      this.minimumPositionForReporting = const Duration(seconds: 10),
      this.playbackReportInterval = const Duration(seconds: 10),
      this.markCompleteWhenTimeLeft = const Duration(seconds: 15),
      this.configurePlayerForEveryBook = true})
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
  final double speedIncrement;
  @override
  @JsonKey()
  final double minSpeed;
  @override
  @JsonKey()
  final double maxSpeed;
  @override
  @JsonKey()
  final Duration minimumPositionForReporting;
  @override
  @JsonKey()
  final Duration playbackReportInterval;
  @override
  @JsonKey()
  final Duration markCompleteWhenTimeLeft;
  @override
  @JsonKey()
  final bool configurePlayerForEveryBook;

  @override
  String toString() {
    return 'PlayerSettings(miniPlayerSettings: $miniPlayerSettings, expandedPlayerSettings: $expandedPlayerSettings, preferredDefaultVolume: $preferredDefaultVolume, preferredDefaultSpeed: $preferredDefaultSpeed, speedOptions: $speedOptions, speedIncrement: $speedIncrement, minSpeed: $minSpeed, maxSpeed: $maxSpeed, minimumPositionForReporting: $minimumPositionForReporting, playbackReportInterval: $playbackReportInterval, markCompleteWhenTimeLeft: $markCompleteWhenTimeLeft, configurePlayerForEveryBook: $configurePlayerForEveryBook)';
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
            (identical(other.speedIncrement, speedIncrement) ||
                other.speedIncrement == speedIncrement) &&
            (identical(other.minSpeed, minSpeed) ||
                other.minSpeed == minSpeed) &&
            (identical(other.maxSpeed, maxSpeed) ||
                other.maxSpeed == maxSpeed) &&
            (identical(other.minimumPositionForReporting,
                    minimumPositionForReporting) ||
                other.minimumPositionForReporting ==
                    minimumPositionForReporting) &&
            (identical(other.playbackReportInterval, playbackReportInterval) ||
                other.playbackReportInterval == playbackReportInterval) &&
            (identical(
                    other.markCompleteWhenTimeLeft, markCompleteWhenTimeLeft) ||
                other.markCompleteWhenTimeLeft == markCompleteWhenTimeLeft) &&
            (identical(other.configurePlayerForEveryBook,
                    configurePlayerForEveryBook) ||
                other.configurePlayerForEveryBook ==
                    configurePlayerForEveryBook));
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
      speedIncrement,
      minSpeed,
      maxSpeed,
      minimumPositionForReporting,
      playbackReportInterval,
      markCompleteWhenTimeLeft,
      configurePlayerForEveryBook);

  /// Create a copy of PlayerSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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
      final double speedIncrement,
      final double minSpeed,
      final double maxSpeed,
      final Duration minimumPositionForReporting,
      final Duration playbackReportInterval,
      final Duration markCompleteWhenTimeLeft,
      final bool configurePlayerForEveryBook}) = _$PlayerSettingsImpl;

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
  double get speedIncrement;
  @override
  double get minSpeed;
  @override
  double get maxSpeed;
  @override
  Duration get minimumPositionForReporting;
  @override
  Duration get playbackReportInterval;
  @override
  Duration get markCompleteWhenTimeLeft;
  @override
  bool get configurePlayerForEveryBook;

  /// Create a copy of PlayerSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
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

  /// Serializes this ExpandedPlayerSettings to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ExpandedPlayerSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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

  /// Create a copy of ExpandedPlayerSettings
  /// with the given fields replaced by the non-null parameter values.
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

  /// Create a copy of ExpandedPlayerSettings
  /// with the given fields replaced by the non-null parameter values.
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

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, showTotalProgress, showChapterProgress);

  /// Create a copy of ExpandedPlayerSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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

  /// Create a copy of ExpandedPlayerSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
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

  /// Serializes this MinimizedPlayerSettings to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MinimizedPlayerSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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

  /// Create a copy of MinimizedPlayerSettings
  /// with the given fields replaced by the non-null parameter values.
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

  /// Create a copy of MinimizedPlayerSettings
  /// with the given fields replaced by the non-null parameter values.
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

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, useChapterInfo);

  /// Create a copy of MinimizedPlayerSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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

  /// Create a copy of MinimizedPlayerSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MinimizedPlayerSettingsImplCopyWith<_$MinimizedPlayerSettingsImpl>
      get copyWith => throw _privateConstructorUsedError;
}

SleepTimerSettings _$SleepTimerSettingsFromJson(Map<String, dynamic> json) {
  return _SleepTimerSettings.fromJson(json);
}

/// @nodoc
mixin _$SleepTimerSettings {
  Duration get defaultDuration => throw _privateConstructorUsedError;
  List<Duration> get presetDurations => throw _privateConstructorUsedError;
  Duration get maxDuration => throw _privateConstructorUsedError;
  bool get fadeOutAudio => throw _privateConstructorUsedError;
  Duration get fadeOutDuration => throw _privateConstructorUsedError;

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

  /// Serializes this SleepTimerSettings to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SleepTimerSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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
      List<Duration> presetDurations,
      Duration maxDuration,
      bool fadeOutAudio,
      Duration fadeOutDuration,
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

  /// Create a copy of SleepTimerSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? defaultDuration = null,
    Object? presetDurations = null,
    Object? maxDuration = null,
    Object? fadeOutAudio = null,
    Object? fadeOutDuration = null,
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
      presetDurations: null == presetDurations
          ? _value.presetDurations
          : presetDurations // ignore: cast_nullable_to_non_nullable
              as List<Duration>,
      maxDuration: null == maxDuration
          ? _value.maxDuration
          : maxDuration // ignore: cast_nullable_to_non_nullable
              as Duration,
      fadeOutAudio: null == fadeOutAudio
          ? _value.fadeOutAudio
          : fadeOutAudio // ignore: cast_nullable_to_non_nullable
              as bool,
      fadeOutDuration: null == fadeOutDuration
          ? _value.fadeOutDuration
          : fadeOutDuration // ignore: cast_nullable_to_non_nullable
              as Duration,
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
      List<Duration> presetDurations,
      Duration maxDuration,
      bool fadeOutAudio,
      Duration fadeOutDuration,
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

  /// Create a copy of SleepTimerSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? defaultDuration = null,
    Object? presetDurations = null,
    Object? maxDuration = null,
    Object? fadeOutAudio = null,
    Object? fadeOutDuration = null,
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
      presetDurations: null == presetDurations
          ? _value._presetDurations
          : presetDurations // ignore: cast_nullable_to_non_nullable
              as List<Duration>,
      maxDuration: null == maxDuration
          ? _value.maxDuration
          : maxDuration // ignore: cast_nullable_to_non_nullable
              as Duration,
      fadeOutAudio: null == fadeOutAudio
          ? _value.fadeOutAudio
          : fadeOutAudio // ignore: cast_nullable_to_non_nullable
              as bool,
      fadeOutDuration: null == fadeOutDuration
          ? _value.fadeOutDuration
          : fadeOutDuration // ignore: cast_nullable_to_non_nullable
              as Duration,
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
      final List<Duration> presetDurations = const [
        Duration(minutes: 5),
        Duration(minutes: 10),
        Duration(minutes: 15),
        Duration(minutes: 20),
        Duration(minutes: 30)
      ],
      this.maxDuration = const Duration(minutes: 100),
      this.fadeOutAudio = false,
      this.fadeOutDuration = const Duration(seconds: 20),
      this.autoRewindWhenStopped = false,
      final Map<int, Duration> autoRewindDurations = const {
        5: Duration(seconds: 10),
        15: Duration(seconds: 30),
        45: Duration(seconds: 45),
        60: Duration(minutes: 1),
        120: Duration(minutes: 2)
      },
      this.autoTurnOnTimer = false,
      this.alwaysAutoTurnOnTimer = false,
      this.autoTurnOnTime = const Duration(hours: 22, minutes: 0),
      this.autoTurnOffTime = const Duration(hours: 6, minutes: 0)})
      : _presetDurations = presetDurations,
        _autoRewindDurations = autoRewindDurations;

  factory _$SleepTimerSettingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$SleepTimerSettingsImplFromJson(json);

  @override
  @JsonKey()
  final Duration defaultDuration;
  final List<Duration> _presetDurations;
  @override
  @JsonKey()
  List<Duration> get presetDurations {
    if (_presetDurations is EqualUnmodifiableListView) return _presetDurations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_presetDurations);
  }

  @override
  @JsonKey()
  final Duration maxDuration;
  @override
  @JsonKey()
  final bool fadeOutAudio;
  @override
  @JsonKey()
  final Duration fadeOutDuration;

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
    return 'SleepTimerSettings(defaultDuration: $defaultDuration, presetDurations: $presetDurations, maxDuration: $maxDuration, fadeOutAudio: $fadeOutAudio, fadeOutDuration: $fadeOutDuration, autoRewindWhenStopped: $autoRewindWhenStopped, autoRewindDurations: $autoRewindDurations, autoTurnOnTimer: $autoTurnOnTimer, alwaysAutoTurnOnTimer: $alwaysAutoTurnOnTimer, autoTurnOnTime: $autoTurnOnTime, autoTurnOffTime: $autoTurnOffTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SleepTimerSettingsImpl &&
            (identical(other.defaultDuration, defaultDuration) ||
                other.defaultDuration == defaultDuration) &&
            const DeepCollectionEquality()
                .equals(other._presetDurations, _presetDurations) &&
            (identical(other.maxDuration, maxDuration) ||
                other.maxDuration == maxDuration) &&
            (identical(other.fadeOutAudio, fadeOutAudio) ||
                other.fadeOutAudio == fadeOutAudio) &&
            (identical(other.fadeOutDuration, fadeOutDuration) ||
                other.fadeOutDuration == fadeOutDuration) &&
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

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      defaultDuration,
      const DeepCollectionEquality().hash(_presetDurations),
      maxDuration,
      fadeOutAudio,
      fadeOutDuration,
      autoRewindWhenStopped,
      const DeepCollectionEquality().hash(_autoRewindDurations),
      autoTurnOnTimer,
      alwaysAutoTurnOnTimer,
      autoTurnOnTime,
      autoTurnOffTime);

  /// Create a copy of SleepTimerSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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
      final List<Duration> presetDurations,
      final Duration maxDuration,
      final bool fadeOutAudio,
      final Duration fadeOutDuration,
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
  List<Duration> get presetDurations;
  @override
  Duration get maxDuration;
  @override
  bool get fadeOutAudio;
  @override
  Duration get fadeOutDuration;

  /// if true, the player will automatically rewind the audio when the sleep timer is stopped
  @override
  bool get autoRewindWhenStopped;

  /// the key is the duration in minutes
  @override
  Map<int, Duration> get autoRewindDurations;

  /// auto turn on timer settings
  @override
  bool get autoTurnOnTimer;

  /// always auto turn on timer settings or during specific times
  @override
  bool get alwaysAutoTurnOnTimer;

  /// auto timer settings, only used if [alwaysAutoTurnOnTimer] is false
  ///
  /// duration is the time from 00:00
  @override
  Duration get autoTurnOnTime;
  @override
  Duration get autoTurnOffTime;

  /// Create a copy of SleepTimerSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SleepTimerSettingsImplCopyWith<_$SleepTimerSettingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DownloadSettings _$DownloadSettingsFromJson(Map<String, dynamic> json) {
  return _DownloadSettings.fromJson(json);
}

/// @nodoc
mixin _$DownloadSettings {
  bool get requiresWiFi => throw _privateConstructorUsedError;
  int get retries => throw _privateConstructorUsedError;
  bool get allowPause => throw _privateConstructorUsedError;
  int get maxConcurrent => throw _privateConstructorUsedError;
  int get maxConcurrentByHost => throw _privateConstructorUsedError;
  int get maxConcurrentByGroup => throw _privateConstructorUsedError;

  /// Serializes this DownloadSettings to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DownloadSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DownloadSettingsCopyWith<DownloadSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DownloadSettingsCopyWith<$Res> {
  factory $DownloadSettingsCopyWith(
          DownloadSettings value, $Res Function(DownloadSettings) then) =
      _$DownloadSettingsCopyWithImpl<$Res, DownloadSettings>;
  @useResult
  $Res call(
      {bool requiresWiFi,
      int retries,
      bool allowPause,
      int maxConcurrent,
      int maxConcurrentByHost,
      int maxConcurrentByGroup});
}

/// @nodoc
class _$DownloadSettingsCopyWithImpl<$Res, $Val extends DownloadSettings>
    implements $DownloadSettingsCopyWith<$Res> {
  _$DownloadSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DownloadSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? requiresWiFi = null,
    Object? retries = null,
    Object? allowPause = null,
    Object? maxConcurrent = null,
    Object? maxConcurrentByHost = null,
    Object? maxConcurrentByGroup = null,
  }) {
    return _then(_value.copyWith(
      requiresWiFi: null == requiresWiFi
          ? _value.requiresWiFi
          : requiresWiFi // ignore: cast_nullable_to_non_nullable
              as bool,
      retries: null == retries
          ? _value.retries
          : retries // ignore: cast_nullable_to_non_nullable
              as int,
      allowPause: null == allowPause
          ? _value.allowPause
          : allowPause // ignore: cast_nullable_to_non_nullable
              as bool,
      maxConcurrent: null == maxConcurrent
          ? _value.maxConcurrent
          : maxConcurrent // ignore: cast_nullable_to_non_nullable
              as int,
      maxConcurrentByHost: null == maxConcurrentByHost
          ? _value.maxConcurrentByHost
          : maxConcurrentByHost // ignore: cast_nullable_to_non_nullable
              as int,
      maxConcurrentByGroup: null == maxConcurrentByGroup
          ? _value.maxConcurrentByGroup
          : maxConcurrentByGroup // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DownloadSettingsImplCopyWith<$Res>
    implements $DownloadSettingsCopyWith<$Res> {
  factory _$$DownloadSettingsImplCopyWith(_$DownloadSettingsImpl value,
          $Res Function(_$DownloadSettingsImpl) then) =
      __$$DownloadSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool requiresWiFi,
      int retries,
      bool allowPause,
      int maxConcurrent,
      int maxConcurrentByHost,
      int maxConcurrentByGroup});
}

/// @nodoc
class __$$DownloadSettingsImplCopyWithImpl<$Res>
    extends _$DownloadSettingsCopyWithImpl<$Res, _$DownloadSettingsImpl>
    implements _$$DownloadSettingsImplCopyWith<$Res> {
  __$$DownloadSettingsImplCopyWithImpl(_$DownloadSettingsImpl _value,
      $Res Function(_$DownloadSettingsImpl) _then)
      : super(_value, _then);

  /// Create a copy of DownloadSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? requiresWiFi = null,
    Object? retries = null,
    Object? allowPause = null,
    Object? maxConcurrent = null,
    Object? maxConcurrentByHost = null,
    Object? maxConcurrentByGroup = null,
  }) {
    return _then(_$DownloadSettingsImpl(
      requiresWiFi: null == requiresWiFi
          ? _value.requiresWiFi
          : requiresWiFi // ignore: cast_nullable_to_non_nullable
              as bool,
      retries: null == retries
          ? _value.retries
          : retries // ignore: cast_nullable_to_non_nullable
              as int,
      allowPause: null == allowPause
          ? _value.allowPause
          : allowPause // ignore: cast_nullable_to_non_nullable
              as bool,
      maxConcurrent: null == maxConcurrent
          ? _value.maxConcurrent
          : maxConcurrent // ignore: cast_nullable_to_non_nullable
              as int,
      maxConcurrentByHost: null == maxConcurrentByHost
          ? _value.maxConcurrentByHost
          : maxConcurrentByHost // ignore: cast_nullable_to_non_nullable
              as int,
      maxConcurrentByGroup: null == maxConcurrentByGroup
          ? _value.maxConcurrentByGroup
          : maxConcurrentByGroup // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DownloadSettingsImpl implements _DownloadSettings {
  const _$DownloadSettingsImpl(
      {this.requiresWiFi = true,
      this.retries = 3,
      this.allowPause = true,
      this.maxConcurrent = 3,
      this.maxConcurrentByHost = 3,
      this.maxConcurrentByGroup = 3});

  factory _$DownloadSettingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$DownloadSettingsImplFromJson(json);

  @override
  @JsonKey()
  final bool requiresWiFi;
  @override
  @JsonKey()
  final int retries;
  @override
  @JsonKey()
  final bool allowPause;
  @override
  @JsonKey()
  final int maxConcurrent;
  @override
  @JsonKey()
  final int maxConcurrentByHost;
  @override
  @JsonKey()
  final int maxConcurrentByGroup;

  @override
  String toString() {
    return 'DownloadSettings(requiresWiFi: $requiresWiFi, retries: $retries, allowPause: $allowPause, maxConcurrent: $maxConcurrent, maxConcurrentByHost: $maxConcurrentByHost, maxConcurrentByGroup: $maxConcurrentByGroup)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DownloadSettingsImpl &&
            (identical(other.requiresWiFi, requiresWiFi) ||
                other.requiresWiFi == requiresWiFi) &&
            (identical(other.retries, retries) || other.retries == retries) &&
            (identical(other.allowPause, allowPause) ||
                other.allowPause == allowPause) &&
            (identical(other.maxConcurrent, maxConcurrent) ||
                other.maxConcurrent == maxConcurrent) &&
            (identical(other.maxConcurrentByHost, maxConcurrentByHost) ||
                other.maxConcurrentByHost == maxConcurrentByHost) &&
            (identical(other.maxConcurrentByGroup, maxConcurrentByGroup) ||
                other.maxConcurrentByGroup == maxConcurrentByGroup));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, requiresWiFi, retries,
      allowPause, maxConcurrent, maxConcurrentByHost, maxConcurrentByGroup);

  /// Create a copy of DownloadSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DownloadSettingsImplCopyWith<_$DownloadSettingsImpl> get copyWith =>
      __$$DownloadSettingsImplCopyWithImpl<_$DownloadSettingsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DownloadSettingsImplToJson(
      this,
    );
  }
}

abstract class _DownloadSettings implements DownloadSettings {
  const factory _DownloadSettings(
      {final bool requiresWiFi,
      final int retries,
      final bool allowPause,
      final int maxConcurrent,
      final int maxConcurrentByHost,
      final int maxConcurrentByGroup}) = _$DownloadSettingsImpl;

  factory _DownloadSettings.fromJson(Map<String, dynamic> json) =
      _$DownloadSettingsImpl.fromJson;

  @override
  bool get requiresWiFi;
  @override
  int get retries;
  @override
  bool get allowPause;
  @override
  int get maxConcurrent;
  @override
  int get maxConcurrentByHost;
  @override
  int get maxConcurrentByGroup;

  /// Create a copy of DownloadSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DownloadSettingsImplCopyWith<_$DownloadSettingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

NotificationSettings _$NotificationSettingsFromJson(Map<String, dynamic> json) {
  return _NotificationSettings.fromJson(json);
}

/// @nodoc
mixin _$NotificationSettings {
  Duration get fastForwardInterval => throw _privateConstructorUsedError;
  Duration get rewindInterval => throw _privateConstructorUsedError;
  bool get progressBarIsChapterProgress => throw _privateConstructorUsedError;
  String get primaryTitle => throw _privateConstructorUsedError;
  String get secondaryTitle => throw _privateConstructorUsedError;
  List<NotificationMediaControl> get mediaControls =>
      throw _privateConstructorUsedError;

  /// Serializes this NotificationSettings to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NotificationSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NotificationSettingsCopyWith<NotificationSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationSettingsCopyWith<$Res> {
  factory $NotificationSettingsCopyWith(NotificationSettings value,
          $Res Function(NotificationSettings) then) =
      _$NotificationSettingsCopyWithImpl<$Res, NotificationSettings>;
  @useResult
  $Res call(
      {Duration fastForwardInterval,
      Duration rewindInterval,
      bool progressBarIsChapterProgress,
      String primaryTitle,
      String secondaryTitle,
      List<NotificationMediaControl> mediaControls});
}

/// @nodoc
class _$NotificationSettingsCopyWithImpl<$Res,
        $Val extends NotificationSettings>
    implements $NotificationSettingsCopyWith<$Res> {
  _$NotificationSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NotificationSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fastForwardInterval = null,
    Object? rewindInterval = null,
    Object? progressBarIsChapterProgress = null,
    Object? primaryTitle = null,
    Object? secondaryTitle = null,
    Object? mediaControls = null,
  }) {
    return _then(_value.copyWith(
      fastForwardInterval: null == fastForwardInterval
          ? _value.fastForwardInterval
          : fastForwardInterval // ignore: cast_nullable_to_non_nullable
              as Duration,
      rewindInterval: null == rewindInterval
          ? _value.rewindInterval
          : rewindInterval // ignore: cast_nullable_to_non_nullable
              as Duration,
      progressBarIsChapterProgress: null == progressBarIsChapterProgress
          ? _value.progressBarIsChapterProgress
          : progressBarIsChapterProgress // ignore: cast_nullable_to_non_nullable
              as bool,
      primaryTitle: null == primaryTitle
          ? _value.primaryTitle
          : primaryTitle // ignore: cast_nullable_to_non_nullable
              as String,
      secondaryTitle: null == secondaryTitle
          ? _value.secondaryTitle
          : secondaryTitle // ignore: cast_nullable_to_non_nullable
              as String,
      mediaControls: null == mediaControls
          ? _value.mediaControls
          : mediaControls // ignore: cast_nullable_to_non_nullable
              as List<NotificationMediaControl>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NotificationSettingsImplCopyWith<$Res>
    implements $NotificationSettingsCopyWith<$Res> {
  factory _$$NotificationSettingsImplCopyWith(_$NotificationSettingsImpl value,
          $Res Function(_$NotificationSettingsImpl) then) =
      __$$NotificationSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Duration fastForwardInterval,
      Duration rewindInterval,
      bool progressBarIsChapterProgress,
      String primaryTitle,
      String secondaryTitle,
      List<NotificationMediaControl> mediaControls});
}

/// @nodoc
class __$$NotificationSettingsImplCopyWithImpl<$Res>
    extends _$NotificationSettingsCopyWithImpl<$Res, _$NotificationSettingsImpl>
    implements _$$NotificationSettingsImplCopyWith<$Res> {
  __$$NotificationSettingsImplCopyWithImpl(_$NotificationSettingsImpl _value,
      $Res Function(_$NotificationSettingsImpl) _then)
      : super(_value, _then);

  /// Create a copy of NotificationSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fastForwardInterval = null,
    Object? rewindInterval = null,
    Object? progressBarIsChapterProgress = null,
    Object? primaryTitle = null,
    Object? secondaryTitle = null,
    Object? mediaControls = null,
  }) {
    return _then(_$NotificationSettingsImpl(
      fastForwardInterval: null == fastForwardInterval
          ? _value.fastForwardInterval
          : fastForwardInterval // ignore: cast_nullable_to_non_nullable
              as Duration,
      rewindInterval: null == rewindInterval
          ? _value.rewindInterval
          : rewindInterval // ignore: cast_nullable_to_non_nullable
              as Duration,
      progressBarIsChapterProgress: null == progressBarIsChapterProgress
          ? _value.progressBarIsChapterProgress
          : progressBarIsChapterProgress // ignore: cast_nullable_to_non_nullable
              as bool,
      primaryTitle: null == primaryTitle
          ? _value.primaryTitle
          : primaryTitle // ignore: cast_nullable_to_non_nullable
              as String,
      secondaryTitle: null == secondaryTitle
          ? _value.secondaryTitle
          : secondaryTitle // ignore: cast_nullable_to_non_nullable
              as String,
      mediaControls: null == mediaControls
          ? _value._mediaControls
          : mediaControls // ignore: cast_nullable_to_non_nullable
              as List<NotificationMediaControl>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NotificationSettingsImpl implements _NotificationSettings {
  const _$NotificationSettingsImpl(
      {this.fastForwardInterval = const Duration(seconds: 30),
      this.rewindInterval = const Duration(seconds: 10),
      this.progressBarIsChapterProgress = true,
      this.primaryTitle = '\$bookTitle',
      this.secondaryTitle = '\$author',
      final List<NotificationMediaControl> mediaControls = const [
        NotificationMediaControl.rewind,
        NotificationMediaControl.fastForward,
        NotificationMediaControl.skipToPreviousChapter,
        NotificationMediaControl.skipToNextChapter
      ]})
      : _mediaControls = mediaControls;

  factory _$NotificationSettingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$NotificationSettingsImplFromJson(json);

  @override
  @JsonKey()
  final Duration fastForwardInterval;
  @override
  @JsonKey()
  final Duration rewindInterval;
  @override
  @JsonKey()
  final bool progressBarIsChapterProgress;
  @override
  @JsonKey()
  final String primaryTitle;
  @override
  @JsonKey()
  final String secondaryTitle;
  final List<NotificationMediaControl> _mediaControls;
  @override
  @JsonKey()
  List<NotificationMediaControl> get mediaControls {
    if (_mediaControls is EqualUnmodifiableListView) return _mediaControls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_mediaControls);
  }

  @override
  String toString() {
    return 'NotificationSettings(fastForwardInterval: $fastForwardInterval, rewindInterval: $rewindInterval, progressBarIsChapterProgress: $progressBarIsChapterProgress, primaryTitle: $primaryTitle, secondaryTitle: $secondaryTitle, mediaControls: $mediaControls)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationSettingsImpl &&
            (identical(other.fastForwardInterval, fastForwardInterval) ||
                other.fastForwardInterval == fastForwardInterval) &&
            (identical(other.rewindInterval, rewindInterval) ||
                other.rewindInterval == rewindInterval) &&
            (identical(other.progressBarIsChapterProgress,
                    progressBarIsChapterProgress) ||
                other.progressBarIsChapterProgress ==
                    progressBarIsChapterProgress) &&
            (identical(other.primaryTitle, primaryTitle) ||
                other.primaryTitle == primaryTitle) &&
            (identical(other.secondaryTitle, secondaryTitle) ||
                other.secondaryTitle == secondaryTitle) &&
            const DeepCollectionEquality()
                .equals(other._mediaControls, _mediaControls));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      fastForwardInterval,
      rewindInterval,
      progressBarIsChapterProgress,
      primaryTitle,
      secondaryTitle,
      const DeepCollectionEquality().hash(_mediaControls));

  /// Create a copy of NotificationSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationSettingsImplCopyWith<_$NotificationSettingsImpl>
      get copyWith =>
          __$$NotificationSettingsImplCopyWithImpl<_$NotificationSettingsImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NotificationSettingsImplToJson(
      this,
    );
  }
}

abstract class _NotificationSettings implements NotificationSettings {
  const factory _NotificationSettings(
          {final Duration fastForwardInterval,
          final Duration rewindInterval,
          final bool progressBarIsChapterProgress,
          final String primaryTitle,
          final String secondaryTitle,
          final List<NotificationMediaControl> mediaControls}) =
      _$NotificationSettingsImpl;

  factory _NotificationSettings.fromJson(Map<String, dynamic> json) =
      _$NotificationSettingsImpl.fromJson;

  @override
  Duration get fastForwardInterval;
  @override
  Duration get rewindInterval;
  @override
  bool get progressBarIsChapterProgress;
  @override
  String get primaryTitle;
  @override
  String get secondaryTitle;
  @override
  List<NotificationMediaControl> get mediaControls;

  /// Create a copy of NotificationSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NotificationSettingsImplCopyWith<_$NotificationSettingsImpl>
      get copyWith => throw _privateConstructorUsedError;
}

ShakeDetectionSettings _$ShakeDetectionSettingsFromJson(
    Map<String, dynamic> json) {
  return _ShakeDetectionSettings.fromJson(json);
}

/// @nodoc
mixin _$ShakeDetectionSettings {
  bool get isEnabled => throw _privateConstructorUsedError;
  ShakeDirection get direction => throw _privateConstructorUsedError;
  double get threshold => throw _privateConstructorUsedError;
  ShakeAction get shakeAction => throw _privateConstructorUsedError;
  Set<ShakeDetectedFeedback> get feedback => throw _privateConstructorUsedError;
  double get beepVolume => throw _privateConstructorUsedError;

  /// the duration to wait before the shake detection is enabled again
  Duration get shakeTriggerCoolDown => throw _privateConstructorUsedError;

  /// the number of shakes required to trigger the action
  int get shakeTriggerCount => throw _privateConstructorUsedError;

  /// acceleration sampling interval
  Duration get samplingPeriod => throw _privateConstructorUsedError;

  /// Serializes this ShakeDetectionSettings to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ShakeDetectionSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ShakeDetectionSettingsCopyWith<ShakeDetectionSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShakeDetectionSettingsCopyWith<$Res> {
  factory $ShakeDetectionSettingsCopyWith(ShakeDetectionSettings value,
          $Res Function(ShakeDetectionSettings) then) =
      _$ShakeDetectionSettingsCopyWithImpl<$Res, ShakeDetectionSettings>;
  @useResult
  $Res call(
      {bool isEnabled,
      ShakeDirection direction,
      double threshold,
      ShakeAction shakeAction,
      Set<ShakeDetectedFeedback> feedback,
      double beepVolume,
      Duration shakeTriggerCoolDown,
      int shakeTriggerCount,
      Duration samplingPeriod});
}

/// @nodoc
class _$ShakeDetectionSettingsCopyWithImpl<$Res,
        $Val extends ShakeDetectionSettings>
    implements $ShakeDetectionSettingsCopyWith<$Res> {
  _$ShakeDetectionSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ShakeDetectionSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isEnabled = null,
    Object? direction = null,
    Object? threshold = null,
    Object? shakeAction = null,
    Object? feedback = null,
    Object? beepVolume = null,
    Object? shakeTriggerCoolDown = null,
    Object? shakeTriggerCount = null,
    Object? samplingPeriod = null,
  }) {
    return _then(_value.copyWith(
      isEnabled: null == isEnabled
          ? _value.isEnabled
          : isEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      direction: null == direction
          ? _value.direction
          : direction // ignore: cast_nullable_to_non_nullable
              as ShakeDirection,
      threshold: null == threshold
          ? _value.threshold
          : threshold // ignore: cast_nullable_to_non_nullable
              as double,
      shakeAction: null == shakeAction
          ? _value.shakeAction
          : shakeAction // ignore: cast_nullable_to_non_nullable
              as ShakeAction,
      feedback: null == feedback
          ? _value.feedback
          : feedback // ignore: cast_nullable_to_non_nullable
              as Set<ShakeDetectedFeedback>,
      beepVolume: null == beepVolume
          ? _value.beepVolume
          : beepVolume // ignore: cast_nullable_to_non_nullable
              as double,
      shakeTriggerCoolDown: null == shakeTriggerCoolDown
          ? _value.shakeTriggerCoolDown
          : shakeTriggerCoolDown // ignore: cast_nullable_to_non_nullable
              as Duration,
      shakeTriggerCount: null == shakeTriggerCount
          ? _value.shakeTriggerCount
          : shakeTriggerCount // ignore: cast_nullable_to_non_nullable
              as int,
      samplingPeriod: null == samplingPeriod
          ? _value.samplingPeriod
          : samplingPeriod // ignore: cast_nullable_to_non_nullable
              as Duration,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ShakeDetectionSettingsImplCopyWith<$Res>
    implements $ShakeDetectionSettingsCopyWith<$Res> {
  factory _$$ShakeDetectionSettingsImplCopyWith(
          _$ShakeDetectionSettingsImpl value,
          $Res Function(_$ShakeDetectionSettingsImpl) then) =
      __$$ShakeDetectionSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isEnabled,
      ShakeDirection direction,
      double threshold,
      ShakeAction shakeAction,
      Set<ShakeDetectedFeedback> feedback,
      double beepVolume,
      Duration shakeTriggerCoolDown,
      int shakeTriggerCount,
      Duration samplingPeriod});
}

/// @nodoc
class __$$ShakeDetectionSettingsImplCopyWithImpl<$Res>
    extends _$ShakeDetectionSettingsCopyWithImpl<$Res,
        _$ShakeDetectionSettingsImpl>
    implements _$$ShakeDetectionSettingsImplCopyWith<$Res> {
  __$$ShakeDetectionSettingsImplCopyWithImpl(
      _$ShakeDetectionSettingsImpl _value,
      $Res Function(_$ShakeDetectionSettingsImpl) _then)
      : super(_value, _then);

  /// Create a copy of ShakeDetectionSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isEnabled = null,
    Object? direction = null,
    Object? threshold = null,
    Object? shakeAction = null,
    Object? feedback = null,
    Object? beepVolume = null,
    Object? shakeTriggerCoolDown = null,
    Object? shakeTriggerCount = null,
    Object? samplingPeriod = null,
  }) {
    return _then(_$ShakeDetectionSettingsImpl(
      isEnabled: null == isEnabled
          ? _value.isEnabled
          : isEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      direction: null == direction
          ? _value.direction
          : direction // ignore: cast_nullable_to_non_nullable
              as ShakeDirection,
      threshold: null == threshold
          ? _value.threshold
          : threshold // ignore: cast_nullable_to_non_nullable
              as double,
      shakeAction: null == shakeAction
          ? _value.shakeAction
          : shakeAction // ignore: cast_nullable_to_non_nullable
              as ShakeAction,
      feedback: null == feedback
          ? _value._feedback
          : feedback // ignore: cast_nullable_to_non_nullable
              as Set<ShakeDetectedFeedback>,
      beepVolume: null == beepVolume
          ? _value.beepVolume
          : beepVolume // ignore: cast_nullable_to_non_nullable
              as double,
      shakeTriggerCoolDown: null == shakeTriggerCoolDown
          ? _value.shakeTriggerCoolDown
          : shakeTriggerCoolDown // ignore: cast_nullable_to_non_nullable
              as Duration,
      shakeTriggerCount: null == shakeTriggerCount
          ? _value.shakeTriggerCount
          : shakeTriggerCount // ignore: cast_nullable_to_non_nullable
              as int,
      samplingPeriod: null == samplingPeriod
          ? _value.samplingPeriod
          : samplingPeriod // ignore: cast_nullable_to_non_nullable
              as Duration,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ShakeDetectionSettingsImpl implements _ShakeDetectionSettings {
  const _$ShakeDetectionSettingsImpl(
      {this.isEnabled = true,
      this.direction = ShakeDirection.horizontal,
      this.threshold = 5,
      this.shakeAction = ShakeAction.resetSleepTimer,
      final Set<ShakeDetectedFeedback> feedback = const {
        ShakeDetectedFeedback.vibrate
      },
      this.beepVolume = 0.5,
      this.shakeTriggerCoolDown = const Duration(seconds: 2),
      this.shakeTriggerCount = 2,
      this.samplingPeriod = const Duration(milliseconds: 100)})
      : _feedback = feedback;

  factory _$ShakeDetectionSettingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$ShakeDetectionSettingsImplFromJson(json);

  @override
  @JsonKey()
  final bool isEnabled;
  @override
  @JsonKey()
  final ShakeDirection direction;
  @override
  @JsonKey()
  final double threshold;
  @override
  @JsonKey()
  final ShakeAction shakeAction;
  final Set<ShakeDetectedFeedback> _feedback;
  @override
  @JsonKey()
  Set<ShakeDetectedFeedback> get feedback {
    if (_feedback is EqualUnmodifiableSetView) return _feedback;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_feedback);
  }

  @override
  @JsonKey()
  final double beepVolume;

  /// the duration to wait before the shake detection is enabled again
  @override
  @JsonKey()
  final Duration shakeTriggerCoolDown;

  /// the number of shakes required to trigger the action
  @override
  @JsonKey()
  final int shakeTriggerCount;

  /// acceleration sampling interval
  @override
  @JsonKey()
  final Duration samplingPeriod;

  @override
  String toString() {
    return 'ShakeDetectionSettings(isEnabled: $isEnabled, direction: $direction, threshold: $threshold, shakeAction: $shakeAction, feedback: $feedback, beepVolume: $beepVolume, shakeTriggerCoolDown: $shakeTriggerCoolDown, shakeTriggerCount: $shakeTriggerCount, samplingPeriod: $samplingPeriod)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShakeDetectionSettingsImpl &&
            (identical(other.isEnabled, isEnabled) ||
                other.isEnabled == isEnabled) &&
            (identical(other.direction, direction) ||
                other.direction == direction) &&
            (identical(other.threshold, threshold) ||
                other.threshold == threshold) &&
            (identical(other.shakeAction, shakeAction) ||
                other.shakeAction == shakeAction) &&
            const DeepCollectionEquality().equals(other._feedback, _feedback) &&
            (identical(other.beepVolume, beepVolume) ||
                other.beepVolume == beepVolume) &&
            (identical(other.shakeTriggerCoolDown, shakeTriggerCoolDown) ||
                other.shakeTriggerCoolDown == shakeTriggerCoolDown) &&
            (identical(other.shakeTriggerCount, shakeTriggerCount) ||
                other.shakeTriggerCount == shakeTriggerCount) &&
            (identical(other.samplingPeriod, samplingPeriod) ||
                other.samplingPeriod == samplingPeriod));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      isEnabled,
      direction,
      threshold,
      shakeAction,
      const DeepCollectionEquality().hash(_feedback),
      beepVolume,
      shakeTriggerCoolDown,
      shakeTriggerCount,
      samplingPeriod);

  /// Create a copy of ShakeDetectionSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ShakeDetectionSettingsImplCopyWith<_$ShakeDetectionSettingsImpl>
      get copyWith => __$$ShakeDetectionSettingsImplCopyWithImpl<
          _$ShakeDetectionSettingsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ShakeDetectionSettingsImplToJson(
      this,
    );
  }
}

abstract class _ShakeDetectionSettings implements ShakeDetectionSettings {
  const factory _ShakeDetectionSettings(
      {final bool isEnabled,
      final ShakeDirection direction,
      final double threshold,
      final ShakeAction shakeAction,
      final Set<ShakeDetectedFeedback> feedback,
      final double beepVolume,
      final Duration shakeTriggerCoolDown,
      final int shakeTriggerCount,
      final Duration samplingPeriod}) = _$ShakeDetectionSettingsImpl;

  factory _ShakeDetectionSettings.fromJson(Map<String, dynamic> json) =
      _$ShakeDetectionSettingsImpl.fromJson;

  @override
  bool get isEnabled;
  @override
  ShakeDirection get direction;
  @override
  double get threshold;
  @override
  ShakeAction get shakeAction;
  @override
  Set<ShakeDetectedFeedback> get feedback;
  @override
  double get beepVolume;

  /// the duration to wait before the shake detection is enabled again
  @override
  Duration get shakeTriggerCoolDown;

  /// the number of shakes required to trigger the action
  @override
  int get shakeTriggerCount;

  /// acceleration sampling interval
  @override
  Duration get samplingPeriod;

  /// Create a copy of ShakeDetectionSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ShakeDetectionSettingsImplCopyWith<_$ShakeDetectionSettingsImpl>
      get copyWith => throw _privateConstructorUsedError;
}
