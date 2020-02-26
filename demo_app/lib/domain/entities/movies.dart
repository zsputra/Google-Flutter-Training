import 'package:equatable/equatable.dart';

class Movie with EquatableMixin {
  final String title;
  final String year;
  final String id;
  final String poster;
  final String label;
  final int priority;
  final bool viewed;
  final int rating;
  final int timestamp;
  final String type;

  Movie({
    this.label,
    this.priority,
    this.viewed,
    this.rating,
    this.timestamp,
    this.title,
    this.year,
    this.id,
    this.poster,
    this.type,
  });

  @override
  List<Object> get props {
    return [
      label,
      priority,
      viewed,
      rating,
      timestamp,
      title,
      year,
      id,
      poster,
      type
    ];
  }
}

extension MovieExt on Movie {
  Movie copyWith(Movie updates) => Movie(
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
