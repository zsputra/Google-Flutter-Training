import 'package:demo_app/data/omdb/models/movies.dart';
import 'package:demo_app/data/ws/datasources/ws_remote_datasource.dart';
import 'package:flutter/cupertino.dart';

abstract class WsRepository{
  Future<List<MovieDetail>> getAllMovies();
  Future<MovieDetail> getAllMoviesRecomendation();
  Future<void> likeMovie(MovieDetail movie);
  Future<String> getJsons();
}

class WsRepositoryImpl implements WsRepository{
  final WsMovieRemoteDatasource datasource ;
  

  WsRepositoryImpl({@required this.datasource});

 
  @override
  Future<List<MovieDetail>> getAllMovies() {
    return datasource.getAllMovies();
  }

  @override
  Future<String> getJsons() {
    return datasource.getJsonBody();
  }

  @override
  Future<MovieDetail> getAllMoviesRecomendation() {
    return datasource.getAllMoviesRecomendation();
  }

  @override
  Future<void> likeMovie(MovieDetail movie) {
    return datasource.postMovie(movie);
  }



}