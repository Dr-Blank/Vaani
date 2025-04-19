import 'package:flutter/material.dart';

class VaaniLogo extends StatelessWidget {
  const VaaniLogo({
    super.key,
    this.size,
    this.duration = const Duration(milliseconds: 750),
    this.curve = Curves.fastOutSlowIn,
  });

  final double? size;
  final Duration duration;
  final Curve curve;

  @override
  Widget build(BuildContext context) {
    final IconThemeData iconTheme = IconTheme.of(context);
    final double? iconSize = size ?? iconTheme.size;
    return AnimatedContainer(
      width: iconSize,
      height: iconSize,
      duration: duration,
      curve: curve,
      child: Image.asset('assets/images/vaani_logo_foreground.png'),
    );
  }
}
