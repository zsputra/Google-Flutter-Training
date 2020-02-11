import 'package:demo_app/domain/entities/movies.dart';

class OmdbMovieModel extends Movie {
  OmdbMovieModel(
      {String title,
      String year,
      String id,
      String type,
      String poster})
      : super(
        title : title,
            year: year,
            id: id,
            type: type,
            poster: poster);

  factory OmdbMovieModel.fromOmdbJson(Map<String, dynamic> json) {
    return OmdbMovieModel(
        id: json['imdbID'],
        title: json['Title'],
        year: json['Year'],
        type : json['Type'],
        poster: json['Poster']);
  }

   Map<String, dynamic> toJson() {
     Map<String, dynamic> json = new Map<String, dynamic>();
        json["label"] =  label; 
        json["priority"] = priority;
        json["viewed"] = viewed ;
        json["rating"] = rating ;
        json["timestamp"] = timestamp ;
        json["title"] = title;
        json["year"] = year ;
        json["id"] = id ;
        json["poster"] = poster;
        return json;

   }
      

  
}

