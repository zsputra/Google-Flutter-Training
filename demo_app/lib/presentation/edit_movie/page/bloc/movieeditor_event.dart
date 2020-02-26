part of 'movieeditor_bloc.dart';

@immutable
abstract class MovieeditorEvent {
  const MovieeditorEvent();
}

@immutable
class LikeMovieEvent extends MovieeditorEvent {
  final WsMovieModel favoriteMovie;
  LikeMovieEvent({this.favoriteMovie});
}
