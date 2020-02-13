import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:demo_app/common/configure/getit_configuration.dart';
import 'package:demo_app/data/omdb/models/omdb_movie_model.dart';
import 'package:demo_app/domain/search/use_cases/search_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

part 'search_movie_bloc_event.dart';
part 'search_movie_bloc_state.dart';

@injectable
class SearchMovieBlocBloc extends Bloc<SearchMovieBlocEvent, SearchMovieBlocState> {
  final GetAllMoviesByTitle getAllMoviesByTitle = getIt<GetAllMoviesByTitle>();
  @override
  SearchMovieBlocState get initialState => SearchMovieBlocInitial();

  @override
  Stream<SearchMovieBlocState> mapEventToState(
    SearchMovieBlocEvent event,
  ) async* {
    if(event is SearchMovieByTitleYear){
      yield* _loadAllMovieByTitleAndYear(event.map);
    }
    // TODO: Add Logic
  }

  Stream<SearchMovieBlocState> _loadAllMovieByTitleAndYear(Map props) async* {
    try {
      final searchMovieList = await getAllMoviesByTitle({'title' : props['title'] , 'props' :props['title']});
      yield SearchMovieByTitleYearState(searchMovieLists: searchMovieList);
    } catch (e) {
      yield SearchMovieErrorState(e);
    }
  }
}
