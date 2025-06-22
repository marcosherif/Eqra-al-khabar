import 'package:equatable/equatable.dart';

import '../../../news_by_category/data/models/article.dart';

enum LatestNewsStatus { initial, loading, loaded, error }

class LatestNewsState extends Equatable {
  final LatestNewsStatus status;
  final List<Article>? latestNewsList;
  final String? error;

  const LatestNewsState({
    this.status = LatestNewsStatus.initial,
    this.latestNewsList,
    this.error,
  });

  LatestNewsState copyWith({
    LatestNewsStatus? status,
    List<Article>? latestNewsList,
    int? newsPageIndex,
    bool? hasReachedMax,
    String? error,
  }) {
    return LatestNewsState(
      status: status ?? this.status,
      latestNewsList: latestNewsList ?? this.latestNewsList,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, latestNewsList, error];
}
