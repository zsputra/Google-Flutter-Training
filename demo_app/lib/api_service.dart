
// import 'package:demo_app/data/omdb/models/movies.dart';
// import 'package:http/http.dart' show Client;


// class ApiService {

//   static String token = "zainudin.saputra@dkatalis.com";
//   String url =
//       "https://jsonplace/video-ws/videos?token=$token";
    

//   final String baseUrl = "http://api.bengkelrobot.net:8001";
//   Client client = Client();

//   Future<List<MovieDetail>> getProfiles() async {
//     final response = await client.get(url);
//     if (response.statusCode == 200) {
//       return profileFromJson(response.body);
//     } else {
//       return null;
//     }
//   }

// }