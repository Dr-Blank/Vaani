import 'dart:math';

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shelfsdk/audiobookshelf_api.dart' as shelfsdk;
import 'package:whispering_pages/api/image_provider.dart';
import 'package:whispering_pages/api/library_item_provider.dart';
import 'package:whispering_pages/extensions/hero_tag_conventions.dart';
import 'package:whispering_pages/features/player/providers/audiobook_player_provider.dart';
import 'package:whispering_pages/router/models/library_item_extras.dart';
import 'package:whispering_pages/settings/app_settings_provider.dart';
import 'package:whispering_pages/theme/theme_from_cover_provider.dart';
import 'package:whispering_pages/widgets/shelves/book_shelf.dart';

import '../../../widgets/expandable_description.dart';
import '../../../widgets/library_item_sliver_app_bar.dart';

class LibraryItemPage extends HookConsumerWidget {
  const LibraryItemPage({
    super.key,
    required this.itemId,
    this.extra,
  });

  final String itemId;
  final Object? extra;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final extraMap =
        extra is LibraryItemExtras ? extra as LibraryItemExtras : null;
    final bookDetailsCached = extraMap?.book;
    final providedCacheImage = extraMap?.coverImage != null
        ? Image.memory(extraMap!.coverImage!)
        : null;

    final itemFromApi = ref.watch(libraryItemProvider(itemId));

    var itemBookMetadata = itemFromApi.valueOrNull == null
        ? null
        : shelfsdk.BookMetadataExpanded.fromJson(
            itemFromApi.valueOrNull!.media.metadata.toJson(),
          );
    // itemFromApi.valueOrNull?.media.metadata as shelfsdk.BookMetadata?;

