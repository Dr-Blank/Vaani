import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'metadata_provider.g.dart';

@Riverpod(keepAlive: true)
Future<String> deviceName(Ref ref) async {
  final data = await _getDeviceData(DeviceInfoPlugin());

  // try different keys to get the device name
  return
      // android
      data['product'] ??
          // ios
          data['name'] ??
          // linux
          data['name'] ??
          // windows
          data['computerName'] ??
          // macos
          data['model'] ??
          // web
          data['browserName'] ??
          'Unknown name';
}

@Riverpod(keepAlive: true)
Future<String> deviceModel(Ref ref) async {
  final data = await _getDeviceData(DeviceInfoPlugin());

  // try different keys to get the device model
  return
      // android, eg: Google Pixel 4
      data['model'] ??
          // ios, eg: iPhone 12 Pro
          data['name'] ??
          // linux, eg: Linux Mint 20.1
          data['name'] ??
          // windows, eg: Surface Pro 7
          data['productId'] ??
          // macos, eg: MacBook Pro (13-inch, M1, 2020)
          data['model'] ??
          // web, eg: Chrome 87.0.4280.88
          data['browserName'] ??
          'Unknown model';
}

@Riverpod(keepAlive: true)
Future<String> deviceSdkVersion(Ref ref) async {
  final data = await _getDeviceData(DeviceInfoPlugin());

  // try different keys to get the device sdk version
  return
      // android, eg: 30
      data['version.sdkInt']?.toString() ??
          // ios, eg: 14.4
          data['systemVersion'] ??
          // linux, eg: 5.4.0-66-generic
          data['version'] ??
          // windows, eg: 10.0.19042
          data['displayVersion'] ??
          // macos, eg: 11.2.1
          data['osRelease'] ??
          // web, eg: 87.0.4280.88
          data['appVersion'] ??
          'Unknown sdk version';
}

@Riverpod(keepAlive: true)
Future<String> deviceManufacturer(Ref ref) async {
  final data = await _getDeviceData(DeviceInfoPlugin());

  // try different keys to get the device manufacturer
  return
      // android, eg: Google
      data['manufacturer'] ??
          // ios, eg: Apple
          data['manufacturer'] ??
          // linux, eg: Linux
          data['idLike'] ??
          // windows, eg: Microsoft
          data['productName'] ??
          // macos, eg: Apple
          data['manufacturer'] ??
          // web, eg: Google Inc.
          data['vendor'] ??
          'Unknown manufacturer';
}

// copied from https://pub.dev/packages/device_info_plus/example
Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
  return <String, dynamic>{
    'version.securityPatch': build.version.securityPatch,
    'version.sdkInt': build.version.sdkInt,
    'version.release': build.version.release,
    'version.previewSdkInt': build.version.previewSdkInt,
    'version.incremental': build.version.incremental,
    'version.codename': build.version.codename,
    'version.baseOS': build.version.baseOS,
    'board': build.board,
    'bootloader': build.bootloader,
    'brand': build.brand,
    'device': build.device,
    'display': build.display,
    'fingerprint': build.fingerprint,
    'hardware': build.hardware,
    'host': build.host,
    'id': build.id,
    'manufacturer': build.manufacturer,
    'model': build.model,
    'product': build.product,
    'supported32BitAbis': build.supported32BitAbis,
    'supported64BitAbis': build.supported64BitAbis,
    'supportedAbis': build.supportedAbis,
    'tags': build.tags,
    'type': build.type,
    'isPhysicalDevice': build.isPhysicalDevice,
    'systemFeatures': build.systemFeatures,
    'serialNumber': build.serialNumber,
    'isLowRamDevice': build.isLowRamDevice,
  };
}

Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo data) {
  return <String, dynamic>{
    'name': data.name,
    'systemName': data.systemName,
    'systemVersion': data.systemVersion,
    'model': data.model,
    'localizedModel': data.localizedModel,
    'identifierForVendor': data.identifierForVendor,
    'isPhysicalDevice': data.isPhysicalDevice,
    'utsname.sysname:': data.utsname.sysname,
    'utsname.nodename:': data.utsname.nodename,
    'utsname.release:': data.utsname.release,
    'utsname.version:': data.utsname.version,
    'utsname.machine:': data.utsname.machine,
  };
}

