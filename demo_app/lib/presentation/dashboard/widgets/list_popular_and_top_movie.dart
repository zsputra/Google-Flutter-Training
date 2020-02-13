import 'package:demo_app/data/omdb/models/omdb_movie_model.dart';
import 'package:demo_app/data/ws/models/ws_movie_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListPopularAndTopMovie extends StatelessWidget {
  final List<List<dynamic>> _recomendedMovies;
  // final List<MovieDetail> _listAllMovies;
  final bool showRecomended;

  ListPopularAndTopMovie(this._recomendedMovies, this.showRecomended);

  Widget _checkPoster(String poster) {
    if (poster == "N/A") {
      return Column(
        children: <Widget>[
          Image.network(
            "https://mediacenter.surabaya.go.id/fotos/no-image.png",
          ),
          Text('Poster Not Found')
        ],
      );
    } else {
      return Image.network(
        poster,
        height: 180,
        width: 187,
        fit: BoxFit.fill,
      );
    }
  }

  Function _listFunctionMovie(List<dynamic> listMovie) {
    return (BuildContext context, int index) {
      return Container(
          // height: 400,
          width: 160,
          // padding: EdgeInsets.all(5.0),
          margin: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment(
                  0.8, 0.0), // 10% of the width, so there are ten blinds.
              colors: [
                Colors.orange[100], //Color(0xFFFFFFEE),
                Colors.orange
              ], // whitish to gray
              tileMode: TileMode.repeated,
            ), // repeats th
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
          // alignment: Alignment.center,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16)),
                    child: _checkPoster(listMovie[index].poster)),
                ListTile(
                  title: Text(
                    listMovie[index].title,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(listMovie[index].year),
                )
              ]));
    };
  }

  Widget _listCard(List<dynamic> listMovie, int length) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 20.0),
        height: 300,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: listMovie.length,
            itemBuilder: _listFunctionMovie(listMovie)));
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const AlwaysScrollableScrollPhysics(),
      children: <Widget>[
        Padding(
          child:
              Text("Popular Movies", style: Theme.of(context).textTheme.title),
          padding: EdgeInsets.only(left: 10, top: 10),
        ),
        Container(
            margin: EdgeInsets.symmetric(vertical: 20.0),
            height: 300,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: _listFunctionMovie(_recomendedMovies[0]))),
        // _listCard(_recomendedMovies[0], _recomendedMovies[0].length),
        SizedBox(
          height: 10,
        ),
        Padding(
          child: Text("Top Rated", style: Theme.of(context).textTheme.title),
          padding: EdgeInsets.only(left: 10, top: 10),
        ),

        Container(
            margin: EdgeInsets.symmetric(vertical: 20.0),
            height: 300,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: _listFunctionMovie(_recomendedMovies[1]))),
        // _listCard(_recomendedMovies[1], _recomendedMovies[1].length)
        if(showRecomended) SizedBox(
          height: 10,
        ),
        if(showRecomended) Padding(
          child: Text("Recomended", style: Theme.of(context).textTheme.title),
          padding: EdgeInsets.only(left: 10, top: 10),
        ),
        if(showRecomended) 
        Container(
            margin: EdgeInsets.symmetric(vertical: 20.0),
            height: 300,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 1,
                itemBuilder: _listFunctionMovie(_recomendedMovies[2]))),
      ],
    );
  }
}
