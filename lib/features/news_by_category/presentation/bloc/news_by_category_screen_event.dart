abstract class NewsByCategoryScreenEvent {}

class GetLatestNewsByCategory extends NewsByCategoryScreenEvent {
  String? language;
  String? typeOfNews;

  GetLatestNewsByCategory({this.language = 'en', this.typeOfNews = 'tech'});
}

class GetMoreNewsFromCategory extends NewsByCategoryScreenEvent {
  String? language;
  String? typeOfNews;

  GetMoreNewsFromCategory({this.language = 'en', this.typeOfNews = 'tech'});
}
