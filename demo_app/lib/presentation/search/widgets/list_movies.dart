import 'package:demo_app/common/routes/routes.dart';
import 'package:demo_app/domain/entities/movies.dart';
import 'package:flutter/material.dart';

class ListMovies extends StatelessWidget {
  final List<Movie> datas;

  final Function _addMovie;

  ListMovies(this.datas, this._addMovie);

  Widget _checkPoster(int index) {
    if (datas[index].poster == "N/A") {
      return Column(
        children: <Widget>[
          Image.network("https://mediacenter.surabaya.go.id/fotos/no-image.png",
              width: 180, height: 187, fit: BoxFit.fill),
          Text('Poster Not Found')
        ],
      );
    } else {
      return Image.network(
        datas[index].poster,
        height: 180,
        width: 187,
        fit: BoxFit.fill,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: datas.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: MediaQuery.of(context).size.width /
              (MediaQuery.of(context).size.height),
        ),
        itemBuilder: (BuildContext context, int index) {
          // if (index == 0) {
          //   return SearchMovie();
          // }
          return Scaffold(
            body: Container(
                // padding: EdgeInsets.all(5.0),
                margin: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
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
                      title: Text(
                        datas[index].title,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(datas[index].year,
                          overflow: TextOverflow.ellipsis),
                    )
                  ],
                )),
            floatingActionButton: FloatingActionButton(
              heroTag: datas[index].id,
              onPressed: () {
                Navigator.pushNamed(context, Routes.movieEditor,
                    arguments: datas[index]);
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => MovieEditorPage(movie: datas[index])));
                // // _addMovie(datas[index]);
                // Scaffold.of(context).showSnackBar(SnackBar(
                //   content: Text("Liked"),
                // ));
              },
              child: Icon(Icons.favorite),
              mini: true,
            ),
          );
        });
  }
}
