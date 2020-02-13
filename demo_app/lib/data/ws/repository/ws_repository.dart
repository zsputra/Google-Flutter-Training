import 'package:demo_app/data/ws/datasources/ws_remote_datasource.dart';
import 'package:demo_app/data/ws/models/ws_movie_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:injectable/injectable.dart';

@Bind.toType(WsRepositoryImpl)
@injectable
abstract class WsRepository{
  Future<List<WsMovieModel>> getAllMovies();
  Future<WsMovieModel> getAllMoviesRecomendation();
  Future<void> likeMovie(WsMovieModel movie);
  Future<Response> updateMovieById(WsMovieModel movie);
  Future<Response> deleteMovieById(String id);
}


@lazySingleton
@injectable
class WsRepositoryImpl implements WsRepository{
  final WsMovieRemoteDatasource datasource ;
  

  WsRepositoryImpl({@required this.datasource});

 
  @override
  Future<List<WsMovieModel>> getAllMovies() {
    return datasource.getAllMovies();
  }


  @override
  Future<WsMovieModel> getAllMoviesRecomendation() {
    return datasource.getAllMoviesRecomendation();
  }

  @override
  Future<void> likeMovie(WsMovieModel movie) {
    return datasource.postMovie(movie);
  }

  @override
  Future<Response> deleteMovieById(String id) {
    return datasource.deleteMovieById(id);
  }

  @override
  Future<Response> updateMovieById(WsMovieModel movie) {
    return datasource.updateMovieById(movie);
  }



}