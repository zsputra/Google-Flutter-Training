import 'dart:convert';

import 'package:demo_app/common/configure/getit_configuration.dart';
import 'package:demo_app/data/ws/datasources/ws_remote_datasource.dart';
import 'package:demo_app/data/ws/models/ws_movie_model.dart';
import 'package:demo_app/domain/entities/movies.dart';
import 'package:demo_app/domain/search/use_cases/search_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import 'bloc/movieeditor_bloc.dart';

class MovieEditorPage extends StatefulWidget {
  final Movie movie;
  // final Function _function;
  MovieEditorPage({this.movie});

  @override
  _MovieEditorPageState createState() => _MovieEditorPageState(movie);
}

class _MovieEditorPageState extends State<MovieEditorPage> {
  bool switchOn;
  Movie movie;
  String _now;
  DateTime _date;
  final _formKey = GlobalKey<FormState>();

  // LikeMovieUseCase likeMovieUseCase = getIt<LikeMovieUseCase>();

  TextEditingController yearController = TextEditingController();

  _MovieEditorPageState(this.movie);

  WsMovieRemoteDatasourceImpl get wsMovieRDS =>
      WsMovieRemoteDatasourceImpl.create();

  @override
  void initState() {
    super.initState();
    DateTime _temp =
        DateTime.fromMillisecondsSinceEpoch(widget.movie.timestamp ?? 0);
    // var formatter = new DateFormat('yyyy-MM-dd');
    _now = DateFormat.yMMMd().format(_temp);
    // movie = widget.movie ?? null;
    switchOn = widget.movie.viewed;
  }

  void _changeViewed(bool value) {
    setState(() {
      switchOn = value;
      movie = movie.copyWith(Movie(viewed: value));
    });
  }

  void _submitForm() {
    WsMovieModel wsMovieModel = WsMovieModel(
      id: movie.id,
      label: movie.label,
      poster: movie.poster,
      priority: movie.priority,
      rating: movie.rating,
      timestamp: movie.timestamp,
      title: movie.title,
      type: movie.type,
      viewed: movie.viewed,
      year: movie.year,
    );

    BlocProvider.of<MovieeditorBloc>(context)
        .add(LikeMovieEvent(favoriteMovie: wsMovieModel));
  }

  Widget _checkPoster(Movie movie) {
    if (movie.poster == "N/A" || movie.poster == null) {
      return Stack(
        children: <Widget>[
          Image.network(
              "https://mediacenter.surabaya.go.id/fotos/no-image.png"),
          Align(
            child: Text('Poster Not Found'),
            alignment: Alignment.topCenter,
          )
        ],
      );
    } else {
      return Image.network(
        movie.poster,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Movie Editor")),
        body: Container(
          child: Form(
            key: _formKey,
            child: Container(
              margin: EdgeInsets.all(10.0),
              child: ListView(
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        width: 200,
                        child: Column(
                          children: <Widget>[
                            // Padding(padding: EdgeInsets.all(10.0),child: Text("Title")),
                            Padding(
                              child: TextFormField(
                                onChanged: (value) {
                                  setState(() {
                                    movie = movie.copyWith(Movie(title: value));
                                  });
                                },
                                initialValue: movie.title,
                                style: Theme.of(context).textTheme.title,
                                decoration: const InputDecoration(
                                  labelText: "Title",
                                  hintText: "Title",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(8.0))),
                                ),
                              ),
                              padding: EdgeInsets.all(10.0),
                            ),

                            Padding(
                              child: TextFormField(
                                onChanged: (value) {
                                  setState(() {
                                    movie = movie.copyWith(Movie(year: value));
                                  });
                                },
                                initialValue: widget.movie.year,
                                style: Theme.of(context).textTheme.title,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  labelText: "Year",
                                  hintText: "Year",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(8.0))),
                                ),
                              ),
                              padding: EdgeInsets.all(10.0),
                            ),
                            Padding(
                              child: TextFormField(
                                onChanged: (value) {
                                  setState(() {
                                    movie = movie.copyWith(Movie(label: value));
                                  });
                                },
                                initialValue: widget.movie.label,
                                style: Theme.of(context).textTheme.title,
                                decoration: const InputDecoration(
                                  labelText: "Label",
                                  hintText: "Label",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(8.0))),
                                ),
                              ),
                              padding: EdgeInsets.all(10.0),
                            ),
                          ],
                        ),
                      ),
                      Flexible(
                        fit: FlexFit.tight,
                        child: _checkPoster(widget.movie),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          "Rating :",
                          style: Theme.of(context).textTheme.title,
                        ),
                      ),
                      SmoothStarRating(
                          allowHalfRating: false,
                          onRatingChanged: (value) {
                            setState(() {
                              movie =
                                  movie.copyWith(Movie(rating: value.toInt()));
                            });
                          },
                          starCount: 5,
                          rating: (movie.rating ?? 0).toDouble(),
                          size: 40.0,
                          filledIconData: Icons.blur_off,
                          halfFilledIconData: Icons.blur_on,
                          color: Colors.orange,
                          borderColor: Colors.orange,
                          spacing: 0.0),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Flexible(
                        child: TextFormField(
                          validator: (value) {
                            if (int.parse(value) < 0 || int.parse(value) > 10) {
                              return 'Priority must be between 0 and 10';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() {
                              movie = movie
                                  .copyWith(Movie(priority: int.parse(value)));
                            });
                          },
                          initialValue: (widget.movie.priority ?? 0).toString(),
                          style: Theme.of(context).textTheme.title,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: "Priority",
                            hintText: "Priority",
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0))),
                          ),
                        ),
                      ),
                      Flexible(
                        fit: FlexFit.tight,
                        child: SwitchListTile(
                          title: Text('Viewed',
                              style: Theme.of(context).textTheme.title),
                          value: switchOn ?? false,
                          onChanged: (value) {
                            _changeViewed(value);
                          },
                          // secondary: const Icon(Icons.panorama_fish_eye),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Flexible(
                          child: Text("Edited Date : $_now",
                              style: Theme.of(context).textTheme.title))
                    ],
                  ),
                  RaisedButton(
                    onPressed: () {
                      final form = _formKey.currentState;
                      if (form.validate()) {
                        form.save();
                        movie = movie.copyWith(Movie(
                            timestamp: DateTime.now().millisecondsSinceEpoch));
                        _submitForm();

                        Navigator.pop(context);
                      }
                    },
                    child: Text('Save'),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  _showDialog(BuildContext context) {
    Scaffold.of(context)
        .showSnackBar(SnackBar(content: Text('Submitting form')));
  }
}
