import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shelfsdk/audiobookshelf_api.dart';
import 'package:whispering_pages/features/explore/providers/search_result_provider.dart';
import 'package:whispering_pages/features/explore/view/explore_page.dart';
import 'package:whispering_pages/shared/extensions/model_conversions.dart';

enum SearchResultCategory {
  books,
  authors,
  series,
  tags,
  narrators,
}

class SearchResultPage extends HookConsumerWidget {
  const SearchResultPage({
    super.key,
    required this.query,
    this.category,
    Object? extra,
  });

  /// The search query.
  final String query;

  /// The category of the search result, if not provided, the search result will be displayed in all categories.
  final SearchResultCategory? category;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final results = ref.watch(searchResultProvider(query));
    return Scaffold(
      appBar: AppBar(
        title: Text(
          category != null
              ? '${category.toString().split('.').last} in "$query"'
              : 'Search result for $query',
        ),
      ),
      body: results.when(
        data: (options) {
          if (options == null) {
            return Container(
              child: const Text('No data found'),
            );
          }
          if (options is BookLibrarySearchResponse) {
            if (category == null) {
              return Container();
            }
            return switch (category!) {
              SearchResultCategory.books => ListView.builder(
                  itemCount: options.book.length,
                  itemBuilder: (context, index) {
                    final book =
                        options.book[index].libraryItem.media.asBookExpanded;
                    final metadata = book.metadata.asBookMetadataExpanded;

                    return BookSearchResultMini(
                      book: book,
                      metadata: metadata,
                    );
                  },
                ),
              SearchResultCategory.authors => Container(),
              SearchResultCategory.series => Container(),
              SearchResultCategory.tags => Container(),
              SearchResultCategory.narrators => Container(),
            };
          }
          return null;
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stackTrace) => Center(
          child: Text('Error: $error'),
        ),
      ),
    );
  }
}
