import 'package:flutter/material.dart';

class PlayerWhenExpanded extends StatelessWidget {
  const PlayerWhenExpanded({
    super.key,
    required this.imgPaddingLeft,
    required this.imgPaddingVertical,
    required this.imageSize,
    required this.img,
    required this.percentageExpandedPlayer,
    required this.text,
    required this.buttonSkipBackwards,
    required this.buttonPlayExpanded,
    required this.buttonSkipForward,
    required this.progressIndicator,
  });

  /// padding values control the position of the image
  final double imgPaddingLeft;
  final double imgPaddingVertical;
  final double imageSize;
  final Widget img;
  final double percentageExpandedPlayer;
  final Text text;
  final IconButton buttonSkipBackwards;
  final IconButton buttonPlayExpanded;
  final IconButton buttonSkipForward;
  final Widget progressIndicator;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(
              left: imgPaddingLeft,
              top: imgPaddingVertical,
              // bottom: paddingVertical,
            ),
            child: SizedBox(
              height: imageSize,
              child: InkWell(
                onTap: () {},
                child: img,
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 33),
            child: Opacity(
              opacity: percentageExpandedPlayer,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(child: text),
                  Flexible(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        buttonSkipBackwards,
                        buttonPlayExpanded,
                        buttonSkipForward,
                      ],
                    ),
                  ),
                  Flexible(child: progressIndicator),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
