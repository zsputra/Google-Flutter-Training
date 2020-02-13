import 'dart:convert';

import 'package:demo_app/data/ws/datasources/ws_remote_datasource.dart';
import 'package:demo_app/data/ws/models/ws_movie_model.dart';
import 'package:demo_app/domain/entities/movies.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';




class FavoriteDetailMoviePage extends StatefulWidget {
  final Movie _movie;
  FavoriteDetailMoviePage(this._movie);

 



  @override
  _FavoriteDetailMoviePageState createState() =>
      _FavoriteDetailMoviePageState();
}

class _FavoriteDetailMoviePageState extends State<FavoriteDetailMoviePage> {
  bool switchOn;
  Movie _movie;
  String _now;
  DateTime _date;
  final _formKey = GlobalKey<FormState>();

  TextEditingController yearController = TextEditingController();

   WsMovieRemoteDatasourceImpl get wsMovieRDS =>
      WsMovieRemoteDatasourceImpl.create();

  @override
  void initState() {
    super.initState();
    DateTime _temp =
        DateTime.fromMillisecondsSinceEpoch(widget._movie.timestamp);
    // var formatter = new DateFormat('yyyy-MM-dd');
    _now = DateFormat.yMMMd().format(_temp);
    _movie = _movie.copyWith(widget._movie);
    switchOn = widget._movie.viewed;
  }

  void _changeViewed(bool value) {
    setState(() {
      switchOn = value;
      _movie = _movie.copyWith(Movie(viewed: value));
      
    });
  }

  Future<void> _submitForm() async {
    WsMovieModel wsMovieModel = WsMovieModel(
                          id: _movie.id,
                          label: _movie.label,
                          poster: _movie.poster,
                          priority: _movie.priority,
                          rating: _movie.rating,
                          timestamp: _movie.timestamp,
                          title: _movie.title,
                          type: _movie.type,
                          viewed: _movie.viewed,
                          year: _movie.year,
                        );
                      await  wsMovieRDS.updateMovieById(wsMovieModel);
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
                                onChanged: (value){
                                  setState(() {
                                    _movie = _movie.copyWith(Movie(title: value));
                                  });
                                  
                                },
                                initialValue: _movie.title,
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
                                onChanged: (value){
                                  setState(() {
                                    _movie = _movie.copyWith(Movie(year: value));
                                  });
                                },
                                initialValue: widget._movie.year,
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
                                onChanged: (value){
                                  setState(() {
                                    _movie = _movie.copyWith(Movie(label: value));
                                  });
                                },
                                initialValue: widget._movie.label,
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
                        child: _checkPoster(widget._movie),
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
                          onRatingChanged: (value){
                                  setState(() {
                                    _movie = _movie.copyWith(Movie(rating: value.toInt()));
                                  });
                                },
                          starCount: 5,
                          rating: _movie.rating.toDouble(),
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
                          onChanged: (value){
                                  setState(() {
                                    _movie = _movie.copyWith(Movie(priority: int.parse(value)));
                                  });
                                },
                          initialValue: widget._movie.priority.toString(),
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
                          value: switchOn,
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
                        _movie = _movie.copyWith(Movie(timestamp: DateTime.now().millisecondsSinceEpoch));
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
