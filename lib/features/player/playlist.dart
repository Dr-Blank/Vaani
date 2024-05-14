import 'package:shelfsdk/audiobookshelf_api.dart';

/// will manage the playlist of items
///
/// you are responsible for updating the current index and sub index
class AudiobookPlaylist {
  /// list of items in the playlist
  final List<BookExpanded> books;

  /// current index of the item in the playlist
  int _currentIndex;

  /// current index of the audio file in the current item
  int _subCurrentIndex;

  // wrappers for adding and removing items
  void add(BookExpanded item) => books.add(item);
  void remove(BookExpanded item) => books.remove(item);
  void clear() {
    books.clear();
    _currentIndex = 0;
    _subCurrentIndex = 0;
  }

  // move an item from one index to another
  void move(int from, int to) {
    final item = books.removeAt(from);
    books.insert(to, item);
  }

  /// the book being played
  BookExpanded? get currentBook {
    if (_currentIndex >= books.length || _currentIndex < 0 || books.isEmpty) {
      return null;
    }
    return books[_currentIndex];
  }

  /// of the book in the playlist
  int get currentIndex => _currentIndex;
  // every time current index changes, we need to update the sub index
  set currentIndex(int index) {
    // if the index is the same, do nothing
    if (_currentIndex == index) {
      return;
    }
    _currentIndex = index;
    subCurrentIndex = 0;
  }

  /// of the audio file in the current book
  int get subCurrentIndex => _subCurrentIndex;

  set subCurrentIndex(int index) {
    if (index < 0) {
      index = 0;
    }
    _subCurrentIndex = index;
  }

  AudiobookPlaylist({
    this.books = const [],
    currentIndex = 0,
    subCurrentIndex = 0,
  })  : _currentIndex = currentIndex,
        _subCurrentIndex = subCurrentIndex;

  // most important method, gets the audio file to play
  // this is needed as a library item is a list of audio files
  AudioTrack? getAudioTrack() {
    final book = currentBook;
    if (book == null) {
      return null;
    }

    if (subCurrentIndex > book.tracks.length || book.tracks.isEmpty) {
      return null;
    }
    return book.tracks[subCurrentIndex];
  }

  bool get isBookFinished => subCurrentIndex >= currentBook!.tracks.length;

  // a method to get the next audio file and advance the sub index
}
