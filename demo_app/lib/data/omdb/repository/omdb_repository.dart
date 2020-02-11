import 'package:demo_app/data/omdb/datasources/omdb_remote_datasource.dart';
import 'package:demo_app/data/omdb/models/omdb_movie_model.dart';
import 'package:flutter/cupertino.dart';

abstract class OmdbRepository{
  Future<List<OmdbMovieModel>> getAllMovies();
  Future<String> getJsons();
  Future<List<OmdbMovieModel>> searchMoviesByTitle(String keyword);
}

class OmdbRepositoryImpl implements OmdbRepository{
  final OmdbMovieRemoteDatasource datasource ;
  

  OmdbRepositoryImpl({@required this.datasource});

 
  @override
  Future<List<OmdbMovieModel>> getAllMovies() {
    return datasource.getAllMoviesFromOmdb();
  }

  @override
  Future<String> getJsons() {
    return datasource.getJsonBody();
  }

  @override
  Future<List<OmdbMovieModel>> searchMoviesByTitle(String keyword, [String year]) {
    
    return year == null? datasource.getMoviesByTitle(keyword) : datasource.getMoviesByTitle(keyword, year);
  }

}