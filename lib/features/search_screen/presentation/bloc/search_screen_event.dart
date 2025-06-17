abstract class SearchScreenEvent {}

class SearchLatestNewsBySearchString extends SearchScreenEvent {
  String? language;
  String? searchString;

  SearchLatestNewsBySearchString({
    this.language = 'en',
    this.searchString = 'tech',
  });
}

class GetMoreNewsBySearchString extends SearchScreenEvent {
  String? language;
  String? searchString;

  GetMoreNewsBySearchString({this.language = 'en', this.searchString = 'tech'});
}
