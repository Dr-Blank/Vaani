import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ExpandableDescription extends HookWidget {
  const ExpandableDescription({
    super.key,
    required this.title,
    required this.content,
    this.readMoreText = 'Read More',
    this.readLessText = 'Read Less',
  });

  /// the title of the description section
  final String title;

  /// the collapsible content
  final String content;

  /// the text to show when the description is collapsed
  final String readMoreText;

  /// the text to show when the description is expanded
  final String readLessText;
  @override
  Widget build(BuildContext context) {
    var isDescExpanded = useState(false);
    const duration = Duration(milliseconds: 300);
    final descriptionAnimationController = useAnimationController(
      duration: duration,
    );

    final themeData = Theme.of(context);
    final textTheme = themeData.textTheme;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // header with carrot icon is tapable
          InkWell(
            borderRadius: BorderRadius.circular(8),
      
            onTap: () {
              isDescExpanded.value = !isDescExpanded.value;
              if (isDescExpanded.value) {
                descriptionAnimationController.forward();
              } else {
                descriptionAnimationController.reverse();
              }
            },
            // a header with a carrot icon
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // header text
                  Text(
                    style: textTheme.titleMedium,
                    title,
                  ),
                  // carrot icon
                  AnimatedRotation(
                    turns: isDescExpanded.value ? 0.5 : 0,
                    duration: duration,
                    curve: Curves.easeInOutCubic,
                    child: const Icon(Icons.expand_more_rounded),
                  ),
                ],
              ),
            ),
          ),

          // description with maxLines of 3
          // for now leave animation, just toggle the maxLines
          // TODO: add animation using custom ticker that will animate the maxLines
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: AnimatedSwitcher(
              duration: duration * 3,
              child: isDescExpanded.value
                  ? Text(
                      style: textTheme.bodyMedium,
                      content,
                      maxLines: null,
                    )
                  : Text(
                      style: textTheme.bodyMedium,
                      content,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
            ),
          ),

          // a Read More / Read Less button at the end of the description
          // if the description is expanded, then the button will say Read Less
          // if the description is collapsed, then the button will say Read More
          // the button will be at the end of the description
          // the button will be tapable
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                isDescExpanded.value = !isDescExpanded.value;
                if (isDescExpanded.value) {
                  descriptionAnimationController.forward();
                } else {
                  descriptionAnimationController.reverse();
                }
              },
              child: Text(
                style: textTheme.bodySmall?.copyWith(
                  color: themeData.colorScheme.primary,
                ),
                isDescExpanded.value ? readLessText : readMoreText,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
