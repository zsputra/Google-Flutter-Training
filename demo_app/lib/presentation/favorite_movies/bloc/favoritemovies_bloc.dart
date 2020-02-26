import 'dart:async';
import 'dart:core';

import 'package:bloc/bloc.dart';
import 'package:demo_app/common/configure/getit_configuration.dart';
import 'package:demo_app/data/ws/models/ws_movie_model.dart';
import 'package:demo_app/presentation/favorite_movies/use_cases/favorite_movie_use_cases.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'favoritemovies_event.dart';
part 'favoritemovies_state.dart';

@injectable
class FavoritemoviesBloc
    extends Bloc<FavoritemoviesEvent, FavoritemoviesState> {
  GetAllFavoriteMovieUseCase getAllFavoriteMovieUseCase =
      getIt<GetAllFavoriteMovieUseCase>();

  DeleteFavoriteMovieById deleteFavoriteMovieById =
      getIt<DeleteFavoriteMovieById>();
  @override
  FavoritemoviesState get initialState => FavoritemoviesInitial();

  @override
  Stream<FavoritemoviesState> mapEventToState(
    FavoritemoviesEvent event,
  ) async* {
    if (event is GetAllFavoriteMovie) {
      yield* _loadAllFavorieMovie();
    }
    if (event is DeleteFavoriteMovie) {
      await deleteFavoriteMovieById.call(event.id);
      final favorieMovieList = await getAllFavoriteMovieUseCase.call(null);
      yield OnDeleteSuccess();
      yield FavoriteMovieLists(favoriteMovieLists: favorieMovieList);
    }
  }

  Stream<FavoritemoviesState> _loadAllFavorieMovie() async* {
    try {
      final favorieMovieList = await getAllFavoriteMovieUseCase.call(null);
      yield FavoriteMovieLists(favoriteMovieLists: favorieMovieList);
    } catch (e) {
      yield FavoriteMovieError(e);
    }
  }
}
