import 'package:demo_app/data/omdb/datasources/omdb_remote_datasource.dart';
import 'package:demo_app/data/omdb/models/movies.dart';
import 'package:flutter/cupertino.dart';

abstract class OmdbRepository{
  Future<List<MovieDetail>> getAllMovies();
  Future<String> getJsons();
  Future<List<MovieDetail>> searchMoviesByTitle(String keyword);
}

class OmdbRepositoryImpl implements OmdbRepository{
  final OmdbMovieRemoteDatasource datasource ;
  

  OmdbRepositoryImpl({@required this.datasource});

 
  @override
  Future<List<MovieDetail>> getAllMovies() {
    return datasource.getAllMoviesFromOmdb();
  }

  @override
  Future<String> getJsons() {
    return datasource.getJsonBody();
  }

  @override
  Future<List<MovieDetail>> searchMoviesByTitle(String keyword, [String year]) {
    
    return year == null? datasource.getMoviesByTitle(keyword) : datasource.getMoviesByTitle(keyword, year);
  }

}