import 'dart:convert';
import 'package:demo_app/common/network/network_utils.dart';
import 'package:demo_app/common/network2/omdb_movie_client.dart';
import 'package:demo_app/data/omdb/models/omdb_movie_model.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import 'package:http/http.dart' as http;

@Bind.toType(OmdbMovieRemoteDatasourceImpl)
@injectable
abstract class OmdbMovieRemoteDatasource {
  Future<List<OmdbMovieModel>> getAllMoviesFromOmdb();
  Future<List<OmdbMovieModel>> getMoviesByTitle(String keyword, [String year]);
  
}

@injectable
@lazySingleton
class OmdbMovieRemoteDatasourceImpl implements OmdbMovieRemoteDatasource {
  final OmdbWsClient client;

  OmdbMovieRemoteDatasourceImpl({@required this.client});

  factory OmdbMovieRemoteDatasourceImpl.create() {
    return OmdbMovieRemoteDatasourceImpl(
      client: OmdbWsClientImpl(defaultHttp),
      
    );
  }

    
  

  @override
  Future<List<OmdbMovieModel>> getAllMoviesFromOmdb() async {
    String token = "zainudin.saputra@dkatalis.com";
    String uri =
        "https://demo-video-ws-chfmsoli4q-ew.a.run.app/video-ws/videos";
    Map<String, String> headers = {
      'token': token,
      'Content-Type': 'application/json'
    };
    final response = await client.get(uri, headers: headers);
    String json = response.body;
    List<OmdbMovieModel> movieList = List<OmdbMovieModel>();
    List<dynamic> decodedRaw = jsonDecode(json);
    decodedRaw.forEach((x) {
      movieList.add(OmdbMovieModel.fromOmdbJson(x));
    });
    return movieList;
  }


  @override
  Future<List<OmdbMovieModel>> getMoviesByTitle(String keyword, [String year]) async {
    String apikey = "f73eb4d2";
    String uri = keyword==null ? "http://www.omdbapi.com/?s=$keyword&apikey=$apikey" : "http://www.omdbapi.com/?s=$keyword&y=$year&apikey=$apikey";
    final response = await client.get(uri);
    String json = response.body;
    List<OmdbMovieModel> movieList = List<OmdbMovieModel>();
    Map<String, dynamic> resonseMap = jsonDecode(json);
    List<dynamic> decodedRaw = resonseMap["Search"];
    decodedRaw.forEach((x) {
      movieList.add(OmdbMovieModel.fromOmdbJson(x));
    });
    return movieList; 
  }

}


