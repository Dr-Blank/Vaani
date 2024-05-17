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
  $Res call({MinimizedPlayerSettings miniPlayerSettings});

  $MinimizedPlayerSettingsCopyWith<$Res> get miniPlayerSettings;
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
  }) {
    return _then(_value.copyWith(
      miniPlayerSettings: null == miniPlayerSettings
          ? _value.miniPlayerSettings
          : miniPlayerSettings // ignore: cast_nullable_to_non_nullable
              as MinimizedPlayerSettings,
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
}

/// @nodoc
abstract class _$$PlayerSettingsImplCopyWith<$Res>
    implements $PlayerSettingsCopyWith<$Res> {
  factory _$$PlayerSettingsImplCopyWith(_$PlayerSettingsImpl value,
          $Res Function(_$PlayerSettingsImpl) then) =
      __$$PlayerSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({MinimizedPlayerSettings miniPlayerSettings});

  @override
  $MinimizedPlayerSettingsCopyWith<$Res> get miniPlayerSettings;
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
  }) {
    return _then(_$PlayerSettingsImpl(
      miniPlayerSettings: null == miniPlayerSettings
          ? _value.miniPlayerSettings
          : miniPlayerSettings // ignore: cast_nullable_to_non_nullable
              as MinimizedPlayerSettings,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PlayerSettingsImpl implements _PlayerSettings {
  const _$PlayerSettingsImpl(
      {this.miniPlayerSettings = const MinimizedPlayerSettings()});

  factory _$PlayerSettingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$PlayerSettingsImplFromJson(json);

  @override
  @JsonKey()
  final MinimizedPlayerSettings miniPlayerSettings;

  @override
  String toString() {
    return 'PlayerSettings(miniPlayerSettings: $miniPlayerSettings)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlayerSettingsImpl &&
            (identical(other.miniPlayerSettings, miniPlayerSettings) ||
                other.miniPlayerSettings == miniPlayerSettings));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, miniPlayerSettings);

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
          {final MinimizedPlayerSettings miniPlayerSettings}) =
      _$PlayerSettingsImpl;

  factory _PlayerSettings.fromJson(Map<String, dynamic> json) =
      _$PlayerSettingsImpl.fromJson;

  @override
  MinimizedPlayerSettings get miniPlayerSettings;
  @override
  @JsonKey(ignore: true)
  _$$PlayerSettingsImplCopyWith<_$PlayerSettingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MinimizedPlayerSettings _$MinimizedPlayerSettingsFromJson(
    Map<String, dynamic> json) {
  return _MiniPlayerSettings.fromJson(json);
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
abstract class _$$MiniPlayerSettingsImplCopyWith<$Res>
    implements $MinimizedPlayerSettingsCopyWith<$Res> {
  factory _$$MiniPlayerSettingsImplCopyWith(_$MiniPlayerSettingsImpl value,
          $Res Function(_$MiniPlayerSettingsImpl) then) =
      __$$MiniPlayerSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool useChapterInfo});
}

/// @nodoc
class __$$MiniPlayerSettingsImplCopyWithImpl<$Res>
    extends _$MinimizedPlayerSettingsCopyWithImpl<$Res,
        _$MiniPlayerSettingsImpl>
    implements _$$MiniPlayerSettingsImplCopyWith<$Res> {
  __$$MiniPlayerSettingsImplCopyWithImpl(_$MiniPlayerSettingsImpl _value,
      $Res Function(_$MiniPlayerSettingsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? useChapterInfo = null,
  }) {
    return _then(_$MiniPlayerSettingsImpl(
      useChapterInfo: null == useChapterInfo
          ? _value.useChapterInfo
          : useChapterInfo // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MiniPlayerSettingsImpl implements _MiniPlayerSettings {
  const _$MiniPlayerSettingsImpl({this.useChapterInfo = false});

  factory _$MiniPlayerSettingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$MiniPlayerSettingsImplFromJson(json);

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
            other is _$MiniPlayerSettingsImpl &&
            (identical(other.useChapterInfo, useChapterInfo) ||
                other.useChapterInfo == useChapterInfo));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, useChapterInfo);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MiniPlayerSettingsImplCopyWith<_$MiniPlayerSettingsImpl> get copyWith =>
      __$$MiniPlayerSettingsImplCopyWithImpl<_$MiniPlayerSettingsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MiniPlayerSettingsImplToJson(
      this,
    );
  }
}

abstract class _MiniPlayerSettings implements MinimizedPlayerSettings {
  const factory _MiniPlayerSettings({final bool useChapterInfo}) =
      _$MiniPlayerSettingsImpl;

  factory _MiniPlayerSettings.fromJson(Map<String, dynamic> json) =
      _$MiniPlayerSettingsImpl.fromJson;

  @override
  bool get useChapterInfo;
  @override
  @JsonKey(ignore: true)
  _$$MiniPlayerSettingsImplCopyWith<_$MiniPlayerSettingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
