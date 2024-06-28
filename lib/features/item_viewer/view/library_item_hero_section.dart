import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shelfsdk/audiobookshelf_api.dart' as shelfsdk;
import 'package:whispering_pages/api/image_provider.dart';
import 'package:whispering_pages/constants/hero_tag_conventions.dart';
import 'package:whispering_pages/features/item_viewer/view/library_item_page.dart';
import 'package:whispering_pages/features/player/providers/audiobook_player.dart';
import 'package:whispering_pages/router/models/library_item_extras.dart';
import 'package:whispering_pages/settings/app_settings_provider.dart';
import 'package:whispering_pages/shared/extensions/duration_format.dart';
import 'package:whispering_pages/shared/extensions/model_conversions.dart';
import 'package:whispering_pages/shared/widgets/shelves/book_shelf.dart';

class LibraryItemHeroSection extends HookConsumerWidget {
  const LibraryItemHeroSection({
    super.key,
    required this.itemId,
    required this.extraMap,
    required this.providedCacheImage,
    required this.item,
    required this.itemBookMetadata,
    required this.bookDetailsCached,
    required this.coverColorScheme,
  });

  final String itemId;
  final LibraryItemExtras? extraMap;
  final Image? providedCacheImage;
  final AsyncValue<shelfsdk.LibraryItemExpanded> item;
  final shelfsdk.BookMetadataExpanded? itemBookMetadata;
  final shelfsdk.BookMinified? bookDetailsCached;
  final AsyncValue<ColorScheme?> coverColorScheme;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SliverToBoxAdapter(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // book cover
                LayoutBuilder(
                  builder: (context, constraints) {
                    return SizedBox(
                      width: calculateWidth(context, constraints),
                      child: Column(
                        children: [
                          Hero(
                            tag: HeroTagPrefixes.bookCover +
                                itemId +
                                (extraMap?.heroTagSuffix ?? ''),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: _BookCover(
                                itemId: itemId,
                                extraMap: extraMap,
                                providedCacheImage: providedCacheImage,
                                coverColorScheme: coverColorScheme.valueOrNull,
                                item: item,
                              ),
                            ),
                          ),
                          // a progress bar if available
                          item.when(
                            data: (libraryItem) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                  top: 8.0,
                                  right: 8.0,
                                  left: 8.0,
                                ),
                                child: _LibraryItemProgressIndicator(
                                  libraryItem: libraryItem,
                                ),
                              );
                            },
                            loading: () => const SizedBox.shrink(),
                            error: (error, stack) => const SizedBox.shrink(),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                // book details
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        _BookTitle(
                          extraMap: extraMap,
                          itemBookMetadata: itemBookMetadata,
                          bookDetailsCached: bookDetailsCached,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              // authors info if available
                              _BookAuthors(
                                itemBookMetadata: itemBookMetadata,
                                bookDetailsCached: bookDetailsCached,
                              ),
                              // narrators info if available
                              _BookNarrators(
                                itemBookMetadata: itemBookMetadata,
                                bookDetailsCached: bookDetailsCached,
                              ),
                              // series info if available
                              _BookSeries(
                                itemBookMetadata: itemBookMetadata,
                                bookDetailsCached: bookDetailsCached,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _LibraryItemProgressIndicator extends HookConsumerWidget {
  const _LibraryItemProgressIndicator({
    super.key,
    required this.libraryItem,
  });

  final shelfsdk.LibraryItemExpanded libraryItem;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final player = ref.watch(audiobookPlayerProvider);
    final mediaProgress = libraryItem.userMediaProgress;
    if (mediaProgress == null && player.book?.libraryItemId != libraryItem.id) {
      return const SizedBox.shrink();
    }

    double progress;
    Duration remainingTime;
    if (player.book?.libraryItemId == libraryItem.id) {
      // final positionStream = useStream(player.slowPositionStream);
      progress = (player.positionInBook).inSeconds /
          libraryItem.media.asBookExpanded.duration.inSeconds;
      remainingTime =
          libraryItem.media.asBookExpanded.duration - player.positionInBook;
    } else {
      progress = mediaProgress?.progress ?? 0;
      remainingTime = (libraryItem.media.asBookExpanded.duration -
          mediaProgress!.currentTime);
    }

    final progressInPercent = progress * 100;

    return Tooltip(
      message: 'Progress: ${progressInPercent.toStringAsFixed(2)}%',
      waitDuration: 200.ms,
      child: Column(
        children: [
          // % progress
          // Text(
          //   // only show 2 decimal places
          //   '${(progressInPercent).toStringAsFixed(
          //     progressInPercent < 10 ? 1 : 0,
          //   )}% completed',
          //   style: Theme.of(context).textTheme.bodySmall,
          // ),

          // progress indicator
          LinearProgressIndicator(
            value: progress.clamp(0.05, 0.95),
            borderRadius: BorderRadius.circular(8),
          ),
          const SizedBox.square(
            dimension: 4.0,
          ),
          // time remaining
          Text(
            // only show 2 decimal places
            '${remainingTime.formattedBinary} left',

            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.75),
                ),
          ),
        ],
      ),
    );
  }
}

class _HeroSectionSubLabelWithIcon extends HookConsumerWidget {
  const _HeroSectionSubLabelWithIcon({
    super.key,
    required this.icon,
    required this.text,
  });

  final IconData icon;
  final Widget text;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeData = Theme.of(context);
    final useFontAwesome =
        icon.runtimeType == FontAwesomeIcons.book.runtimeType;
    final useMaterialThemeOnItemPage =
        ref.watch(appSettingsProvider).useMaterialThemeOnItemPage;
    final color = useMaterialThemeOnItemPage
        ? themeData.colorScheme.primary
        : themeData.colorScheme.onSurface.withOpacity(0.75);
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 8, top: 2),
            child: useFontAwesome
                ? FaIcon(
                    icon,
                    size: 16,
                    color: color,
                  )
                : Icon(
                    icon,
                    size: 16,
                    color: color,
                  ),
          ),
          Expanded(
            child: text,
          ),
        ],
      ),
    );
  }
}