    final useMaterialThemeOnItemPage =
        ref.watch(appSettingsProvider).useMaterialThemeOnItemPage;
    AsyncValue<ColorScheme?> coverColorScheme = const AsyncValue.loading();
    if (useMaterialThemeOnItemPage) {
      coverColorScheme = ref.watch(
        themeOfLibraryItemProvider(
          itemFromApi.valueOrNull,
          brightness: Theme.of(context).brightness,
        ),
      );
      debugPrint('ColorScheme: ${coverColorScheme.valueOrNull}');
    } else {
      debugPrint('useMaterialThemeOnItemPage is false');
      // AsyncValue<ColorScheme?> coverColorScheme = const AsyncValue.loading();
    }
    return ThemeProvider(
      initTheme: Theme.of(context),
      duration: 200.ms,
      child: ThemeSwitchingArea(
        child: Builder(
          builder: (context) {
            return Scaffold(
              body: CustomScrollView(
                slivers: [
                  const LibraryItemSliverAppBar(),
                  SliverPadding(
                    padding: const EdgeInsets.all(8),
                    sliver: LibraryItemHeroSection(
                      itemId: itemId,
                      extraMap: extraMap,
                      providedCacheImage: providedCacheImage,
                      item: itemFromApi,
                      itemBookMetadata: itemBookMetadata,
                      bookDetailsCached: bookDetailsCached,
                      coverColorScheme: coverColorScheme,
                    ),
                  ),
                  // a horizontal display with dividers of metadata
                  SliverToBoxAdapter(
                    child: itemFromApi.valueOrNull != null
                        ? LibraryItemMetadata(
                            item: itemFromApi.valueOrNull!,
                            itemBookMetadata: itemBookMetadata,
                            bookDetailsCached: bookDetailsCached,
                          )
                        : const SizedBox.shrink(),
                  ),
                  // a row of actions like play, download, share, etc
                  SliverToBoxAdapter(
                    child: itemFromApi.valueOrNull != null
                        ? LibraryItemActions(item: itemFromApi.valueOrNull!)
                        : const SizedBox.shrink(),
                  ),
                  // a expandable section for book description
                  SliverToBoxAdapter(
                    child:
                        itemFromApi.valueOrNull?.media.metadata.description !=
                                null
                            ? ExpandableDescription(
                                title: 'About the Book',
                                content: itemFromApi
                                    .valueOrNull!.media.metadata.description!,
                              )
                            : const SizedBox.shrink(),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class LibraryItemMetadata extends StatelessWidget {
  const LibraryItemMetadata({
    super.key,
    required this.item,
    this.itemBookMetadata,
    this.bookDetailsCached,
  });

  final shelfsdk.LibraryItem item;
  final shelfsdk.BookMetadataExpanded? itemBookMetadata;
  final shelfsdk.BookMinified? bookDetailsCached;

  @override
  Widget build(BuildContext context) {
    final children = [
      // duration of the book
      _MetadataItem(
        title: switch (itemBookMetadata?.abridged) {
          true => 'Abridged',
          false => 'Unabridged',
          _ => 'Length',
        },
        value: getDurationFormatted() ?? 'time is just a concept',
      ),
      _MetadataItem(
        title: 'Published',
        value: itemBookMetadata?.publishedDate ??
            itemBookMetadata?.publishedYear ??
            'Unknown',
      ),
      _MetadataItem(
        title: getCodecAndBitrate() ?? 'Codec & Bitrate',
        value: getSizeFormatted() ?? 'Unknown',
      ),
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          // alternate between metadata and vertical divider
          children: List.generate(
            children.length * 2 - 1,
            (index) {
              if (index.isEven) {
                return children[index ~/ 2];
              }
              return VerticalDivider(
                indent: 6,
                endIndent: 6,
                color:
                    Theme.of(context).colorScheme.onBackground.withOpacity(0.6),
              );
            },
          ),
        ),
      ),
    );
  }

  /// formats the duration of the book as `10h 30m`
  ///
  /// will add up all the durations of the audio files first
  /// then convert them to the given format
  String? getDurationFormatted() {
    final book = (item.media as shelfsdk.BookExpanded?);
    if (book == null) {
      return null;
    }
    final duration = book.audioFiles
        .map((e) => e.duration)
        .reduce((value, element) => value + element);
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    return '${hours}h ${minutes}m';
  }

  /// will return the size of the book in MB
  ///
  /// will add up all the sizes of the audio files first
  /// then convert them to MB
  String? getSizeFormatted() {
    final book = (item.media as shelfsdk.BookExpanded?);
    if (book == null) {
      return null;
    }
    final size = book.audioFiles
        .map((e) => e.metadata.size)
        .reduce((value, element) => value + element);
    return '${size / 1024 ~/ 1024} MB';
  }

  /// will return the codec and bitrate of the book
  String? getCodecAndBitrate() {
    final book = (item.media as shelfsdk.BookExpanded?);
    if (book == null) {
      return null;
    }
    final codec = book.audioFiles.first.codec.toUpperCase();
    final bitrate = book.audioFiles.first.bitRate;
    return codec;
  }
}

/// key-value pair to display as column
class _MetadataItem extends StatelessWidget {
  const _MetadataItem({
    super.key,
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          style: themeData.textTheme.titleMedium?.copyWith(
            color: themeData.colorScheme.onBackground.withOpacity(0.90),
          ),
          value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          style: themeData.textTheme.bodySmall?.copyWith(
            color: themeData.colorScheme.onBackground.withOpacity(0.7),
          ),
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

class LibraryItemActions extends HookConsumerWidget {
  LibraryItemActions({
    super.key,
    required this.item,
  }) {
    book = shelfsdk.BookExpanded.fromJson(item.media.toJson());
  }

  final shelfsdk.LibraryItem item;
  late final shelfsdk.BookExpanded book;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final player = ref.read(audiobookPlayerProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // play/resume button the same width as image
            LayoutBuilder(
              builder: (context, constraints) {
                return SizedBox(
                  width: calculateWidth(context, constraints),
                  // a boxy button with icon and text but little rounded corner
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      // play the book
                      debugPrint('Pressed play/resume button');
                      // set the book to the player if not already set
                      if (player.book != book) {
                        debugPrint('Setting the book ${book.libraryItemId}');
                        await player.setSourceAudioBook(book);
                        ref
                            .read(audiobookPlayerProvider.notifier)
                            .notifyListeners();
                      }
                      // toggle play/pause
                      player.togglePlayPause();
                    },
                    icon: const Icon(Icons.play_arrow_rounded),
                    label: const Text('Play/Resume'),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                );
              },
            ),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SizedBox(
                    width: constraints.maxWidth * 0.6,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // read list button
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.playlist_add_rounded,
                          ),
                        ),
                        // share button
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.share_rounded),
                        ),
                        // download button
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.download_rounded,
                          ),
                        ),
                        // more button
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.more_vert_rounded,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
  final AsyncValue<shelfsdk.LibraryItem> item;
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
                      child: Hero(
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
        : themeData.colorScheme.onBackground.withOpacity(0.75);
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
  final AsyncValue<shelfsdk.LibraryItem> item;
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
            ThemeSwitcher.of(context).changeTheme(
              theme: coverColorScheme != null
                  ? ThemeData.from(
                      colorScheme: coverColorScheme!,
                      textTheme: themeData.textTheme,
                    )
                  : themeData,
            );
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
                  color: themeData.colorScheme.onBackground.withOpacity(0.8),
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

/// Calculate the width of the book cover based on the screen size
double calculateWidth(
  BuildContext context,
  BoxConstraints constraints, {
  /// width ratio of the cover image to the available width
  double widthRatio = 0.4,

  /// height ratio of the cover image to the available height
  double maxHeightToUse = 0.25,
}) {
  final availHeight =
      min(constraints.maxHeight, MediaQuery.of(context).size.height);
  final availWidth =
      min(constraints.maxWidth, MediaQuery.of(context).size.width);

  // make the width widthRatio of the available width
  var width = availWidth * widthRatio;
  // but never exceed more than heightRatio of height
  if (width > availHeight * maxHeightToUse) {
    width = availHeight * maxHeightToUse;
  }

  return width;
}
