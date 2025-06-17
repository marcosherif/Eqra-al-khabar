abstract class HomeScreenEvent {}

class GetLatestNews extends HomeScreenEvent {
  String? language;
  String? typeOfNews;

  GetLatestNews({this.language = 'en', this.typeOfNews = 'tech'});
}

class GetMoreNews extends HomeScreenEvent {
  String? language;
  String? typeOfNews;

  GetMoreNews({this.language = 'en', this.typeOfNews = 'tech'});
}
