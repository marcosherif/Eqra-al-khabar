import 'package:eqra_el_khabar/core/network/network_response.dart';
import '../../domain/entities/articles_list.dart';
import '../../domain/repo/news_repo.dart';
import '../data_source/network/news_repo_service.dart';

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
