import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// An icon that animates like audio equalizer bars to indicate playback.
///
/// Creates multiple vertical bars that independently animate their height
/// in a looping, visually dynamic pattern.
class PlayingIndicatorIcon extends StatefulWidget {
  /// The number of vertical bars in the indicator.
  final int barCount;

  /// The total width and height of the icon area.
  final double size;

  /// The color of the bars. Defaults to the current [IconTheme] color.
  final Color? color;

  /// The minimum height factor for a bar (relative to [size]).
  /// When [centerSymmetric] is true, this represents the minimum height
  /// extending from the center line (so total minimum height is 2 * minHeightFactor * size).
  /// When false, it's the minimum height from the bottom.
  final double minHeightFactor;

  /// The maximum height factor for a bar (relative to [size]).
  /// When [centerSymmetric] is true, this represents the maximum height
  /// extending from the center line (so total maximum height is 2 * maxHeightFactor * size).
  /// When false, it's the maximum height from the bottom.
  final double maxHeightFactor;

  /// Base duration for a full up/down animation cycle for a single bar.
  /// Actual duration will vary slightly per bar.
  final Duration baseCycleDuration;

  /// If true, the bars animate symmetrically expanding/collapsing from the
  /// horizontal center line. If false (default), they expand/collapse from
  /// the bottom edge.
  final bool centerSymmetric;

  const PlayingIndicatorIcon({
    super.key,
    this.barCount = 4,
    this.size = 20.0,
    this.color,
    this.minHeightFactor = 0.2,
    this.maxHeightFactor = 1.0,
    this.baseCycleDuration = const Duration(milliseconds: 350),
    this.centerSymmetric = true,
  });

  @override
  State<PlayingIndicatorIcon> createState() => _PlayingIndicatorIconState();
}

class _PlayingIndicatorIconState extends State<PlayingIndicatorIcon> {
  late List<_BarAnimationParams> _animationParams;
  final _random = Random();

  @override
  void initState() {
    super.initState();
    _animationParams =
        List.generate(widget.barCount, _createRandomParams, growable: false);
  }

  // Helper to generate random parameters for one bar's animation cycle
  _BarAnimationParams _createRandomParams(int index) {
    final duration1 =
        (widget.baseCycleDuration * (0.8 + _random.nextDouble() * 0.4));
    final duration2 =
        (widget.baseCycleDuration * (0.8 + _random.nextDouble() * 0.4));

    // Note: These factors represent the scale relative to the *half-height*
    // if centerSymmetric is true, controlled by the alignment in scaleY.
    final targetHeightFactor1 = widget.minHeightFactor +
        _random.nextDouble() *
            (widget.maxHeightFactor - widget.minHeightFactor);
    final targetHeightFactor2 = widget.minHeightFactor +
        _random.nextDouble() *
            (widget.maxHeightFactor - widget.minHeightFactor);

    // --- Random initial delay ---
    final initialDelay =
        (_random.nextDouble() * (widget.baseCycleDuration.inMilliseconds / 4))
            .ms;

    return _BarAnimationParams(
      duration1: duration1,
      duration2: duration2,
      targetHeightFactor1: targetHeightFactor1,
      targetHeightFactor2: targetHeightFactor2,
      initialDelay: initialDelay,
    );
  }

  @override
  Widget build(BuildContext context) {
    final color = widget.color ??
        IconTheme.of(context).color ??
        Theme.of(context).colorScheme.primary;

    // --- Bar geometry calculation ---
    final double totalSpacing = widget.size * 0.2;
    // Ensure at least 1px spacing if size is very small
    final double barSpacing = max(1.0, totalSpacing / (widget.barCount + 1));
    final double availableWidthForBars =
        widget.size - (barSpacing * (widget.barCount + 1));
    final double barWidth = max(1.0, availableWidthForBars / widget.barCount);
    // Max height remains the full size potential for the container
    final double maxHeight = widget.size;

    // Determine the alignment for scaling based on the symmetric flag
    final Alignment scaleAlignment =
        widget.centerSymmetric ? Alignment.center : Alignment.bottomCenter;

    // Determine the cross axis alignment for the Row
    final CrossAxisAlignment rowAlignment = widget.centerSymmetric
        ? CrossAxisAlignment.center
        : CrossAxisAlignment.end;

    return SizedBox(
      width: widget.size,
      height: widget.size,
      // Clip ensures bars don't draw outside the SizedBox bounds
      // especially important for center alignment if maxFactor > 0.5
      child: ClipRect(
        child: Row(
          // Use calculated alignment
          crossAxisAlignment: rowAlignment,
          // Use spaceEvenly for better distribution, especially with center alignment
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
            widget.barCount,
            (index) {
              final params = _animationParams[index];
              // The actual bar widget that will be animated
              return Container(
                width: barWidth,
                // Set initial height to the max potential height
                // The scaleY animation will control the visible height
                height: maxHeight,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(barWidth / 2),
                ),
              )
                  .animate(
                    delay: params.initialDelay,
                    onPlay: (controller) => controller.repeat(
                      reverse: true,
                    ),
                  )
                  // 1. Scale to targetHeightFactor1
                  .scaleY(
                    begin:
                        widget.minHeightFactor, // Scale factor starts near min
                    end: params.targetHeightFactor1,
                    duration: params.duration1,
                    curve: Curves.easeInOutCirc,
                    alignment: scaleAlignment, // Apply chosen alignment
                  )
                  // 2. Then scale to targetHeightFactor2
                  .then()
                  .scaleY(
                    end: params.targetHeightFactor2,
                    duration: params.duration2,
                    curve: Curves.easeInOutCirc,
                    alignment: scaleAlignment, // Apply chosen alignment
                  );
            },
            growable: false,
          ),
        ),
      ),
    );
  }
}

// Helper class: Renamed height fields for clarity
class _BarAnimationParams {
  final Duration duration1;
  final Duration duration2;
  final double targetHeightFactor1; // Factor relative to total size
  final double targetHeightFactor2; // Factor relative to total size
  final Duration initialDelay;

  _BarAnimationParams({
    required this.duration1,
    required this.duration2,
    required this.targetHeightFactor1,
    required this.targetHeightFactor2,
    required this.initialDelay,
  });
}
