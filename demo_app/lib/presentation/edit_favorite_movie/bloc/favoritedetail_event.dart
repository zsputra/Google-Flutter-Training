part of 'favoritedetail_bloc.dart';

@immutable
abstract class FavoritedetailEvent {}

@immutable
class UpdateMovieEvent extends FavoritedetailEvent {
  final WsMovieModel favoriteMovie;
  UpdateMovieEvent({this.favoriteMovie});
}
