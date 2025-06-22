import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:eqra_el_khabar/core/network/network_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/article.dart';
import '../../domain/entities/articles_list.dart';
import '../../domain/repo/news_repo.dart';
import 'news_by_category_screen_event.dart';
import 'news_by_category_screen_state.dart';

class NewsByCategoryScreenBloc extends Bloc<NewsByCategoryScreenEvent, NewsByCategoryScreenState> {
  final NewsRepo newsRepo;

  NewsByCategoryScreenBloc({required this.newsRepo})
    : super(NewsByCategoryScreenState(status: NewsByCategoryScreenStatus.initial)) {
    //initialize transformer for loading more news
    EventTransformer<E> throttleDroppable<E>(Duration duration) {
      return (events, mapper) {
        return droppable<E>().call(events.throttle(duration), mapper);
      };
    }

    on<GetLatestNews>(_onGetLatestNews);

    on<GetMoreNews>(
      _onGetMoreNews,
      transformer: throttleDroppable(Duration(milliseconds: 300)),
    );
  }

  Future<void> _onGetLatestNews(
    GetLatestNews event,
    Emitter<NewsByCategoryScreenState> emit,
  ) async {
    emit(state.copyWith(status: NewsByCategoryScreenStatus.loading));

    NetworkResponse response = await newsRepo.getLatestNews(
      pageIndex: 1,
      language: event.language,
      typeOfNews: event.typeOfNews,
    );
    if (response.statusCode != '200') {
      emit(
        state.copyWith(
          status: NewsByCategoryScreenStatus.error,
          error: response.statusMessage,
        ),
      );
    } else {
      final ArticlesList articlesList = response.payload;
      final List<Article> articles = articlesList.articles;
      emit(
        state.copyWith(
          status: NewsByCategoryScreenStatus.loaded,
          latestNewsList: articles,
          newsPageIndex: 2,
          hasReachedMax: articles.length >= articlesList.totalResults,
        ),
      );
    }
  }

  Future<void> _onGetMoreNews(
    GetMoreNews event,
    Emitter<NewsByCategoryScreenState> emit,
  ) async {
    if (state.hasReachedMax ?? false) return;

    NetworkResponse response = await newsRepo.getLatestNews(
      pageIndex: state.newsPageIndex ?? 1,
      language: event.language,
      typeOfNews: event.typeOfNews,
    );

    if (response.statusCode != '200') {
      emit(
        state.copyWith(
          status: NewsByCategoryScreenStatus.error,
          error: response.statusMessage,
        ),
      );
    } else {
      final ArticlesList articlesList = response.payload;
      final List<Article> newArticlesList = articlesList.articles;
      final List<Article> appendedArticlesList = [
        ...?state.latestNewsList,
        ...newArticlesList,
      ];
      emit(
        state.copyWith(
          status: NewsByCategoryScreenStatus.loaded,
          latestNewsList: appendedArticlesList,
          newsPageIndex: (state.newsPageIndex ?? 1) + 1,
          hasReachedMax:
              appendedArticlesList.length >= articlesList.totalResults,
        ),
      );
    }
  }
}
