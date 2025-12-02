part of 'home_bloc.dart';


abstract class HomeEvent {}


class InitializeHomePage extends HomeEvent{}

class RefreshHomePage extends HomeEvent{}

class LoadMorePopular extends HomeEvent {}

class LoadMoreNowPlaying extends HomeEvent {}

class ToggleBookmark extends HomeEvent {
  int movieId;
  ToggleBookmark(this.movieId);
}

class InitializeSearchPage extends HomeEvent{}

class OnSearchChanged extends HomeEvent {
  String query;
  OnSearchChanged(this.query);
}

class GetMovieEvent extends HomeEvent{
  int id;
  GetMovieEvent(this.id);
}

class OpenDetailsPageFromDeepLink extends HomeEvent{
  bool val;
  OpenDetailsPageFromDeepLink(this.val);
}

class ShareMovieEvent extends HomeEvent{
  String url;
  ShareMovieEvent(this.url);
}
