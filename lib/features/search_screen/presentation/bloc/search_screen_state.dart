import 'package:equatable/equatable.dart';

import '../../../news_by_category/data/models/article.dart';

enum SearchScreenStatus { initial, loading, loaded, error }

class SearchScreenState extends Equatable {
  final SearchScreenStatus status;
  final List<Article>? latestNewsList;
  final int? newsPageIndex;
  final bool? hasReachedMax;
  final String? searchString;
  final String? error;

  const SearchScreenState({
    this.status = SearchScreenStatus.initial,
    this.latestNewsList,
    this.newsPageIndex = 1,
    this.hasReachedMax = false,
    this.searchString,
    this.error,
  });

  SearchScreenState copyWith({
    SearchScreenStatus? status,
    List<Article>? latestNewsList,
    int? newsPageIndex,
    bool? hasReachedMax,
    String? searchString,
    String? error,
  }) {
    return SearchScreenState(
      status: status ?? this.status,
      latestNewsList: latestNewsList ?? this.latestNewsList,
      newsPageIndex: newsPageIndex ?? this.newsPageIndex,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      searchString: searchString ?? this.searchString,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
    status,
    latestNewsList,
    newsPageIndex,
    hasReachedMax,
    searchString,
    error,
  ];
}
