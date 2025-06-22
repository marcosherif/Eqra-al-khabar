import 'package:eqra_el_khabar/core/network/network_response.dart';
import 'package:eqra_el_khabar/core/network/network_service.dart';

import '../../../domain/entities/articles_list.dart';

class NewsService {
  final NetworkService service;

  NewsService(this.service) : super();

  Future<NetworkResponse<ArticlesList>> getLatestNews({
    required int pageIndex,
    String? typeOfNews = 'tech',
    String? language = 'en',
  }) {
    return service.request<ArticlesList>(
      path: 'everything',
      queryParameters: {
        'q': typeOfNews,
        'pageSize': 10,
        'page': pageIndex,
        'sortBy': 'publishedAt',
        'language': language,
      },
      method: MethodType.get,
      payloadParser: (json) => ArticlesList.fromJson(json),
    );
  }
}
