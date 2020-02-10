class Movie {
  final String title;
  final String year;
  final String id;
  final String poster;

  Movie({this.title, this.year, this.id, this.poster});
}

class MovieDetail extends Movie {
  final String label;
  final int priority;
  final bool viewed;
  final int rating;
  final int timestamp;

  MovieDetail(
      {this.label,
      this.priority,
      this.viewed,
      this.rating,
      this.timestamp,
      String title,
      String year,
      String id,
      String poster})
      : super(title: title, year: year, id: id, poster: poster);

  factory MovieDetail.fromJson(Map<String, dynamic> json) {
    return MovieDetail(
        id: json['omdbID'],
        title: json['Title'],
        year: json['Year'],
        poster: json['Poster'],
        label: json['Label'],
        priority: json['Priority'],
        viewed: json['Viewed'],
        rating: json['Rating'],
        timestamp: json['Timestamp']);
  }

  factory MovieDetail.fromWsJson(Map<String, dynamic> json) {
    return MovieDetail(
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

extension MovieExt on Movie {
  Movie copyWith(Movie updates) {
    return Movie(
      title: updates.title ?? title,
      year: updates.year ?? year,
      id: updates.id ?? id,
      poster: updates.poster ?? poster,
    );
  }
}

extension MovieDetailExt on MovieDetail {
  MovieDetail copyWith(MovieDetail updates) => MovieDetail(
        label: updates.label ?? label,
        priority: updates.priority ?? priority,
        viewed: updates.viewed ?? viewed,
        rating: updates.rating ?? rating,
        timestamp: updates.timestamp ?? timestamp,
        title: updates.title ?? title,
        year: updates.year ?? year,
        id: updates.id ?? id,
        poster: updates.poster ?? poster,
      );

 
}
