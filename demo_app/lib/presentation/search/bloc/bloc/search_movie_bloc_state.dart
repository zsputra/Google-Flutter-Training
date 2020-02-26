part of 'search_movie_bloc_bloc.dart';

@immutable
abstract class SearchMovieBlocState {
  const SearchMovieBlocState();
}

@immutable
class SearchMovieBlocInitial extends SearchMovieBlocState {
  @override
  List<Object> get props => [];
}

@immutable
class SearchMovieByTitleYearState extends SearchMovieBlocState {
  final List<OmdbMovieModel> searchMovieLists;
  SearchMovieByTitleYearState({this.searchMovieLists});
}

@immutable
class SearchMovieErrorState extends SearchMovieBlocState {
  final dynamic error;

  SearchMovieErrorState(this.error);
}

@immutable
class LikeMovieSuccessState extends SearchMovieBlocState {
  final String message;
  LikeMovieSuccessState(this.message);
}
