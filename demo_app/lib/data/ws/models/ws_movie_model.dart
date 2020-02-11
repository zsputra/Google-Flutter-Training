import 'package:demo_app/domain/entities/movies.dart';

class WsMovieModel extends Movie {
  WsMovieModel(
      {String title,
      String year,
      String id,
      String poster,
      String label,
      int priority,
      bool viewed,
      int rating,
      String type,
      int timestamp})
      : super(
            title: title,
            year: year,
            id: id,
            poster: poster,
            label: label,
            priority: priority,
            viewed: viewed,
            rating: rating,
            type : type,
            timestamp: timestamp);

  factory WsMovieModel.fromWsJson(Map<String, dynamic> json) {
    return WsMovieModel(
        id: json['id'],
        title: json['title'],
        year: json['year'],
        poster: json['poster'],
        label: json['label'],
        priority: json['priority'],
        viewed: json['viewed'],
        rating: json['rating'],
        timestamp: json['timestamp']);
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = new Map<String, dynamic>();
    json["label"] = label;
    json["priority"] = priority;
    json["viewed"] = viewed;
    json["rating"] = rating;
    json["timestamp"] = timestamp;
    json["title"] = title;
    json["year"] = year;
    json["id"] = id;
    json["poster"] = poster;
    return json;
  }
}
