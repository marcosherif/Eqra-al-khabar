abstract class LatestNewsEvent {}

class GetLatestNews extends LatestNewsEvent {
  String? language;
  String? typeOfNews;

  GetLatestNews({this.language = 'en', this.typeOfNews = 'technology'});
}

