import 'package:eqra_el_khabar/core/network/network_response.dart';
import 'package:eqra_el_khabar/features/home_screen/data/data_source/network/news_repo_service.dart';
import 'package:eqra_el_khabar/features/home_screen/domain/entities/articles_list.dart';
import 'package:eqra_el_khabar/features/home_screen/domain/repo/news_repo.dart';

class WebNewsRepo implements NewsRepo {
  final NewsService newsService;

  WebNewsRepo(this.newsService);

  @override
  Future<NetworkResponse<ArticlesList?>> getLatestNews({
    required int pageIndex,
    String? language,
    String? typeOfNews,
  }) async => await newsService.getLatestNews(
    pageIndex: pageIndex,
    language: language,
    typeOfNews: typeOfNews,
  );
}
