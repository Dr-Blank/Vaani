import 'package:shelfsdk/audiobookshelf_api.dart';

extension TotalSize on LibraryItemExpanded {
  int get totalSize {
    return libraryFiles.fold(
      0,
      (previousValue, element) => previousValue + element.metadata.size,
    );
  }
}
