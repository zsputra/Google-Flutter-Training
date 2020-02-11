import 'dart:convert';
import 'package:demo_app/common/network/network_utils.dart';
import 'package:demo_app/data/ws/models/ws_movie_model.dart';
import 'package:demo_app/network/omdb_movie_client.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';

import 'package:http/http.dart' as http;

abstract class WsMovieRemoteDatasource {
  Future<List<WsMovieModel>> getAllMovies();
  Future<WsMovieModel> getAllMoviesRecomendation();
  Future<Response> postMovie(WsMovieModel movie);
  
  Future<String> getJsonBody();
}

class WsMovieRemoteDatasourceImpl implements WsMovieRemoteDatasource {
  final OmdbWsClient client;
  final String _host = "demo-video-ws-chfmsoli4q-ew.a.run.app";

  WsMovieRemoteDatasourceImpl({@required this.client});

  factory WsMovieRemoteDatasourceImpl.create() {
    return WsMovieRemoteDatasourceImpl(
      client: OmdbWsClientImpl(defaultHttp),
    );
  }

    

  @override
  Future<List<WsMovieModel>> getAllMovies() async {
    String token = "zainudin.saputra@dkatalis.com";
    String uri =
        "https://demo-video-ws-chfmsoli4q-ew.a.run.app/video-ws/videos";
    Map<String, String> headers = {
      'token': token,
      'Content-Type': 'application/json'
    };
    final response = await client.get(uri, headers: headers);
    String json = response.body;
    List<WsMovieModel> movieList = List<WsMovieModel>();
    List<dynamic> decodedRaw = jsonDecode(json);
    decodedRaw.forEach((x) {
      movieList.add(WsMovieModel.fromWsJson(x));
    });
    return movieList;
  }

  @override
  Future<WsMovieModel> getAllMoviesRecomendation() async {
    String token = "zainudin.saputra@dkatalis.com";
    String uri =
        "https://demo-video-ws-chfmsoli4q-ew.a.run.app/video-ws/recommended";
    Map<String, String> headers = {
      'token': token,
      'Content-Type': 'application/json'
    };
    final response = await client.get(uri, headers: headers);
    String json = response.body;
    WsMovieModel movieList = WsMovieModel();
    Map<String, dynamic> decodedRaw = jsonDecode(json);
    movieList =  WsMovieModel.fromWsJson(decodedRaw);
    return movieList;
  }

  @override
  Future<Response> postMovie(WsMovieModel movie) async {
    String token = "zainudin.saputra@dkatalis.com";
    String uri =
        "https://demo-video-ws-chfmsoli4q-ew.a.run.app/video-ws/videos";
      Uri uri1 = Uri.https(_host, "/video-ws/videos",
      );
    assert(uri == uri1.toString());
    Map<String, String> headers = {
      'token': 'zainudin.saputra@dkatalis.com',
      'Content-Type': 'application/json'
    };
    WsMovieModel _movies = WsMovieModel(id: "1", title: "Berenang", label: "label", priority: 1, poster: "poster", rating: 10, timestamp: 12331, viewed: true, year: "2020");

    final _json = '''
      {"label":"label","priority":1,"viewed":true,"rating":10,"timestamp":12331,"title":"Berenang","year":"2020","id":"1","poster":"poster"}
    ''';
    
    var json = jsonEncode(_movies.toJson());
    // print(json);
    Response response =  await http.post(uri, headers: headers, body: _json, encoding: Encoding.getByName("utf-8"));
    print(response.body);
    return response; 
    
  }

  @override
  Future<String> getJsonBody() async {
     String apikey = "f73eb4d2";
    String uri = "http://www.omdbapi.com/?s=Putra&apikey=$apikey";
    final response = await client.get(uri);
    String json = response.body;
    return json;
  }

  


}


