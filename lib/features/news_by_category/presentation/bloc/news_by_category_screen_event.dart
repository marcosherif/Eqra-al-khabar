abstract class NewsByCategoryScreenEvent {}

class GetLatestNews extends NewsByCategoryScreenEvent {
  String? language;
  String? typeOfNews;

  GetLatestNews({this.language = 'en', this.typeOfNews = 'tech'});
}

class GetMoreNews extends NewsByCategoryScreenEvent {
  String? language;
  String? typeOfNews;

  GetMoreNews({this.language = 'en', this.typeOfNews = 'tech'});
}
