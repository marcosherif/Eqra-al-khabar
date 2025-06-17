class NewsTileModel {
  final String imageUrl;
  final String source;
  final String title;
  final String author;
  final DateTime publishedAt;

  const NewsTileModel({
    required this.imageUrl,
    required this.source,
    required this.title,
    required this.author,
    required this.publishedAt,
  });
}
