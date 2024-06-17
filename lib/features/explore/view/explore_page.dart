import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shelfsdk/audiobookshelf_api.dart';
import 'package:whispering_pages/api/api_provider.dart';
import 'package:whispering_pages/api/image_provider.dart';
import 'package:whispering_pages/api/library_item_provider.dart';
import 'package:whispering_pages/constants/hero_tag_conventions.dart';
import 'package:whispering_pages/features/explore/providers/search_controller.dart';
import 'package:whispering_pages/features/explore/view/search_result_page.dart';
import 'package:whispering_pages/router/router.dart';
import 'package:whispering_pages/settings/api_settings_provider.dart';
import 'package:whispering_pages/settings/app_settings_provider.dart';
import 'package:whispering_pages/shared/extensions/model_conversions.dart';
import 'package:whispering_pages/shared/widgets/shelves/book_shelf.dart';

const Duration debounceDuration = Duration(milliseconds: 500);

class ExplorePage extends HookConsumerWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // hooks for the dark mode
    final settings = ref.watch(appSettingsProvider);
    final api = ref.watch(authenticatedApiProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Explore'),
        backgroundColor: Colors.transparent,
      ),
      body: const MySearchBar(),
    );
  }
}

class MySearchBar extends HookConsumerWidget {
  const MySearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchController = ref.watch(globalSearchControllerProvider);
    final searchBarFocusNode = useFocusNode();
    final api = ref.watch(authenticatedApiProvider);
    final settings = ref.watch(apiSettingsProvider);

    // The query currently being searched for. If null, there is no pending
    // request.
    String? currentQuery;

    // The most recent suggestions received from the API.
    final lastOptions = useState(<Widget>[]);

    // Calls the "remote" API to search with the given query. Returns null when
    // the call has been made obsolete.
    Future<LibrarySearchResponse?> search(String query) async {
      currentQuery = query;

      // In a real application, there should be some error handling here.
      final options = await api.libraries
          .search(libraryId: settings.activeLibraryId!, query: query, limit: 3);

      // If another search happened after this one, throw away these options.
      if (currentQuery != query) {
        return null;
      }
      currentQuery = null;

      return options;
    }

    final debouncedSearch = _debounce(search);

    return SearchAnchor(
      searchController: searchController,
      textInputAction: TextInputAction.search,
      dividerColor: Colors.transparent,
      builder: (context, controller) {
        return SearchBar(
          controller: controller,
          focusNode: searchBarFocusNode,
          // "What's your next page-turner?"
          // "Looking for a good read? Type it in!"
          // "Your next adventure is a search away..."
          // "Bookworms unite! What's your pick today?"
          // "Let's find your next literary love..."
          // "Type in your next escape..."
          // "What's on your reading list today?"
          // "Seek and you shall find... your next book!"
          // "Let's uncover your next favorite book..."
          // "Ready to dive into a new story?"
          hintText: 'Seek and you shall discover...',
          // opacity: 0.5 for the hint text
          hintStyle: WidgetStatePropertyAll(
            Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                ),
          ),
          textInputAction: TextInputAction.search,
          onTapOutside: (_) {
            searchBarFocusNode.unfocus();
          },
          padding: const WidgetStatePropertyAll(
            EdgeInsets.symmetric(horizontal: 16.0),
          ),
          onTap: () {
            controller.openView();
          },
          onChanged: (_) {
            controller.openView();
          },
          leading: const Icon(Icons.search),
        );
      },
      viewOnSubmitted: (value) {
        context.pushNamed(
          Routes.search.name,
          queryParameters: {
            'q': value,
          },
        );
      },
      suggestionsBuilder: (context, controller) async {
        // check if the search controller is empty
        if (controller.text.isEmpty) {
          // TODO: show recent searches
          return <Widget>[];
        }
        final options = await debouncedSearch(controller.text);
        // debugPrint('options: $options');
        if (options == null) {
          // TODO: show loading indicator or failure message
          return <Widget>[const ListTile(title: Text('Loading...'))];
        }
        // see if BookLibrarySearchResponse or PodcastLibrarySearchResponse
        if (options is BookLibrarySearchResponse) {
          lastOptions.value = buildBookSearchResult(options, context);
        } else if (options is PodcastLibrarySearchResponse) {
          lastOptions.value = options.podcast
              .map(
                (result) => ListTile(
                  title: Text(result.libraryItem.id),
                  subtitle: Text(result.libraryItem.libraryId),
                ),
              )
              .toList();
        }
        return lastOptions.value;
      },
      viewBuilder: (suggestions) {
        // return a container such that on tap other than the suggestions, the view is closed
        return GestureDetector(
          onTap: () {
            searchController.closeView(searchController.text);
            searchBarFocusNode.unfocus();
          },
          child: ListView.builder(
            itemCount: suggestions.length,
            itemBuilder: (context, index) {
              return suggestions.toList()[index];
            },
          ),
        );
      },
    );
  }
}

