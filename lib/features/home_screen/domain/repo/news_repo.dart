import 'package:eqra_el_khabar/core/network/network_response.dart';
import 'package:eqra_el_khabar/core/network/network_service.dart';
import 'package:eqra_el_khabar/features/home_screen/data/data_source/network/news_repo_service.dart';
import 'package:eqra_el_khabar/features/home_screen/data/repo_impl/web_news_repo.dart';
import 'package:eqra_el_khabar/features/home_screen/domain/entities/articles_list.dart';

abstract class NewsRepo {
  static NewsRepo initiate() {
    return WebNewsRepo(NewsService(NetworkService()));
  }

  Future<NetworkResponse<ArticlesList?>> getLatestNews({
    required int pageIndex,
    String? typeOfNews,
    String? language,
  });
}
