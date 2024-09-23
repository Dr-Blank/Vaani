import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vaani/api/library_item_provider.dart';
import 'package:vaani/shared/extensions/model_conversions.dart';

class LibraryItemMetadata extends HookConsumerWidget {
  const LibraryItemMetadata({
    super.key,
    required this.id,
  });

  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final item = ref.watch(libraryItemProvider(id)).valueOrNull;

    /// formats the duration of the book as `10h 30m`
    ///
    /// will add up all the durations of the audio files first
    /// then convert them to the given format
    String? getDurationFormatted() {
      final book = (item?.media.asBookExpanded);
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
      final book = (item?.media.asBookExpanded);
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
      final book = (item?.media.asBookExpanded);
      if (book == null) {
        return null;
      }
      final codec = book.audioFiles.first.codec.toUpperCase();
      // final bitrate = book.audioFiles.first.bitRate;
      return codec;
    }

    final itemBookMetadata = item?.media.metadata.asBookMetadataExpanded;

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
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
              );
            },
          ),
        ),
      ),
    );
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
            color: themeData.colorScheme.onSurface.withOpacity(0.90),
          ),
          value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          style: themeData.textTheme.bodySmall?.copyWith(
            color: themeData.colorScheme.onSurface.withOpacity(0.7),
          ),
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
