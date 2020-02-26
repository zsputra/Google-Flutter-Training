part of 'favoritemovies_bloc.dart';

@immutable
abstract class FavoritemoviesEvent {}

@immutable
class GetAllFavoriteMovie extends FavoritemoviesEvent {}

@immutable
class DeleteFavoriteMovie extends FavoritemoviesEvent {
  final String id;
  DeleteFavoriteMovie(this.id);
}
