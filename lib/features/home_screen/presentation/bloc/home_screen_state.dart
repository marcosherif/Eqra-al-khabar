import 'package:equatable/equatable.dart';

import '../../data/models/article.dart';

enum HomeScreenStatus { initial, loading, loaded, error }

class HomeScreenState extends Equatable {
  final HomeScreenStatus status;
  final List<Article>? latestNewsList;
  final int? newsPageIndex;
  final bool? hasReachedMax;
  final String? error;

  const HomeScreenState({
    this.status = HomeScreenStatus.initial,
    this.latestNewsList,
    this.newsPageIndex = 1,
    this.hasReachedMax = false,
    this.error,
  });

  HomeScreenState copyWith({
    HomeScreenStatus? status,
    List<Article>? latestNewsList,
    int? newsPageIndex,
    bool? hasReachedMax,
    String? error,
  }) {
    return HomeScreenState(
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
