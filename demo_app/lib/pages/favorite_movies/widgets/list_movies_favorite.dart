import 'package:demo_app/domain/entities/movies.dart';
import 'package:flutter/material.dart';

class ListMoviesFavorite extends StatelessWidget {
  final List<Movie> _favoriteMovies;

  // final Function _addMovie;

  ListMoviesFavorite(this._favoriteMovies);

  Widget _checkPoster(int index) {
    if (_favoriteMovies[index].poster == "N/A") {
      return Column(
        children: <Widget>[
          Image.network("https://mediacenter.surabaya.go.id/fotos/no-image.png",
              width: 180, height: 187, fit: BoxFit.fill),
          Text('Poster Not Found')
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
          return Container(
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey[300],
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
                              borderRadius: BorderRadius.all(Radius.circular(16)),
                                  // topLeft: Radius.circular(16),
                                  // topRight: Radius.circular(16)),
                              child: _checkPoster(index))),
                      Flexible(
                          fit: FlexFit.tight,
                          // width: 100,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                ListTile(
                                  title: Text(_favoriteMovies[index].title),
                                  subtitle: Text(_favoriteMovies[index].year),
                                ),
                                Container(
                                    padding:
                                        EdgeInsets.only(top: 10.0, left: 10.0),
                                    child: Text(
                                        "Label: ${_favoriteMovies[index].label ?? "_"}")),
                                Container(
                                    padding:
                                        EdgeInsets.only(top: 10.0, left: 10.0),
                                    child: Text(
                                        "Priority: ${_favoriteMovies[index].priority ?? "_"}")),
                                Container(
                                    padding:
                                        EdgeInsets.only(top: 10.0, left: 10.0),
                                    child: Text(
                                        "Rating: ${_favoriteMovies[index].rating ?? "_"}")),
                              ])),
                    ],
                  )
                ],
              ));
        });
    // ListView.builder(
    //     itemCount: _favoriteMovies.length,
    //     itemBuilder: (BuildContext context, int index) {
    //       return
    //       Container(
    //         // padding: EdgeInsets.all(5.0),
    //         // height: 500,
    //         margin: EdgeInsets.all(20.0),
    //         decoration: BoxDecoration(
    //           color: Colors.grey[300],
    //           borderRadius: BorderRadius.all(Radius.circular(16)),
    //           boxShadow: [
    //             BoxShadow(
    //                 color: Colors.grey[500],
    //                 offset: Offset(4.0, 4.0),
    //                 blurRadius: 15.0,
    //                 spreadRadius: 1.0),
    //             BoxShadow(
    //                 color: Colors.white,
    //                 offset: Offset(-4.0, -4.0),
    //                 blurRadius: 15.0,
    //                 spreadRadius: 1.0),
    //           ],
    //         ),
    //         // alignment: Alignment.center,
    //         child:
    //         Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <Widget>[
    //           ClipRRect(
    //           borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
    //           child: _checkPoster(index)) ,
    //           ListTile(title: Text(_favoriteMovies[index].title), subtitle: Text(_favoriteMovies[index].year),),
    //           Container(
    //             child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: <Widget>[
    //             Text("Label : ${_favoriteMovies[index].label ?? "_"}"),
    //             Text("Priority : ${_favoriteMovies[index].priority ?? "_"}"),
    //             Text("Rating : ${_favoriteMovies[index].rating ?? "_"}"),
    //           ],),),
    //           // Container(child: Row(
    //           //   mainAxisAlignment: MainAxisAlignment.end,
    //           //   children: <Widget>[
    //           //   FlatButton(child: Icon(Icons.delete), onPressed: (){},)
    //           // ],),),

    //         ],)
    //       );},
    //       // floatingActionButton: FloatingActionButton(onPressed: (){
    //       //   // _addMovie(_favoriteMovies[index]);
    //       // },child: Icon(Icons.favorite), mini: true,),
    //       );
  }
}
