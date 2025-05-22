import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shelfsdk/audiobookshelf_api.dart';
import 'package:vaani/api/image_provider.dart';
import 'package:vaani/settings/models/app_settings.dart';
import 'package:vaani/settings/app_settings_provider.dart';
import 'package:vaani/shared/widgets/shelves/book_shelf.dart';

import 'book_shelf_test.mocks.dart';

// Mocks
@GenerateNiceMocks([
  MockSpec<LibraryItem>(),
  MockSpec<Media>(),
  MockSpec<BookMinified>(),
  MockSpec<BookMetadataMinified>(),
  MockSpec<LibraryItemShelf>(),
  MockSpec<CoverImageNotifier>(),
])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  // Helper function to create a mock LibraryItem
  MockLibraryItem _createMockLibraryItem(String id) {
    final mockItem = MockLibraryItem();
    final mockMedia = MockMedia();
    final mockBookMinified = MockBookMinified();
    final mockBookMetadataMinified = MockBookMetadataMinified();

    when(mockItem.id).thenReturn(id);
    when(mockItem.mediaType).thenReturn(MediaType.book);
    when(mockItem.media).thenReturn(mockMedia);
    when(mockMedia.asBookMinified).thenReturn(mockBookMinified);
    when(mockBookMinified.metadata).thenReturn(mockBookMetadataMinified);
    when(mockBookMetadataMinified.title).thenReturn('Test Book Title');
    when(mockBookMetadataMinified.authorName).thenReturn('Test Author');
    return mockItem;
  }

  // Helper function to create a mock LibraryItemShelf
  MockLibraryItemShelf _createMockLibraryItemShelf(List<LibraryItem> items) {
    final mockShelf = MockLibraryItemShelf();
    when(mockShelf.id).thenReturn('test-shelf-id');
    when(mockShelf.entities).thenReturn(items);
    return mockShelf;
  }

  // Helper function to pump BookHomeShelf with specific settings
  Future<void> pumpBookHomeShelf({
    required WidgetTester tester,
    required String title,
    required LibraryItemShelf shelf,
    required AppSettings appSettings,
  }) async {
    final mockCoverImageNotifier = MockCoverImageNotifier();
    when(mockCoverImageNotifier.build(any)).thenAnswer((_) => Uint8List(0));
    when(mockCoverImageNotifier.future).thenAnswer((_) async => Uint8List(0));


    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appSettingsProvider.overrideWithValue(
            AppSettingsNotifier(appSettings),
          ),
          // Mock the coverImageProvider to avoid network calls or file system access
          coverImageProvider(any).overrideWith((ref, id) => mockCoverImageNotifier),
        ],
        child: MaterialApp(
          home: Scaffold(
            body: BookHomeShelf(
              title: title,
              shelf: shelf,
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle(); // Let animations and futures settle
  }

  // Function to find BookOnShelf and check its showPlayButton property
  bool getShowPlayButtonForBookOnShelf(WidgetTester tester, String itemId) {
    final bookOnShelfFinder = find.byWidgetPredicate(
        (widget) => widget is BookOnShelf && widget.item.id == itemId);
    expect(bookOnShelfFinder, findsOneWidget);
    final bookOnShelfWidget = tester.widget<BookOnShelf>(bookOnShelfFinder);
    return bookOnShelfWidget.showPlayButton;
  }

  group('BookHomeShelf Play Button Visibility', () {
    late MockLibraryItem mockItem1;
    late MockLibraryItemShelf mockShelf;

    setUp(() {
      mockItem1 = _createMockLibraryItem('item1');
      mockShelf = _createMockLibraryItemShelf([mockItem1]);
    });

    testWidgets('Continue Shelves - Default: showPlayButton should be true',
        (WidgetTester tester) async {
      const appSettings = AppSettings(); // Default settings

      await pumpBookHomeShelf(
        tester: tester,
        title: 'Continue Listening',
        shelf: mockShelf,
        appSettings: appSettings,
      );

      expect(getShowPlayButtonForBookOnShelf(tester, 'item1'), isTrue);
    });

    testWidgets('Continue Shelves - Hidden: showPlayButton should be false',
        (WidgetTester tester) async {
      const appSettings = AppSettings(
        homePageSettings: HomePageSettings(
          showPlayButtonOnContinueShelves: false,
          showPlayButtonOnAllShelves: false, // Keep others default
        ),
      );

      await pumpBookHomeShelf(
        tester: tester,
        title: 'Continue Series', // Another continue shelf title
        shelf: mockShelf,
        appSettings: appSettings,
      );

      expect(getShowPlayButtonForBookOnShelf(tester, 'item1'), isFalse);
    });

    testWidgets('Other Shelves - Default: showPlayButton should be false',
        (WidgetTester tester) async {
      const appSettings = AppSettings(); // Default settings

      await pumpBookHomeShelf(
        tester: tester,
        title: 'Discover',
        shelf: mockShelf,
        appSettings: appSettings,
      );

      expect(getShowPlayButtonForBookOnShelf(tester, 'item1'), isFalse);
    });

    testWidgets('Other Shelves - Shown: showPlayButton should be true',
        (WidgetTester tester) async {
      const appSettings = AppSettings(
        homePageSettings: HomePageSettings(
          showPlayButtonOnContinueShelves: true, // Keep others default
          showPlayButtonOnAllShelves: true,
        ),
      );

      await pumpBookHomeShelf(
        tester: tester,
        title: 'New Releases',
        shelf: mockShelf,
        appSettings: appSettings,
      );

      expect(getShowPlayButtonForBookOnShelf(tester, 'item1'), isTrue);
    });
  });
}
