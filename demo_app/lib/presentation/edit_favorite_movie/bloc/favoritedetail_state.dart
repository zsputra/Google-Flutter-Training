part of 'favoritedetail_bloc.dart';

@immutable
abstract class FavoritedetailState {}

class FavoritedetailInitial extends FavoritedetailState {}

@immutable
class UpdateMovieError extends FavoritedetailState {
  final dynamic error;

  UpdateMovieError(this.error);
}
