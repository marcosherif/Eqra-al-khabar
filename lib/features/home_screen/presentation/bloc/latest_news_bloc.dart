import 'package:eqra_el_khabar/core/network/network_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../news_by_category/data/models/article.dart';
import '../../../news_by_category/domain/entities/articles_list.dart';
import '../../../news_by_category/domain/repo/news_repo.dart';
import 'latest_news_event.dart';
import 'latest_news_state.dart';

class LatestNewsBloc extends Bloc<LatestNewsEvent, LatestNewsState> {
  final NewsRepo newsRepo;

  LatestNewsBloc({required this.newsRepo})
    : super(LatestNewsState(status: LatestNewsStatus.initial)) {
    on<GetLatestNews>(_onGetLatestNews);
  }

  Future<void> _onGetLatestNews(
    GetLatestNews event,
    Emitter<LatestNewsState> emit,
  ) async {
    emit(state.copyWith(status: LatestNewsStatus.loading));

    NetworkResponse response = await newsRepo.getLatestNews(
      pageIndex: 1,
      language: event.language,
      typeOfNews: event.typeOfNews,
    );
    if (response.statusCode != '200') {
      emit(
        state.copyWith(
          status: LatestNewsStatus.error,
          error: response.statusMessage,
        ),
      );
    } else {
      final ArticlesList articlesList = response.payload;
      final List<Article> articles = articlesList.articles;
      emit(
        state.copyWith(
          status: LatestNewsStatus.loaded,
          latestNewsList: articles,
        ),
      );
    }
  }
}
