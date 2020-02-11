import 'dart:convert';
import 'package:demo_app/common/network/network_utils.dart';
import 'package:demo_app/data/omdb/models/omdb_movie_model.dart';
import 'package:demo_app/network/omdb_movie_client.dart';
import 'package:meta/meta.dart';

import 'package:http/http.dart' as http;

abstract class OmdbMovieRemoteDatasource {
  Future<List<OmdbMovieModel>> getMoviesByDate(String date);
  Future<List<OmdbMovieModel>> getAllMoviesFromOmdb();
  Future<List<OmdbMovieModel>> getMoviesByTitle(String keyword, [String year]);
  Future<List<OmdbMovieModel>> getMoviesByTitleAndYear(String title);
  
  Future<String> getJsonBody();
}

class OmdbMovieRemoteDatasourceImpl implements OmdbMovieRemoteDatasource {
  final OmdbWsClient client;

  OmdbMovieRemoteDatasourceImpl({@required this.client});

  factory OmdbMovieRemoteDatasourceImpl.create() {
    return OmdbMovieRemoteDatasourceImpl(
      client: OmdbWsClientImpl(defaultHttp),
      
    );
  }

    


  @override
  Future<List<OmdbMovieModel>> getMoviesByDate(String date) async {
    final startDate = date;
    final endDate = date;
    Uri uri = Uri.https('api.nasa.gov', 'neo/rest/v1/feed', {
      'start_date': startDate,
      'end_date': endDate,
      'api_key': 'DEMO_KEY',
    });
    final response = await client.get(uri);
    String json = response.body;
    List<OmdbMovieModel> movieDetails = [];
    Map<String, dynamic> decodedJson = jsonDecode(json);
    Map<String, dynamic> datesDecoded = decodedJson['near_earth_objects'];
    datesDecoded.forEach((key, value) {
      value.forEach((listItem) {
        movieDetails
            .add(OmdbMovieModel.fromOmdbJson(listItem as Map<String, dynamic>));
      });
    });
    return movieDetails;
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
  Future<String> getJsonBody() async {
     String apikey = "f73eb4d2";
    String uri = "http://www.omdbapi.com/?s=Putra&apikey=$apikey";
    final response = await client.get(uri);
    String json = response.body;
    return json;
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

  @override
  Future<List<OmdbMovieModel>> getMoviesByTitleAndYear(String keyword) async {
    String apikey = "f73eb4d2";
    String uri = "http://www.omdbapi.com/?s=$keyword&apikey=$apikey";
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

// class NasaMovieRemoteDatasourceMock implements NasaMovieRemoteDatasource {
//   @override
//   Future<List<Movie>> getMoviesNearEarch() async {
//     String json = getFakeMovieResponse();
//     List<Movie> Movies = [];
//     Map<String, dynamic> decodedJson = jsonDecode(json);
//     Map<String, dynamic> datesDecoded = decodedJson['near_earth_objects'];
//     datesDecoded.forEach((key, value) {
//       value.forEach((listItem) {
//         Movies.add(Movie.fromOmdbJson(listItem as Map<String, dynamic>));
//       });
//     });
//     return Movies;
//   }
// }
