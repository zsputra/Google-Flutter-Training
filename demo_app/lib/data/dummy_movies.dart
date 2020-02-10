import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import 'omdb/models/movies.dart';


String dummyMovies = '''[{"title":"Ava","year":"2017","id":"tt6194530","type":"movie","poster":"https://m.media-amazon.com/images/M/MV5BM2UyNzlkMjUtM2E1ZS00MTljLWJkMmEtODYzNGM1NmY5ODNiXkEyXkFqcGdeQXVyNjUyMzIyODA@._V1_SX300.jpg"},{"title":"Ava","year":"2017","id":"tt7259986","type":"movie","poster":"https://m.media-amazon.com/images/M/MV5BYTcxOTUyYzMtMDY3ZC00YTY0LWIyNjEtYWYwNjE0YTA4YWI5XkEyXkFqcGdeQXVyMTMxODk2OTU@._V1_SX300.jpg"},{"title":"13th: A Conversation with Oprah Winfrey & Ava DuVernay","year":"2017","id":"tt6491068","type":"movie","poster":"https://m.media-amazon.com/images/M/MV5BOWMwNGVmYmYtYWVlNy00NGQ2LTg2N2EtMTllOGEyNzJhMThhXkEyXkFqcGdeQXVyMTY4MjQ0NzU@._V1_SX300.jpg"},{"title":"Frank and Ava","year":"2018","id":"tt5963314","type":"movie","poster":"https://m.media-amazon.com/images/M/MV5BYzJmYjA0MzgtN2NmNy00MzNiLThmNjMtZDI0ZjRhNzBlZTdkXkEyXkFqcGdeQXVyODA4MzkyNjM@._V1_SX300.jpg"},{"title":"Ava Gardner, la gitane d'Hollywood: les années espagnoles de la Comtesse aux Pieds Nus","year":"2018","id":"tt8610760","type":"movie","poster":"https://m.media-amazon.com/images/M/MV5BMDQzYWNkZDMtYWM5Mi00MzA3LWI0MjQtMjFhMjQ0ZTc3MmE5XkEyXkFqcGdeQXVyMjIwNjIxNjc@._V1_SX300.jpg"},{"title":"Ava","year":"2004","id":"tt1413778","type":"movie","poster":"N/A"},{"title":"Ava & Lala","year":"2014","id":"tt4022252","type":"movie","poster":"https://m.media-amazon.com/images/M/MV5BMTk1NzcxODgwNF5BMl5BanBnXkFtZTgwMjM0NjU5MjE@._V1_SX300.jpg"},{"title":"Ava Max: So Am I","year":"2019","id":"tt9905788","type":"movie","poster":"https://m.media-amazon.com/images/M/MV5BMzBmNjIyYzMtZGIzNC00NzBkLTkzNWItZDA5YWM1YjIyODI1XkEyXkFqcGdeQXVyNjE0ODc0MDc@._V1_SX300.jpg"},{"title":"I Killed Ava Red","year":"2009","id":"tt1540424","type":"movie","poster":"N/A"},{"title":"Ava Justin Popovic","year":"2007","id":"tt1820388","type":"movie","poster":"N/A"}]''';

// List<MovieDetail> fakeMovies = ListMovieDetailFromJson(dummyMovies);
List<MovieDetail> coba(){

List<MovieDetail> fakeMovies  = List<MovieDetail>();
List<dynamic> decodedRaw = jsonDecode(dummyMovies);
decodedRaw.forEach((x){
  fakeMovies.add(MovieDetail.fromJson(x));
});

return fakeMovies;
}

String jsons = "{\"label\":null,\"priority\":null,\"viewed\":false,\"rating\":null,\"timestamp\":null,\"title\":\"cobacoba\",\"year\":null,\"id\":null,\"poster\":null}";

Future<void> coba2() async {

  String token = "zainudin.saputra@dkatalis.com";
    String uri =
        "https://demo-video-ws-chfmsoli4q-ew.a.run.app/video-ws/videos";
    Map<String, String> headers = {
      'token': token,
      'Content-Type': 'application/json'
    };
    String coba = '''{
  "id": "4",
  "label": "my 2343",
  "priority": 1,
  "viewed": false,
  "rating": 10, 
  "timestamp": 1575473859,
  "title": "Birds of Prey 3",
  "year": "2020",
  "poster": "https://m.media-amazon.com/images/M/MV5BMTM5NzcwMzEwOF5BMl5BanBnXkFtZTcwNjg5MTgwMw@@._V1_SX300.jpg"
}''';
    MovieDetail movies = MovieDetail(id: "1", title: "Berenang", label: "label", priority: 1, poster: "poster", rating: 10, timestamp: 12331, viewed: true, year: "2020");
    var json = jsonEncode(movies.toJson());
    print(json);
    Response response = await http.post(uri, headers: headers, body: json);
    print(response.body);

}