class _BookSeries extends StatelessWidget {
  const _BookSeries({
    super.key,
    required this.itemBookMetadata,
    required this.bookDetailsCached,
  });

  final shelfsdk.BookMetadataExpanded? itemBookMetadata;
  final shelfsdk.BookMinified? bookDetailsCached;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    String generateSeriesString() {
      final series = (itemBookMetadata)?.series ?? <shelfsdk.SeriesSequence>[];
      if (series.isEmpty) {
        return (bookDetailsCached?.metadata as shelfsdk.BookMetadataMinified?)
                ?.seriesName ??
            '';
      }
      return series
          .map((e) {
            try {
              e as shelfsdk.SeriesSequence;
              final seq = e.sequence != null ? '#${e.sequence} of ' : '';
              return '$seq${e.name}';
            } catch (e) {
              return '';
            }
          })
          .toList()
          .join(', ');
    }

    return generateSeriesString() == ''
        ? const SizedBox.shrink()
        : _HeroSectionSubLabelWithIcon(
            icon: Icons.library_books_rounded,
            text: Text(
              style: themeData.textTheme.titleSmall,
              generateSeriesString(),
            ),
          );
  }
}

class _BookNarrators extends StatelessWidget {
  const _BookNarrators({
    super.key,
    required this.itemBookMetadata,
    required this.bookDetailsCached,
  });

  final shelfsdk.BookMetadataExpanded? itemBookMetadata;
  final shelfsdk.BookMinified? bookDetailsCached;

  @override
  Widget build(BuildContext context) {
    String generateNarratorsString() {
      final narrators = (itemBookMetadata)?.narrators ?? [];
      if (narrators.isEmpty) {
        return (bookDetailsCached?.metadata as shelfsdk.BookMetadataMinified?)
                ?.narratorName ??
            '';
      }
      return narrators.join(', ');
    }

    final themeData = Theme.of(context);

    return generateNarratorsString() == ''
        ? const SizedBox.shrink()
        : _HeroSectionSubLabelWithIcon(
            icon: Icons.record_voice_over,
            text: Text(
              style: themeData.textTheme.titleSmall,
              generateNarratorsString(),
            ),
          );
  }
}

