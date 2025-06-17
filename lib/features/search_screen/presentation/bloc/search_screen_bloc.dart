import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:eqra_el_khabar/features/search_screen/presentation/bloc/search_screen_event.dart';
import 'package:eqra_el_khabar/features/search_screen/presentation/bloc/search_screen_state.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:eqra_el_khabar/core/network/network_response.dart';
import 'package:eqra_el_khabar/features/home_screen/data/models/article.dart';
import 'package:eqra_el_khabar/features/home_screen/domain/entities/articles_list.dart';
import 'package:eqra_el_khabar/features/home_screen/domain/repo/news_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreenBloc extends Bloc<SearchScreenEvent, SearchScreenState> {
  final NewsRepo newsRepo;

  SearchScreenBloc({required this.newsRepo})
    : super(SearchScreenState(status: SearchScreenStatus.initial)) {
    //initialize transformer for loading more news
    EventTransformer<E> throttleDroppable<E>(Duration duration) {
      return (events, mapper) {
        return droppable<E>().call(events.throttle(duration), mapper);
      };
    }

    //initialize transformer for search
    EventTransformer<E> debounceRestartable<E>(Duration duration) {
      return (events, mapper) {
        return restartable<E>().call(events.debounce(duration), mapper);
      };
    }

    on<SearchLatestNewsBySearchString>(
      _onSearchLatestNewsBySearchString,
      transformer: debounceRestartable(Duration(milliseconds: 300)),
    );

    on<GetMoreNewsBySearchString>(
      _onGetMoreNewsBySearchString,
      transformer: throttleDroppable(Duration(milliseconds: 500)),
    );
  }

  Future<void> _onSearchLatestNewsBySearchString(
    SearchLatestNewsBySearchString event,
    Emitter<SearchScreenState> emit,
  ) async {
    if ((event.searchString ?? '').isEmpty) {
      emit(state.copyWith(status: SearchScreenStatus.initial));
      return;
    }
    emit(
      state.copyWith(
        status: SearchScreenStatus.loading,
        searchString: event.searchString,
      ),
    );

    NetworkResponse response = await newsRepo.getLatestNews(
      pageIndex: 1,
      language: event.language,
      typeOfNews: event.searchString,
    );
    if (response.statusCode != '200') {
      emit(
        state.copyWith(
          status: SearchScreenStatus.error,
          error: response.statusMessage,
        ),
      );
    } else {
      final ArticlesList articlesList = response.payload;
      final List<Article> articles = articlesList.articles;
      emit(
        state.copyWith(
          status: SearchScreenStatus.loaded,
          latestNewsList: articles,
          newsPageIndex: 2,
          hasReachedMax: articles.length >= articlesList.totalResults,
        ),
      );
    }
  }

  Future<void> _onGetMoreNewsBySearchString(
    GetMoreNewsBySearchString event,
    Emitter<SearchScreenState> emit,
  ) async {
    if (state.hasReachedMax ?? false) return;

    NetworkResponse response = await newsRepo.getLatestNews(
      pageIndex: state.newsPageIndex ?? 1,
      language: event.language,
      typeOfNews: state.searchString,
    );

    if (response.statusCode != '200') {
      emit(
        state.copyWith(
          status: SearchScreenStatus.error,
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
          status: SearchScreenStatus.loaded,
          latestNewsList: appendedArticlesList,
          newsPageIndex: (state.newsPageIndex ?? 1) + 1,
          hasReachedMax:
              appendedArticlesList.length >= articlesList.totalResults,
        ),
      );
    }
  }
}
