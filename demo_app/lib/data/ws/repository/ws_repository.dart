import 'package:demo_app/data/ws/datasources/ws_remote_datasource.dart';
import 'package:demo_app/data/ws/models/ws_movie_model.dart';
import 'package:flutter/cupertino.dart';

abstract class WsRepository{
  Future<List<WsMovieModel>> getAllMovies();
  Future<WsMovieModel> getAllMoviesRecomendation();
  Future<void> likeMovie(WsMovieModel movie);
  Future<String> getJsons();
}

class WsRepositoryImpl implements WsRepository{
  final WsMovieRemoteDatasource datasource ;
  

  WsRepositoryImpl({@required this.datasource});

 
  @override
  Future<List<WsMovieModel>> getAllMovies() {
    return datasource.getAllMovies();
  }

  @override
  Future<String> getJsons() {
    return datasource.getJsonBody();
  }

  @override
  Future<WsMovieModel> getAllMoviesRecomendation() {
    return datasource.getAllMoviesRecomendation();
  }

  @override
  Future<void> likeMovie(WsMovieModel movie) {
    return datasource.postMovie(movie);
  }



}