Map<String, dynamic> _readLinuxDeviceInfo(LinuxDeviceInfo data) {
  return <String, dynamic>{
    'name': data.name,
    'version': data.version,
    'id': data.id,
    'idLike': data.idLike,
    'versionCodename': data.versionCodename,
    'versionId': data.versionId,
    'prettyName': data.prettyName,
    'buildId': data.buildId,
    'variant': data.variant,
    'variantId': data.variantId,
    'machineId': data.machineId,
  };
}

Map<String, dynamic> _readWebBrowserInfo(WebBrowserInfo data) {
  return <String, dynamic>{
    'browserName': data.browserName.name,
    'appCodeName': data.appCodeName,
    'appName': data.appName,
    'appVersion': data.appVersion,
    'deviceMemory': data.deviceMemory,
    'language': data.language,
    'languages': data.languages,
    'platform': data.platform,
    'product': data.product,
    'productSub': data.productSub,
    'userAgent': data.userAgent,
    'vendor': data.vendor,
    'vendorSub': data.vendorSub,
    'hardwareConcurrency': data.hardwareConcurrency,
    'maxTouchPoints': data.maxTouchPoints,
  };
}

Map<String, dynamic> _readMacOsDeviceInfo(MacOsDeviceInfo data) {
  return <String, dynamic>{
    'computerName': data.computerName,
    'hostName': data.hostName,
    'arch': data.arch,
    'model': data.model,
    'kernelVersion': data.kernelVersion,
    'majorVersion': data.majorVersion,
    'minorVersion': data.minorVersion,
    'patchVersion': data.patchVersion,
    'osRelease': data.osRelease,
    'activeCPUs': data.activeCPUs,
    'memorySize': data.memorySize,
    'cpuFrequency': data.cpuFrequency,
    'systemGUID': data.systemGUID,
  };
}

Map<String, dynamic> _readWindowsDeviceInfo(WindowsDeviceInfo data) {
  return <String, dynamic>{
    'numberOfCores': data.numberOfCores,
    'computerName': data.computerName,
    'systemMemoryInMegabytes': data.systemMemoryInMegabytes,
    'userName': data.userName,
    'majorVersion': data.majorVersion,
    'minorVersion': data.minorVersion,
    'buildNumber': data.buildNumber,
    'platformId': data.platformId,
    'csdVersion': data.csdVersion,
    'servicePackMajor': data.servicePackMajor,
    'servicePackMinor': data.servicePackMinor,
    'suitMask': data.suitMask,
    'productType': data.productType,
    'reserved': data.reserved,
    'buildLab': data.buildLab,
    'buildLabEx': data.buildLabEx,
    'digitalProductId': data.digitalProductId,
    'displayVersion': data.displayVersion,
    'editionId': data.editionId,
    'installDate': data.installDate,
    'productId': data.productId,
    'productName': data.productName,
    'registeredOwner': data.registeredOwner,
    'releaseId': data.releaseId,
    'deviceId': data.deviceId,
  };
}

Future<Map<String, dynamic>> _getDeviceData(
  DeviceInfoPlugin deviceInfoPlugin,
) async {
  Map<String, dynamic> deviceData;
  try {
    if (kIsWeb) {
      deviceData = _readWebBrowserInfo(await deviceInfoPlugin.webBrowserInfo);
    } else {
      deviceData = switch (defaultTargetPlatform) {
        TargetPlatform.android =>
          _readAndroidBuildData(await deviceInfoPlugin.androidInfo),
        TargetPlatform.iOS =>
          _readIosDeviceInfo(await deviceInfoPlugin.iosInfo),
        TargetPlatform.linux =>
          _readLinuxDeviceInfo(await deviceInfoPlugin.linuxInfo),
        TargetPlatform.windows =>
          _readWindowsDeviceInfo(await deviceInfoPlugin.windowsInfo),
        TargetPlatform.macOS =>
          _readMacOsDeviceInfo(await deviceInfoPlugin.macOsInfo),
        TargetPlatform.fuchsia => <String, dynamic>{
            errorKey: 'Fuchsia platform isn\'t supported',
          },
      };
    }
  } on PlatformException {
    deviceData = <String, dynamic>{
      errorKey: 'Failed to get platform version.',
    };
  }
  return deviceData;
}

const errorKey = 'Error:';
