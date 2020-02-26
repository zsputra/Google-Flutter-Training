import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:demo_app/common/configure/getit_configuration.dart';
import 'package:demo_app/data/ws/models/ws_movie_model.dart';
import 'package:demo_app/domain/edit_movie/use_cases/edit_movie_use_case.dart';
import 'package:demo_app/presentation/search/bloc/bloc/search_movie_bloc_bloc.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

part 'movieeditor_event.dart';
part 'movieeditor_state.dart';

@injectable
class MovieeditorBloc extends Bloc<MovieeditorEvent, MovieeditorState> {
  LikeMovieUseCase likeMovieUseCase = getIt<LikeMovieUseCase>();
  @override
  MovieeditorState get initialState => MovieeditorInitial();

  @override
  Stream<MovieeditorState> mapEventToState(
    MovieeditorEvent event,
  ) async* {
    if (event is LikeMovieEvent) {
      try {
        await likeMovieUseCase.call(event.favoriteMovie);
        yield OnSuccessSave();
      } catch (e) {
        yield MovieEditorError(e);
      }
      // yield* _LikeMovie(event.favoriteMovie);
    }
  }
}
