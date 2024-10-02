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

void useTimer(VoidCallback callback, Duration delay) {
  final savedCallback = useRef(callback);
  savedCallback.value = callback;

  useEffect(
    () {
      final timer = Timer(delay, savedCallback.value);
      return timer.cancel;
    },
    [delay],
  );
}

/// Creates [FixedExtentScrollController] that will be disposed automatically.
///
/// See also:
/// - [FixedExtentScrollController]
FixedExtentScrollController useFixedExtentScrollController({
  String? debugLabel,
  List<Object?>? keys,
  int initialItem = 0,
  void Function(ScrollPosition)? onAttach,
  void Function(ScrollPosition)? onDetach,
}) {
  return use(
    _FixedExtentScrollControllerHook(
      debugLabel: debugLabel,
      keys: keys,
      initialItem: initialItem,
      onAttach: onAttach,
      onDetach: onDetach,
    ),
  );
}

class _FixedExtentScrollControllerHook
    extends Hook<FixedExtentScrollController> {
  const _FixedExtentScrollControllerHook({
    this.debugLabel,
    super.keys,
    required this.initialItem,
    this.onAttach,
    this.onDetach,
  });

  final int initialItem;
  final void Function(ScrollPosition)? onAttach;
  final void Function(ScrollPosition)? onDetach;

  final String? debugLabel;

  @override
  HookState<FixedExtentScrollController, Hook<FixedExtentScrollController>>
      createState() => _FixedExtentScrollControllerHookState();
}

class _FixedExtentScrollControllerHookState extends HookState<
    FixedExtentScrollController, _FixedExtentScrollControllerHook> {
  late final controller = FixedExtentScrollController(
    initialItem: hook.initialItem,
    onAttach: hook.onAttach,
    onDetach: hook.onDetach,
  );

  @override
  FixedExtentScrollController build(BuildContext context) => controller;

  @override
  void dispose() => controller.dispose();

  @override
  String get debugLabel => 'useFixedExtentScrollController';
}
