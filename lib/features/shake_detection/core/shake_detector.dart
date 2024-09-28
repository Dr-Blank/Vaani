import 'dart:async';
import 'dart:math';

import 'package:logging/logging.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:vaani/settings/models/app_settings.dart';

final _logger = Logger('ShakeDetector');

class ShakeDetector {
  final ShakeDetectionSettings _settings;
  final Function()? onShakeDetected;

  ShakeDetector(
    this._settings,
    this.onShakeDetected, {
    startImmediately = true,
  }) {
    _logger.fine('ShakeDetector created with settings: $_settings');
    if (startImmediately) {
      start();
    }
  }

  StreamSubscription? _accelerometerSubscription;

  int _currentShakeCount = 0;

  DateTime _lastShakeTime = DateTime.now();

  void start() {
    if (_accelerometerSubscription != null) {
      _logger.warning('ShakeDetector is already running');
      return;
    }
    _accelerometerSubscription =
        userAccelerometerEventStream(samplingPeriod: _settings.samplingPeriod)
            .listen((event) {
      if (event.rms > (_settings.force?.threshold ?? _settings.threshold)) {
        _currentShakeCount++;

        if (_currentShakeCount >= _settings.shakeTriggerCount &&
            !isCoolDownNeeded()) {
          _logger.fine('Shake detected $_currentShakeCount times');

          onShakeDetected?.call();

          _lastShakeTime = DateTime.now();
          _currentShakeCount = 0;
        }
      } else {
        _currentShakeCount = 0;
      }
    });

    _logger.fine('ShakeDetector started');
  }

  void stop() {
    _currentShakeCount = 0;
    _accelerometerSubscription?.cancel();
    _accelerometerSubscription = null;
    _logger.fine('ShakeDetector stopped');
  }

  void dispose() {
    stop();
  }

  bool isCoolDownNeeded() {
    return _lastShakeTime
        .add(_settings.shakeTriggerCoolDown)
        .isAfter(DateTime.now());
  }
}

extension UserAccelerometerEventRMS on UserAccelerometerEvent {
  double get rms => sqrt(x * x + y * y + z * z);
}
