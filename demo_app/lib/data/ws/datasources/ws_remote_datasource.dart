import 'dart:convert';
import 'package:demo_app/data/omdb/models/movies.dart';
import 'package:demo_app/network/omdb_movie_client.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';

import 'package:http/http.dart' as http;

abstract class WsMovieRemoteDatasource {
  Future<List<MovieDetail>> getAllMovies();
  Future<MovieDetail> getAllMoviesRecomendation();
  Future<Response> postMovie(MovieDetail movie);
  
  Future<String> getJsonBody();
}

class WsMovieRemoteDatasourceImpl implements WsMovieRemoteDatasource {
  final OmdbWsClient client;

  WsMovieRemoteDatasourceImpl({@required this.client});

  factory WsMovieRemoteDatasourceImpl.create() {
    return WsMovieRemoteDatasourceImpl(
      client: OmdbWsClientImpl(http.Client()),
    );
  }

    

  @override
  Future<List<MovieDetail>> getAllMovies() async {
    String token = "zainudin.saputra@dkatalis.com";
    String uri =
        "https://demo-video-ws-chfmsoli4q-ew.a.run.app/video-ws/videos";
    Map<String, String> headers = {
      'token': token,
      'Content-Type': 'application/json'
    };
    final response = await client.get(uri, headers: headers);
    String json = response.body;
    List<MovieDetail> movieList = List<MovieDetail>();
    List<dynamic> decodedRaw = jsonDecode(json);
    decodedRaw.forEach((x) {
      movieList.add(MovieDetail.fromWsJson(x));
    });
    return movieList;
  }

  @override
  Future<MovieDetail> getAllMoviesRecomendation() async {
    String token = "zainudin.saputra@dkatalis.com";
    String uri =
        "https://demo-video-ws-chfmsoli4q-ew.a.run.app/video-ws/recommended";
    Map<String, String> headers = {
      'token': token,
      'Content-Type': 'application/json'
    };
    final response = await client.get(uri, headers: headers);
    String json = response.body;
    MovieDetail movieList = MovieDetail();
    Map<String, dynamic> decodedRaw = jsonDecode(json);
    movieList =  MovieDetail.fromWsJson(decodedRaw);
    return movieList;
  }

  @override
  Future<Response> postMovie(MovieDetail movie) async {
    String token = "zainudin.saputra@dkatalis.com";
    String uri =
        "https://demo-video-ws-chfmsoli4q-ew.a.run.app/video-ws/videos";
    Map<String, String> headers = {
      'token': token,
      'Content-Type': 'application/json'
    };
    MovieDetail movies = MovieDetail(id: "1", title: "Berenang", label: "label", priority: 1, poster: "poster", rating: 10, timestamp: 12331, viewed: true, year: "2020");
    var json = jsonEncode(movies.toJson());
    // print(json);
    Response response =  await client.post(uri, headers: headers, body: json);
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


