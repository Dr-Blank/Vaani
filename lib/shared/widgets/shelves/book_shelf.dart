import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shelfsdk/audiobookshelf_api.dart';
import 'package:shimmer/shimmer.dart' show Shimmer;
import 'package:vaani/api/api_provider.dart';
import 'package:vaani/api/image_provider.dart';
import 'package:vaani/api/library_item_provider.dart' show libraryItemProvider;
import 'package:vaani/constants/hero_tag_conventions.dart';
import 'package:vaani/features/item_viewer/view/library_item_actions.dart';
import 'package:vaani/features/player/providers/audiobook_player.dart';
import 'package:vaani/router/models/library_item_extras.dart';
import 'package:vaani/router/router.dart';
import 'package:vaani/settings/app_settings_provider.dart';
import 'package:vaani/shared/extensions/model_conversions.dart';
import 'package:vaani/shared/widgets/shelves/home_shelf.dart';
import 'package:vaani/theme/providers/theme_from_cover_provider.dart';

/// A shelf that displays books on the home page
class BookHomeShelf extends HookConsumerWidget {
  const BookHomeShelf({
    super.key,
    required this.shelf,
    required this.title,
    this.showPlayButton = false,
  });

  final String title;
  final LibraryItemShelf shelf;
  final bool showPlayButton;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SimpleHomeShelf(
      title: title,
      children: shelf.entities
          .map(
            (item) => switch (item.mediaType) {
              MediaType.book => BookOnShelf(
                  item: item,
                  key: ValueKey(shelf.id + item.id),
                  heroTagSuffix: shelf.id,
                  showPlayButton: showPlayButton,
                ),
              _ => Container(),
            },
          )
          .toList(),
    );
  }
}

// a widget to display a item on the shelf
class BookOnShelf extends HookConsumerWidget {
  const BookOnShelf({
    super.key,
    required this.item,
    this.heroTagSuffix = '',
    this.showPlayButton = true,
  });

  final LibraryItem item;

  /// whether to show the play button on the book cover
  final bool showPlayButton;

