import 'package:demo_app/common/configure/getit_configuration.dart';
import 'package:demo_app/common/models/use_case.dart';
import 'package:demo_app/data/ws/models/ws_movie_model.dart';
import 'package:demo_app/data/ws/repository/ws_repository.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
@injectable
class LikeMovieUseCase implements UseCase<void, WsMovieModel> {
  WsRepository wsRepository = getIt<WsRepository>();

  LikeMovieUseCase({@required this.wsRepository});

  @override
  Future<void> call(WsMovieModel wsMovieModel) {
    wsRepository.likeMovie(wsMovieModel);
  }
}

@lazySingleton
@injectable
class UpdateMoveCase implements UseCase<void, WsMovieModel> {
  WsRepository wsRepository = getIt<WsRepository>();

  UpdateMoveCase({@required this.wsRepository});

  @override
  Future<void> call(WsMovieModel wsMovieModel) {
    wsRepository.updateMovieById(wsMovieModel);
  }
}
