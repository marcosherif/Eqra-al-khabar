import 'package:bloc_test/bloc_test.dart';
import 'package:eqra_el_khabar/features/home_screen/presentation/bloc/latest_news_bloc.dart';
import 'package:eqra_el_khabar/features/home_screen/presentation/bloc/latest_news_event.dart';
import 'package:eqra_el_khabar/features/home_screen/presentation/bloc/latest_news_state.dart';
import 'package:eqra_el_khabar/features/news_by_category/domain/repo/news_repo.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helpers/mock_articles.dart';

void main() {
  late NewsRepo mockNewsRepo;
  late LatestNewsBloc latestNewsBloc;

  setUp(() {
    //initiate mock repo
    mockNewsRepo = NewsRepo.initiateMock();

    //initiate bloc
    latestNewsBloc = LatestNewsBloc(newsRepo: mockNewsRepo);
  });

  tearDown(() {
    latestNewsBloc.close();
  });


  group('success state tests', () {
    blocTest(
      'bloc load latest news when GetLatestNews is pushed',
      build: () => latestNewsBloc,
      act: (bloc) => bloc.add(GetLatestNews(language: 'en')),
      wait: const Duration(milliseconds: 300),
      expect:
          () => [
            LatestNewsState(status: LatestNewsStatus.loading),
            LatestNewsState(
              status: LatestNewsStatus.loaded,
              latestNewsList: mockLatestNewsList.articles,
            ),
          ],
    );
  });


}
