import 'package:shelfsdk/audiobookshelf_api.dart';

extension LibraryItemConversion on LibraryItem {
  LibraryItemExpanded get asExpanded =>
      LibraryItemExpanded.fromJson(toJson());

  LibraryItemMinified get asMinified =>
      LibraryItemMinified.fromJson(toJson());
}

extension MediaConversion on Media {
  Book get asBook => Book.fromJson(toJson());
  BookExpanded get asBookExpanded => BookExpanded.fromJson(toJson());
  BookMinified get asBookMinified => BookMinified.fromJson(toJson());

  Podcast get asPodcast => Podcast.fromJson(toJson());
  PodcastExpanded get asPodcastExpanded => PodcastExpanded.fromJson(toJson());
  PodcastMinified get asPodcastMinified => PodcastMinified.fromJson(toJson());
}

extension MediaMetadataConversion on MediaMetadata {
  BookMetadata get asBookMetadata => BookMetadata.fromJson(toJson());
  BookMetadataExpanded get asBookMetadataExpanded =>
      BookMetadataExpanded.fromJson(toJson());
  BookMetadataMinified get asBookMetadataMinified =>
      BookMetadataMinified.fromJson(toJson());

  BookMetadataSeriesFilter get asBookMetadataSeriesFilter =>
      BookMetadataSeriesFilter.fromJson(toJson());
  BookMetadataMinifiedSeriesFilter get asBookMetadataMinifiedSeriesFilter =>
      BookMetadataMinifiedSeriesFilter.fromJson(toJson());

  PodcastMetadata get asPodcastMetadata => PodcastMetadata.fromJson(toJson());
  PodcastMetadataExpanded get asPodcastMetadataExpanded =>
      PodcastMetadataExpanded.fromJson(toJson());
}

extension AuthorConversion on Author {
  AuthorExpanded get asExpanded => AuthorExpanded.fromJson(toJson());
  AuthorMinified get asMinified => AuthorMinified.fromJson(toJson());
}

extension ShelfConversion on Shelf {
  LibraryItemShelf get asLibraryItemShelf =>
      LibraryItemShelf.fromJson(toJson());
  SeriesShelf get asSeriesShelf => SeriesShelf.fromJson(toJson());
  AuthorShelf get asAuthorShelf => AuthorShelf.fromJson(toJson());
}
