import 'dart:ffi';

import 'package:demo_app/common/configure/getit_configuration.dart';
import 'package:demo_app/common/models/use_case.dart';
import 'package:demo_app/data/ws/models/ws_movie_model.dart';
import 'package:demo_app/data/ws/repository/ws_repository.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
@injectable
class GetAllFavoriteMovieUseCase implements UseCase<List<WsMovieModel>, Map> {
  WsRepository wsRepository = getIt<WsRepository>();

  GetAllFavoriteMovieUseCase({@required this.wsRepository});

  @override
  Future<List<WsMovieModel>> call(Map map) {
    return wsRepository.getAllMovies();
  }
}

@lazySingleton
@injectable
class DeleteFavoriteMovieById implements UseCase<void, String> {
  WsRepository wsRepository = getIt<WsRepository>();

  DeleteFavoriteMovieById({@required this.wsRepository});

  @override
  Future<Response> call(String id) {
    return wsRepository.deleteMovieById(id);
  }
}
