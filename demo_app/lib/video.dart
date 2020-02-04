class VideoModel {
  final String title;
  final String year;
  final String id;
  final String poster;

  VideoModel({this.title, this.year, this.id, this.poster});

  VideoModel copyWith(VideoModel updates) {
    return VideoModel(
      title: updates.title ?? title,
      year: updates.year ?? year,
      id: updates.id ?? id,
      poster: updates.poster ?? poster,
    );
  }
}

class VideoDetail extends VideoModel {
  final String label;
  final int priority;
  final bool viewed;
  final int rating;
  final int timestamp;

  VideoDetail(
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

  VideoDetail copyWith1(VideoDetail updates) => VideoDetail(
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
