import 'package:isar/isar.dart';

part 'image.g.dart';

/// Represents a cover image for a library item
///
/// stores 2 paths, one is thumbnail and the other is the full size image
/// both are optional
/// also stores last fetched date for the image
/// Id is passed as a parameter to the collection annotation (the lib_item_id)
/// also index the id
/// This is because the image is a part of the library item and the library item
/// is the parent of the image
@Collection(ignore: {'path'})
@Name('CacheImage')
class Image {
  @Id()
  int id;

  String? thumbnailPath;
  String? imagePath;
  DateTime lastSaved;

  Image({
    required this.id,
    this.thumbnailPath,
    this.imagePath,
  }) : lastSaved = DateTime.now();

  /// returns the path to the image
  String? get path => thumbnailPath ?? imagePath;

  /// automatically updates the last fetched date when saving a new path
  void updatePath(String? thumbnailPath, String? imagePath) async {
    this.thumbnailPath = thumbnailPath;
    this.imagePath = imagePath;
    lastSaved = DateTime.now();
  }
}
