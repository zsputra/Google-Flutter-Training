


import 'package:demo_app/data/omdb/models/movies.dart';
import 'package:flutter/cupertino.dart';

class RecomendedMovie extends StatelessWidget{

  final MovieDetail recomendedMovie;
  RecomendedMovie(this.recomendedMovie);

  @override
  Widget build(BuildContext context) {
    return Container( child: Center(child: Image.network(recomendedMovie.poster),));
  }
}