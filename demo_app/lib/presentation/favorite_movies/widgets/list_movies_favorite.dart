import 'package:demo_app/common/routes/router.dart';
import 'package:demo_app/common/routes/routes.dart';
import 'package:demo_app/domain/entities/movies.dart';
import 'package:demo_app/presentation/favorite_movies/page/favorite_detail_page.dart';
import 'package:flutter/material.dart';

class ListMoviesFavorite extends StatelessWidget {
  final Function deleteEvent;
  final List<Movie> _favoriteMovies;

  // final Function _addMovie;

  ListMoviesFavorite(this._favoriteMovies, this.deleteEvent);

  Widget _checkPoster(int index) {
    if (_favoriteMovies[index].poster == "N/A" ||
        _favoriteMovies[index].poster == "poster") {
      return Stack(
        children: <Widget>[
          Image.network("https://mediacenter.surabaya.go.id/fotos/no-image.png",
              width: 180, height: 187, fit: BoxFit.fill),
          Align(
            child: Text('Poster Not Found'),
            alignment: Alignment.topCenter,
          )
        ],
      );
    } else {
      return Image.network(
        _favoriteMovies[index].poster,
        fit: BoxFit.fill,
      );
    }
  }



  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: _favoriteMovies.length,
        itemBuilder: (context, int index) {
          return InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => FavoriteDetailMoviePage(_favoriteMovies[index])));
            },
            child:
            Container(
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment(
                      0.8, 0.0), // 10% of the width, so there are ten blinds.
                  colors: [
                     Colors.orange[100],//Color(0xFFFFFFEE),
                     Colors.orange
                  ], // whitish to gray
                  tileMode: TileMode.repeated,
                ), // repeats the gradient over the canvas
                // color: Colors.orange[200],
                borderRadius: BorderRadius.all(Radius.circular(16)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey[500],
                      offset: Offset(4.0, 4.0),
                      blurRadius: 15.0,
                      spreadRadius: 1.0),
                  BoxShadow(
                      color: Colors.white,
                      offset: Offset(-4.0, -4.0),
                      blurRadius: 15.0,
                      spreadRadius: 1.0),
                ],
              ),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                          fit: FlexFit.tight,
                          child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)),
                              // topLeft: Radius.circular(16),
                              // topRight: Radius.circular(16)),
                              child: _checkPoster(index))),
                      Flexible(
                          fit: FlexFit.tight,
                          // width: 100,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  height: 100,
                                  child: ListTile(
                                    title: Text(_favoriteMovies[index].title),
                                    subtitle: Text(_favoriteMovies[index].year),
                                  ),
                                ),
                                SizedBox(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                          padding: EdgeInsets.only(
                                              top: 10.0, left: 10.0),
                                          child: Text(
                                              "Label: ${_favoriteMovies[index].label ?? "_"}",)),
                                      Container(
                                          padding: EdgeInsets.only(
                                              top: 10.0, left: 10.0),
                                          child: Text(
                                              "Priority: ${_favoriteMovies[index].priority ?? "_"}")),
                                      Container(
                                          padding: EdgeInsets.only(
                                              top: 10.0, left: 10.0),
                                          child: Text(
                                              "Rating: ${_favoriteMovies[index].rating ?? "_"}")),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                FlatButton(
                                  onPressed: () => deleteEvent(_favoriteMovies[index].id),
                                  
                                    padding: EdgeInsets.only(bottom: 8.0),
                                    child: Align(
                                      child: Icon(Icons.delete),
                                      // alignment: Alignment.bottomRight,
                                    ))
                              ])),
                    ],
                  )
                ],
              ))
          
           ,);
        });
  }
}
