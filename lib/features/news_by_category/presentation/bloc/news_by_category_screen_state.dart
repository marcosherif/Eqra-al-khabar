import 'package:equatable/equatable.dart';

import '../../data/models/article.dart';

enum NewsByCategoryScreenStatus { initial, loading, loaded, error }

class NewsByCategoryScreenState extends Equatable {
  final NewsByCategoryScreenStatus status;
  final List<Article>? latestNewsList;
  final int? newsPageIndex;
  final bool? hasReachedMax;
  final String? error;

  const NewsByCategoryScreenState({
    this.status = NewsByCategoryScreenStatus.initial,
    this.latestNewsList,
    this.newsPageIndex = 1,
    this.hasReachedMax = false,
    this.error,
  });

  NewsByCategoryScreenState copyWith({
    NewsByCategoryScreenStatus? status,
    List<Article>? latestNewsList,
    int? newsPageIndex,
    bool? hasReachedMax,
    String? error,
  }) {
    return NewsByCategoryScreenState(
      status: status ?? this.status,
      latestNewsList: latestNewsList ?? this.latestNewsList,
      newsPageIndex: newsPageIndex ?? this.newsPageIndex,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
    status,
    latestNewsList,
    newsPageIndex,
    hasReachedMax,
    error,
  ];
}
