import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:eqra_el_khabar/core/network/network_response.dart';
import 'package:eqra_el_khabar/features/home_screen/data/models/article.dart';
import 'package:eqra_el_khabar/features/home_screen/domain/entities/articles_list.dart';
import 'package:eqra_el_khabar/features/home_screen/domain/repo/news_repo.dart';
import 'package:eqra_el_khabar/features/home_screen/presentation/bloc/home_screen_event.dart';
import 'package:eqra_el_khabar/features/home_screen/presentation/bloc/home_screen_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  final NewsRepo newsRepo;

  HomeScreenBloc({required this.newsRepo})
    : super(HomeScreenState(status: HomeScreenStatus.initial)) {
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
    Emitter<HomeScreenState> emit,
  ) async {
    emit(state.copyWith(status: HomeScreenStatus.loading));

    NetworkResponse response = await newsRepo.getLatestNews(
      pageIndex: 1,
      language: event.language,
      typeOfNews: event.typeOfNews,
    );
    if (response.statusCode != '200') {
      emit(
        state.copyWith(
          status: HomeScreenStatus.error,
          error: response.statusMessage,
        ),
      );
    } else {
      final ArticlesList articlesList = response.payload;
      final List<Article> articles = articlesList.articles;
      emit(
        state.copyWith(
          status: HomeScreenStatus.loaded,
          latestNewsList: articles,
          newsPageIndex: 2,
          hasReachedMax: articles.length >= articlesList.totalResults,
        ),
      );
    }
  }

  Future<void> _onGetMoreNews(
    GetMoreNews event,
    Emitter<HomeScreenState> emit,
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
          status: HomeScreenStatus.error,
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
          status: HomeScreenStatus.loaded,
          latestNewsList: appendedArticlesList,
          newsPageIndex: (state.newsPageIndex ?? 1) + 1,
          hasReachedMax:
              appendedArticlesList.length >= articlesList.totalResults,
        ),
      );
    }
  }
}