class _BookCover extends HookConsumerWidget {
  const _BookCover({
    super.key,
    required this.itemId,
    required this.extraMap,
    required this.providedCacheImage,
    required this.item,
    this.coverColorScheme,
  });

  final String itemId;
  final LibraryItemExtras? extraMap;
  final Image? providedCacheImage;
  final AsyncValue<shelfsdk.LibraryItemExpanded> item;
  final ColorScheme? coverColorScheme;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeData = Theme.of(context);
    final useMaterialThemeOnItemPage =
        ref.watch(appSettingsProvider).useMaterialThemeOnItemPage;

    return ThemeSwitcher(
      builder: (context) {
        // change theme after 2 seconds
        if (useMaterialThemeOnItemPage) {
          Future.delayed(150.ms, () {
            try {
              ThemeSwitcher.of(context).changeTheme(
                theme: coverColorScheme != null
                    ? ThemeData.from(
                        colorScheme: coverColorScheme!,
                        textTheme: themeData.textTheme,
                      )
                    : themeData,
              );
            } catch (e) {
              debugPrint('Error changing theme: $e');
            }
          });
        }
        return providedCacheImage ??
            item.when(
              data: (libraryItem) {
                final coverImage = ref.watch(coverImageProvider(libraryItem));
                return Stack(
                  children: [
                    coverImage.when(
                      data: (image) {
                        // return const BookCoverSkeleton();
                        if (image.isEmpty) {
                          return const Icon(Icons.error);
                        }
                        // cover 80% of parent height
                        return Image.memory(
                          image,
                          fit: BoxFit.cover,
                          // cacheWidth: (height *
                          //         MediaQuery.of(context).devicePixelRatio)
                          //     .round(),
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
                  ],
                );
              },
              error: (error, stack) => const Icon(Icons.error),
              loading: () => const Center(child: BookCoverSkeleton()),
            );
      },
    );
  }
}

class _BookTitle extends StatelessWidget {
  const _BookTitle({
    super.key,
    required this.extraMap,
    required this.itemBookMetadata,
    required this.bookDetailsCached,
  });

  final LibraryItemExtras? extraMap;
  final shelfsdk.BookMetadataExpanded? itemBookMetadata;
  final shelfsdk.BookMinified? bookDetailsCached;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Hero(
          tag: HeroTagPrefixes.bookTitle +
              // itemId +
              (extraMap?.heroTagSuffix ?? ''),
          child: Text(
            // mode: AutoScrollTextMode.bouncing,
            // curve: Curves.fastEaseInToSlowEaseOut,
            // velocity: const Velocity(pixelsPerSecond: Offset(30, 0)),
            // delayBefore: 500.ms,
            // pauseBetween: 150.ms,
            // numberOfReps: 3,
            style: themeData.textTheme.headlineLarge,
            itemBookMetadata?.title ?? bookDetailsCached?.metadata.title ?? '',
          ),
        ),
        // subtitle if available
        itemBookMetadata?.subtitle == null
            ? const SizedBox.shrink()
            : Text(
                style: themeData.textTheme.titleSmall?.copyWith(
                  color: themeData.colorScheme.onSurface.withOpacity(0.8),
                ),
                itemBookMetadata?.subtitle ?? '',
              ),
      ],
    );
  }
}

class _BookAuthors extends StatelessWidget {
  const _BookAuthors({
    super.key,
    required this.itemBookMetadata,
    required this.bookDetailsCached,
  });

  final shelfsdk.BookMetadataExpanded? itemBookMetadata;
  final shelfsdk.BookMinified? bookDetailsCached;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    String generateAuthorsString() {
      final authors = (itemBookMetadata)?.authors ?? [];
      if (authors.isEmpty) {
        return (bookDetailsCached?.metadata as shelfsdk.BookMetadataMinified?)
                ?.authorName ??
            '';
      }
      return authors.map((e) => e.name).join(', ');
    }

    return generateAuthorsString() == ''
        ? const SizedBox.shrink()
        : _HeroSectionSubLabelWithIcon(
            icon: FontAwesomeIcons.penNib,
            text: Text(
              style: themeData.textTheme.titleSmall,
              generateAuthorsString(),
            ),
          );
  }
}