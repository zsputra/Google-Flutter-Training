part of 'favoritemovies_bloc.dart';

@immutable
abstract class FavoritemoviesState {}

@immutable
class FavoritemoviesInitial extends FavoritemoviesState {}

@immutable
class DeleteFavEvent extends FavoritemoviesState {}

@immutable
class OnDeleteSuccess extends FavoritemoviesState {}

// @immutable
// class OnLoading extends FavoritemoviesState {}

@immutable
class FavoriteMovieLists extends FavoritemoviesState {
  final List<WsMovieModel> favoriteMovieLists;
  FavoriteMovieLists({this.favoriteMovieLists});
}

@immutable
class FavoriteMovieError extends FavoritemoviesState {
  final dynamic error;

  FavoriteMovieError(this.error);
}
