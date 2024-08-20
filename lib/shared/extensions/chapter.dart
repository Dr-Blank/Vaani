import 'package:shelfsdk/audiobookshelf_api.dart';

extension ChapterDuration on BookChapter {
  Duration get duration {
    // end - start
    return end - start;
  }
}
