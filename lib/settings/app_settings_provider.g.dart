// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_settings_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$appSettingsHash() => r'f51d55f117692d4fb9f4b4febf02906c0953d334';

/// See also [AppSettings].
@ProviderFor(AppSettings)
final appSettingsProvider =
    NotifierProvider<AppSettings, model.AppSettings>.internal(
  AppSettings.new,
  name: r'appSettingsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$appSettingsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AppSettings = Notifier<model.AppSettings>;
String _$sleepTimerSettingsHash() =>
    r'85bb3d3fb292b9a3a5b771d86e5fc57718519c69';

/// See also [SleepTimerSettings].
@ProviderFor(SleepTimerSettings)
final sleepTimerSettingsProvider =
    NotifierProvider<SleepTimerSettings, model.SleepTimerSettings>.internal(
  SleepTimerSettings.new,
  name: r'sleepTimerSettingsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$sleepTimerSettingsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SleepTimerSettings = Notifier<model.SleepTimerSettings>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
