// a freezed class to store the settings of the app

import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shelfsdk/audiobookshelf_api.dart';

part 'library_item_extras.freezed.dart';

/// any extras when navigating to a library item
///
/// [shelfId] is the id of the shelf that the item was on before navigating to the item
/// [book] is the book that the item represents
/// [heroTagSuffix] is the suffix to use for the hero tag to avoid conflicts
@freezed
class LibraryItemExtras with _$LibraryItemExtras {
  const factory LibraryItemExtras({
    BookMinified? book,
    @Default('') String heroTagSuffix,
    Uint8List? coverImage,
  }) = _LibraryItemExtras;

}
