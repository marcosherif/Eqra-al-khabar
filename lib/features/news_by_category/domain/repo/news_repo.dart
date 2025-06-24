import 'package:eqra_el_khabar/core/network/network_response.dart';
import 'package:eqra_el_khabar/core/network/network_service.dart';

import '../../data/data_source/network/news_repo_service.dart';
import '../../data/repo_impl/web_news_repo.dart';
import '../../data/repo_mock/web_news_mock.dart';
import '../entities/articles_list.dart';

abstract class NewsRepo {
  static NewsRepo initiate() {
    return WebNewsRepo(NewsService(NetworkService()));
  }

  static NewsRepo initiateMock() {
    return MockNewsRepo();
  }

  Future<NetworkResponse<ArticlesList?>> getLatestNews({
    required int pageIndex,
    String? typeOfNews,
    String? language,
  });
}
