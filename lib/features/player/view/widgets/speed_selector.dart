import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:list_wheel_scroll_view_nls/list_wheel_scroll_view_nls.dart';
import 'package:vaani/features/player/providers/audiobook_player.dart';
import 'package:vaani/settings/app_settings_provider.dart';

class SpeedSelector extends HookConsumerWidget {
  const SpeedSelector({
    super.key,
    required this.onSpeedSelected,
  });

  final void Function(double speed) onSpeedSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appSettings = ref.watch(appSettingsProvider);
    final playerSettings = appSettings.playerSettings;
    final speeds = playerSettings.speedOptions;
    final currentSpeed = ref.watch(audiobookPlayerProvider).speed;
    final speedState = useState(currentSpeed);

    // hook the onSpeedSelected function to the state
    useEffect(
      () {
        onSpeedSelected(speedState.value);
        return null;
      },
      [speedState.value],
    );

    // the speed options
    final minSpeed = min(
      speeds.reduce((minSpeedSoFar, element) => min(minSpeedSoFar, element)),
      playerSettings.minSpeed,
    );
    final maxSpeed = max(
      speeds.reduce((maxSpeedSoFar, element) => max(maxSpeedSoFar, element)),
      playerSettings.maxSpeed,
    );
    final speedIncrement = playerSettings.speedIncrement;
    final availableSpeeds = ((maxSpeed - minSpeed) / speedIncrement).ceil() + 1;
    final availableSpeedsList = List.generate(
      availableSpeeds,
      (index) {
        // need to round to 2 decimal place to avoid floating point errors
        return double.parse(
          (minSpeed + index * speedIncrement).toStringAsFixed(2),
        );
      },
    );

    final scrollController = FixedExtentScrollController(
      initialItem: availableSpeedsList.indexOf(currentSpeed),
    );
    const double itemExtent = 25;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          // the title
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                'Playback Speed: ${speedState.value}x',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ),

          // the speed selector
          Flexible(
            child: SpeedWheel(
              availableSpeedsList: availableSpeedsList,
              speedState: speedState,
              scrollController: scrollController,
              itemExtent: itemExtent,
            ),
          ),

          // the speed buttons
          Wrap(
            spacing: 8.0,
            alignment: WrapAlignment.center,
            runAlignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: speeds
                .map(
                  (speed) => TextButton(
                    style: speed == speedState.value
                        ? TextButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.primaryContainer,
                            foregroundColor: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
                          )
                        // border if not selected
                        : TextButton.styleFrom(
                            side: BorderSide(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                            ),
                          ),
                    onPressed: () async {
                      // animate the wheel to the selected speed
                      var index = availableSpeedsList.indexOf(speed);
                      // if the speed is not in the list
                      if (index == -1) {
                        // find the nearest speed
                        final nearestSpeed = availableSpeedsList.firstWhere(
                          (element) => element > speed,
                          orElse: () => availableSpeedsList.last,
                        );
                        index = availableSpeedsList.indexOf(nearestSpeed);
                      }
                      await scrollController.animateToItem(
                        index,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );

                      // call the onSpeedSelected function
                      speedState.value = speed;
                    },
                    child: Text('$speed'),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

class SpeedWheel extends StatelessWidget {
  const SpeedWheel({
    super.key,
    required this.availableSpeedsList,
    required this.speedState,
    required this.scrollController,
    required this.itemExtent,
    this.showIncrementButtons = true,
  });

  final List<double> availableSpeedsList;
  final ValueNotifier<double> speedState;
  final FixedExtentScrollController scrollController;
  final double itemExtent;
  final bool showIncrementButtons;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // a minus button to decrease the speed
        if (showIncrementButtons)
          IconButton.filledTonal(
            icon: const Icon(Icons.remove),
            onPressed: () {
              // animate to index - 1
              final index = availableSpeedsList.indexOf(speedState.value);
              if (index > 0) {
                scrollController.animateToItem(
                  index - 1,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              }
            },
          ),
        // the speed selector wheel
        Expanded(
          child: ListWheelScrollViewX(
            controller: scrollController,
            scrollDirection: Axis.horizontal,
            itemExtent: itemExtent,
            diameterRatio: 1.5, squeeze: 1.2,
            // useMagnifier: true,
            // magnification: 1.5,
            physics: const FixedExtentScrollPhysics(),
            children: availableSpeedsList
                .map(
                  (speed) => Expanded(
                    child: SpeedLine(itemExtent: itemExtent, speed: speed),
                  ),
                )
                .toList(),
            onSelectedItemChanged: (index) {
              speedState.value = availableSpeedsList[index];
            },
          ),
        ),

        if (showIncrementButtons)
          // a plus button to increase the speed
          IconButton.filledTonal(
            icon: const Icon(Icons.add),
            onPressed: () {
              // animate to index + 1
              final index = availableSpeedsList.indexOf(speedState.value);
              if (index < availableSpeedsList.length - 1) {
                scrollController.animateToItem(
                  index + 1,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              }
            },
          ),
      ],
    );
  }
}

class SpeedLine extends StatelessWidget {
  const SpeedLine({
    super.key,
    required this.itemExtent,
    required this.speed,
  });

  final double itemExtent;
  final double speed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // a vertical line
        Container(
          height: itemExtent * 2,
          // thick if multiple of 1, thin if multiple of 0.5 and transparent if multiple of 0.05
          width: speed % 0.5 == 0
              ? 3
              : speed % 0.25 == 0
                  ? 2
                  : 0.5,
          color: Theme.of(context).colorScheme.onSurface,
        ),
        // the speed text but only at .5 increments of speed
        if (speed % 0.25 == 0)
          Expanded(
            child: Text.rich(
              TextSpan(
                text: speed.floor().toString(),
                children: [
                  TextSpan(
                    text: '.${speed.toStringAsFixed(2).split('.').last}',
                    style: TextStyle(
                      fontSize:
                          Theme.of(context).textTheme.labelSmall?.fontSize,
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
