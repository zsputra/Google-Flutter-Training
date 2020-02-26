import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:demo_app/common/configure/getit_configuration.dart';
import 'package:demo_app/data/ws/models/ws_movie_model.dart';
import 'package:demo_app/domain/edit_movie/use_cases/edit_movie_use_case.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'favoritedetail_event.dart';
part 'favoritedetail_state.dart';

@injectable
class FavoritedetailBloc
    extends Bloc<FavoritedetailEvent, FavoritedetailState> {
  UpdateMoveCase updateMoveCase = getIt<UpdateMoveCase>();
  @override
  FavoritedetailState get initialState => FavoritedetailInitial();

  @override
  Stream<FavoritedetailState> mapEventToState(
    FavoritedetailEvent event,
  ) async* {
    if (event is UpdateMovieEvent) {
      try {
        await updateMoveCase.call(event.favoriteMovie);
      } catch (e) {
        yield UpdateMovieError(e);
      }
    }
  }
}
