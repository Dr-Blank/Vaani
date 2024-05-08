import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// A workaround for the issue where the autofill loses focus on Android
///
/// Example usage:
/// ```dart
/// InactiveFocusScopeObserver(
///   child: FormWithTheFeildsThatMayLooseFocus(),
/// )
/// ```
///
// see https://github.com/flutter/flutter/issues/137760#issuecomment-1956816977
class InactiveFocusScopeObserver extends StatefulWidget {
  final Widget child;

  const InactiveFocusScopeObserver({
    super.key,
    required this.child,
  });

  @override
  State<InactiveFocusScopeObserver> createState() =>
      _InactiveFocusScopeObserverState();
}

class _InactiveFocusScopeObserverState
    extends State<InactiveFocusScopeObserver> {
  final FocusScopeNode _focusScope = FocusScopeNode();

  AppLifecycleListener? _listener;
  FocusNode? _lastFocusedNode;

  @override
  void initState() {
    _registerListener();

    super.initState();
  }

  @override
  Widget build(BuildContext context) => FocusScope(
        node: _focusScope,
        child: widget.child,
      );

  @override
  void dispose() {
    _listener?.dispose();
    _focusScope.dispose();

    super.dispose();
  }

  void _registerListener() {
    /// optional if you want this workaround for any platform and not just for android
    if (defaultTargetPlatform != TargetPlatform.android) {
      return;
    }

    _listener = AppLifecycleListener(
      onInactive: () {
        _lastFocusedNode = _focusScope.focusedChild;
      },
      onResume: () {
        _lastFocusedNode = null;
      },
    );

    _focusScope.addListener(_onFocusChanged);
  }

  void _onFocusChanged() {
    if (_lastFocusedNode?.hasFocus == false) {
      _lastFocusedNode?.requestFocus();
      _lastFocusedNode = null;
    }
  }
}