  /// makes the hero tag unique
  final String heroTagSuffix;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final book = item.media.asBookMinified;
    final metadata = book.metadata.asBookMetadataMinified;
    final coverImage = ref.watch(coverImageProvider(item.id));
    return LayoutBuilder(
      builder: (context, constraints) {
        final height = min(constraints.maxHeight, 500);
        final width = height * 0.75;
        handleTapOnBook() {
          // open the book
          context.pushNamed(
            Routes.libraryItem.name,
            pathParameters: {
              Routes.libraryItem.pathParamName!: item.id,
            },
            extra: LibraryItemExtras(
              book: book,
              heroTagSuffix: heroTagSuffix,
            ),
          );
        }

        return SizedBox(
          width: width,
          child: InkWell(
            onTap: handleTapOnBook,
            borderRadius: BorderRadius.circular(10),
            child: Padding(
              padding:
                  const EdgeInsets.only(bottom: 8.0, right: 4.0, left: 4.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // the cover image of the book
                  // take up remaining space hence the expanded
                  Expanded(
                    child: Center(
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          Hero(
                            tag: HeroTagPrefixes.bookCover +
                                item.id +
                                heroTagSuffix,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: AnimatedSwitcher(
                                duration: const Duration(milliseconds: 300),
                                child: coverImage.when(
                                  data: (image) {
                                    // return const BookCoverSkeleton();
                                    if (image.isEmpty) {
                                      return const Icon(Icons.error);
                                    }
                                    var imageWidget = Image.memory(
                                      image,
                                      fit: BoxFit.fill,
                                      cacheWidth: (height *
                                              1.2 *
                                              MediaQuery.of(context)
                                                  .devicePixelRatio)
                                          .round(),
                                    );
                                    return Container(
                                      decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimaryContainer,
                                      ),
                                      child: imageWidget,
                                    );
                                  },
                                  loading: () {
                                    return const Center(
                                      child: BookCoverSkeleton(),
                                    );
                                  },
                                  error: (error, stack) {
                                    return const Icon(Icons.error);
                                  },
                                ),
                              ),
                            ),
                          ),
                          // a play button on the book cover
                          if (showPlayButton)
                            _BookOnShelfPlayButton(
                              libraryItemId: item.id,
                            ),
                        ],
                      ),
                    ),
                  ),
                  // the title and author of the book
                  // AutoScrollText(
                  Hero(
                    tag: HeroTagPrefixes.bookTitle + item.id + heroTagSuffix,
                    child: Text(
                      metadata.title ?? '',
                      // mode: AutoScrollTextMode.bouncing,
                      // curve: Curves.easeInOut,
                      // velocity: const Velocity(pixelsPerSecond: Offset(15, 0)),
                      // delayBefore: const Duration(seconds: 2),
                      // pauseBetween: const Duration(seconds: 2),
                      // numberOfReps: 15,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Hero(
                    tag: HeroTagPrefixes.authorName + item.id + heroTagSuffix,
                    child: Text(
                      metadata.authorName ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _BookOnShelfPlayButton extends HookConsumerWidget {
  const _BookOnShelfPlayButton({
    required this.libraryItemId,
  });

  /// the id of the library item of the book
  final String libraryItemId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final me = ref.watch(meProvider);
    final player = ref.watch(audiobookPlayerProvider);
    final isCurrentBookSetInPlayer =
        player.book?.libraryItemId == libraryItemId;
    final isPlayingThisBook = player.playing && isCurrentBookSetInPlayer;

    final userProgress = me.valueOrNull?.mediaProgress
        ?.firstWhereOrNull((element) => element.libraryItemId == libraryItemId);
    final isBookCompleted = userProgress?.isFinished ?? false;

    const size = 40.0;

    // if there is user progress for this book show a circular progress indicator around the play button
    var strokeWidth = size / 8;

    final useMaterialThemeOnItemPage =
        ref.watch(appSettingsProvider).themeSettings.useMaterialThemeOnItemPage;

    AsyncValue<ColorScheme?> coverColorScheme = const AsyncValue.loading();
    if (useMaterialThemeOnItemPage && isCurrentBookSetInPlayer) {
      coverColorScheme = ref.watch(
        themeOfLibraryItemProvider(
          libraryItemId,
          brightness: Theme.of(context).brightness,
        ),
      );
    }

    return Theme(
      // if current book is set in player, get theme from the cover image
      data: ThemeData(
        colorScheme:
            coverColorScheme.valueOrNull ?? Theme.of(context).colorScheme,
      ),
      child: Padding(
        padding: EdgeInsets.all(strokeWidth / 2 + 2),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // the circular progress indicator
            if (userProgress != null)
              SizedBox(
                width: size,
                height: size,
                child: CircularProgressIndicator(
                  value: userProgress.progress,
                  strokeWidth: strokeWidth,
                  backgroundColor: Theme.of(context)
                      .colorScheme
                      .onPrimary
                      .withValues(alpha: 0.8),
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),

            // the play button
            IconButton(
              color: Theme.of(context).colorScheme.primary,
              style: ButtonStyle(
                padding: WidgetStateProperty.all(
                  EdgeInsets.zero,
                ),
                minimumSize: WidgetStateProperty.all(
                  const Size(size, size),
                ),
                backgroundColor: WidgetStateProperty.all(
                  Theme.of(context)
                      .colorScheme
                      .onPrimary
                      .withValues(alpha: 0.9),
                ),
              ),
              onPressed: () async {
                final book =
                    await ref.watch(libraryItemProvider(libraryItemId).future);

                libraryItemPlayButtonOnPressed(
                  ref: ref,
                  book: book.media.asBookExpanded,
                  userMediaProgress: userProgress,
                );
              },
              icon: Hero(
                tag: HeroTagPrefixes.libraryItemPlayButton + libraryItemId,
                child: DynamicItemPlayIcon(
                  isBookCompleted: isBookCompleted,
                  isPlayingThisBook: isPlayingThisBook,
                  isCurrentBookSetInPlayer: isCurrentBookSetInPlayer,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// a skeleton for the book cover
class BookCoverSkeleton extends StatelessWidget {
  const BookCoverSkeleton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: SizedBox(
        width: 150,
        child: Shimmer.fromColors(
          baseColor:
              Theme.of(context).colorScheme.surface.withValues(alpha: 0.3),
          highlightColor:
              Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.1),
          child: Container(
            color: Theme.of(context).colorScheme.surface,
          ),
        ),
      ),
    );
  }
}
