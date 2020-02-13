import 'dart:convert';
import 'package:demo_app/common/network/network_utils.dart';
import 'package:demo_app/common/network2/omdb_movie_client.dart';
import 'package:demo_app/data/ws/models/ws_movie_model.dart';
import 'package:demo_app/domain/entities/movies.dart';
import 'package:http/http.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import 'package:http/http.dart' as http;

@Bind.toType(WsMovieRemoteDatasourceImpl)
@injectable
abstract class WsMovieRemoteDatasource {
  Future<List<WsMovieModel>> getAllMovies();
  Future<WsMovieModel> getAllMoviesRecomendation();
  Future<Response> postMovie(WsMovieModel movie);
  Future<Response> updateMovieById(WsMovieModel movie);
  Future<Response> deleteMovieById(String id);

}

@lazySingleton
@injectable
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
    String token = "putra";
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
    String token = "putra";
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
    movieList = WsMovieModel.fromWsJson(decodedRaw);
    return movieList;
  }

  @override
  Future<Response> postMovie(WsMovieModel movie) async {
    String token = "putra";
    String uri =
        "https://demo-video-ws-chfmsoli4q-ew.a.run.app/video-ws/videos/";

    Map<String, String> headers = {
      'token': token,
      'Content-Type': 'application/json'
    };

    var json = jsonEncode(movie.toJson());
    Response response = await client.post(
      uri,
      headers: headers,
      body: json,
    ); //encoding: Encoding.getByName("utf-8"));
    return response;
  }



  @override
  Future<Response> updateMovieById(WsMovieModel movie) async {
    String token = "putra";
    String uri =
        "https://demo-video-ws-chfmsoli4q-ew.a.run.app/video-ws/videos/${movie.id}";

    Map<String, String> headers = {
      'token': token,
      'Content-Type': 'application/json'
    };
    var json = jsonEncode(movie.toJson());
    Response response = await client.put(
      uri,
      headers: headers,
      body: json,
    );
    return response;
  }

  @override
  Future<Response> deleteMovieById(String id) async {
    String token = "putra";
    String uri =
        "https://demo-video-ws-chfmsoli4q-ew.a.run.app/video-ws/videos/$id";

    Map<String, String> headers = {
      'token': token,
      'Content-Type': 'application/json'
    };
    Response response = await client.delete(
      uri,
      headers: headers,
    );
    return response;
  }
}
