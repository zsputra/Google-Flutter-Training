part of 'search_movie_bloc_bloc.dart';

@immutable
abstract class SearchMovieBlocEvent {
  
}

@immutable
class SearchMovieInit extends SearchMovieBlocEvent {
}

@immutable
class SearchMovieByTitleYear extends SearchMovieBlocEvent {
  final Map map;
  SearchMovieByTitleYear(this.map);
}