import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

void useInterval(VoidCallback callback, Duration delay) {
  final savedCallback = useRef(callback);
  savedCallback.value = callback;

  useEffect(
    () {
      final timer = Timer.periodic(delay, (_) => savedCallback.value());
      return timer.cancel;
    },
    [delay],
  );
}
