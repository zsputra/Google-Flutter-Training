import 'package:demo_app/data/omdb/models/movies.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListMoviesRecomendation extends StatelessWidget {
  final List<MovieDetail> _recomendedMovies;
  // final List<MovieDetail> _listAllMovies;

  ListMoviesRecomendation(this._recomendedMovies);

  Widget _checkPoster(int index) {
    if (_recomendedMovies[index].poster == "N/A") {
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
        _recomendedMovies[index].poster,
        height: 180,
        width: 187,
        fit: BoxFit.fill,
      );
    }
  }

  Widget _itemBuilder(BuildContext context, int index) {
    return Container(
        // height: 400,
        width: 160,
        // padding: EdgeInsets.all(5.0),
        margin: EdgeInsets.all(8.0),
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
        // alignment: Alignment.center,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16)),
                  child: _checkPoster(index)),
              ListTile(
                title: Text(_recomendedMovies[index].title),
                subtitle: Text(_recomendedMovies[index].year),
              )
            ]));
  }

  Widget _listCard() {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 20.0),
        height: 300,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _recomendedMovies.length,
            itemBuilder: (BuildContext context, int index) {
              // return Container(color: Colors.blue);
              return _itemBuilder(context, index);
            }));
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const AlwaysScrollableScrollPhysics(),
      children: <Widget>[
        Padding(child: Text("Recomendation", style: Theme.of(context).textTheme.title), padding: EdgeInsets.only(left: 10, top:10),),
        _listCard(),
        SizedBox(height: 10,),
        Padding(child: Text("Recomendation", style: Theme.of(context).textTheme.title),padding: EdgeInsets.only(left: 10, top:10),),
        _listCard()
      ],
      );
  }


}