List<Widget> buildBookSearchResult(
  BookLibrarySearchResponse options,
  BuildContext context,
) {
  // build sections for the search results
  // 1. Books
  // 2. Authors
  // 3. Series
  // 4. Tags
  // 5. Narrators
  // each section will have a title and a list of items
  // only show the section if there are items in it
  final sections = <Widget>[];
  if (options.book.isNotEmpty) {
    sections.add(
      SearchResultMiniSection(
        // title: 'Books',
        category: SearchResultCategory.books,
        options: options.book.map(
          (result) {
            // convert result to a book object
            final book = result.libraryItem.media.asBookExpanded;
            final metadata = book.metadata.asBookMetadataExpanded;
            return BookSearchResultMini(book: book, metadata: metadata);
          },
        ),
      ),
    );
  }
  if (options.authors.isNotEmpty) {
    sections.add(
      SearchResultMiniSection(
        // title: 'Authors',
        category: SearchResultCategory.authors,
        options: options.authors.map(
          (result) {
            return ListTile(title: Text(result.name));
          },
        ),
      ),
    );
  }

  return sections;
}

/// A mini version of the book that is displayed in the search results.
class BookSearchResultMini extends HookConsumerWidget {
  const BookSearchResultMini({
    super.key,
    required this.book,
    required this.metadata,
  });

  final BookExpanded book;
  final BookMetadataExpanded metadata;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final item = ref.watch(libraryItemProvider(book.libraryItemId)).valueOrNull;
    final image = item == null
        ? const AsyncValue.loading()
        : ref.watch(coverImageProvider(item));
    return ListTile(
      leading: SizedBox(
        width: 50,
        height: 50,
        child: Hero(
          tag: HeroTagPrefixes.bookCover + book.libraryItemId,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: image.when(
              data: (bytes) => Image.memory(
                bytes,
                fit: BoxFit.cover,
              ),
              loading: () => const BookCoverSkeleton(),
              error: (error, _) => const Icon(Icons.error),
            ),
          ),
        ),
      ),
      title: Text(book.metadata.title ?? ''),
      subtitle: Text(
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        metadata.authors
            .map(
              (author) => author.name,
            )
            .join(', '),
      ),
      onTap: () {
        // navigate to the book details page
        context.pushNamed(
          Routes.libraryItem.name,
          pathParameters: {
            Routes.libraryItem.pathParamName!: book.libraryItemId,
          },
        );
      },
      trailing: IconButton(
        icon: const Icon(Icons.more_vert),
        onPressed: () {
          // TODO: show a menu with options for the book
        },
      ),
    );
  }
}

class SearchResultMiniSection extends HookConsumerWidget {
  const SearchResultMiniSection({
    super.key,
    required this.category,
    required this.options,
    this.onTap,
  });

  // final String title;
  final SearchResultCategory category;
  final Iterable<Widget> options;

  /// A callback that is called when the section is tapped.
  /// typically used to navigate to a search page for the section
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchController = ref.watch(globalSearchControllerProvider);
    openSearch() {
      final query = searchController.text;
      context.pushNamed(
        Routes.search.name,
        queryParameters: {
          'q': query,
          'category': category.toString().split('.').last,
        },
      );
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // title for the section
          // Heading and then a hr line
          Row(
            children: [
              Text(
                category.toString().split('.').last,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.arrow_forward_ios),
                onPressed: onTap ?? openSearch,
              ),
            ],
          ),
          // const Divider(
          //   height: 1,
          //   thickness: BorderSide.strokeAlignCenter,
          // ),
          ...options,
        ],
      ),
    );
  }
}

typedef _Debounceable<S, T> = Future<S?> Function(T parameter);

/// Returns a new function that is a debounced version of the given function.
///
/// This means that the original function will be called only after no calls
/// have been made for the given Duration.
_Debounceable<S, T> _debounce<S, T>(_Debounceable<S?, T> function) {
  _DebounceTimer? debounceTimer;

  return (T parameter) async {
    if (debounceTimer != null && !debounceTimer!.isCompleted) {
      debounceTimer!.cancel();
    }
    debounceTimer = _DebounceTimer();
    try {
      await debounceTimer!.future;
    } catch (error) {
      if (error is _CancelException) {
        return null;
      }
      rethrow;
    }
    return function(parameter);
  };
}

// A wrapper around Timer used for debouncing.
class _DebounceTimer {
  _DebounceTimer() {
    _timer = Timer(debounceDuration, _onComplete);
  }

  late final Timer _timer;
  final Completer<void> _completer = Completer<void>();

  void _onComplete() {
    _completer.complete();
  }

  Future<void> get future => _completer.future;

  bool get isCompleted => _completer.isCompleted;

  void cancel() {
    _timer.cancel();
    _completer.completeError(const _CancelException());
  }
}

// An exception indicating that the timer was canceled.
class _CancelException implements Exception {
  const _CancelException();
}
