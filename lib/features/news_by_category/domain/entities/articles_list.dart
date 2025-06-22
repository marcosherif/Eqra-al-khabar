import '../../data/models/article.dart';

class ArticlesList {
  final List<Article> articles;
  final int totalResults;

  ArticlesList({required this.articles, required this.totalResults});

  factory ArticlesList.fromJson(Map<String, dynamic> json) {
    return ArticlesList(
      totalResults: json['totalResults'] ?? 0,
      articles:
          (json['articles'] as List)
              .map((item) => Article.fromJson(item))
              .toList(),
    );
  }
}
