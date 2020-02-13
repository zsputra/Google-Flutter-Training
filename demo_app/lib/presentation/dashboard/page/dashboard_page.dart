import 'package:demo_app/common/configure/getit_configuration.dart';
import 'package:demo_app/common/network/network_utils.dart';
import 'package:demo_app/common/network2/omdb_movie_client.dart';
import 'package:demo_app/data/omdb/datasources/omdb_remote_datasource.dart';
import 'package:demo_app/data/omdb/models/omdb_movie_model.dart';
import 'package:demo_app/data/omdb/repository/omdb_repository.dart';
import 'package:demo_app/data/ws/datasources/ws_remote_datasource.dart';
import 'package:demo_app/data/ws/models/ws_movie_model.dart';
import 'package:demo_app/data/ws/repository/ws_repository.dart';
import 'package:demo_app/domain/entities/movies.dart';
import 'package:demo_app/presentation/dashboard/widgets/list_movies_recomendation.dart';
import 'package:demo_app/presentation/dashboard/widgets/list_popular_and_top_movie.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DashboardPageImpl();
  }
}

class _DashboardPageImpl extends State<DashboardPage> {
  List<OmdbMovieModel> _listPopularMovie;
  List<OmdbMovieModel> _listTopRatedMovie;
  WsMovieModel _listMoviesRecomendation = WsMovieModel();
  String _title;
  String _year;
  bool showRecomended;

  final WsMovieRemoteDatasource wsMovieRDS = getIt<WsMovieRemoteDatasource>();

  final WsRepository wsRepository = getIt<WsRepository>();
  final OmdbRepository omdbRepository = getIt<OmdbRepository>();




  TextEditingController controller = TextEditingController();
  
  @override
  void initState() {
    // _checkRecommendeFlag();
    super.initState();
    _getData();
  }


  void _getData() async {
    try {

      final listRecomendations = await wsRepository.getAllMoviesRecomendation();
      final listPopularMovie = await omdbRepository.searchMoviesByTitle("Popular");
      final listTopRateMovie = await omdbRepository.searchMoviesByTitle("Top");
      final check = await getBoolRecomendation();

      if (mounted) {
        setState(() {
          showRecomended = check;
          _listMoviesRecomendation = listRecomendations;
          _listPopularMovie = listPopularMovie;
          _listTopRatedMovie = listTopRateMovie;
        });
      }
    } catch (e) {
      print(e);
      if (mounted) {
        setState(() {
          _listPopularMovie = null;
          _listTopRatedMovie = null;
          _listMoviesRecomendation = null;
        });
      }
    }
  }

  Widget _buildProgressBar() {
    return Center(child: CircularProgressIndicator());
  }

  Future<bool> getBoolRecomendation() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final bool = sharedPreferences.containsKey("showRecomended");
    if (bool) {
      return sharedPreferences.getBool("showRecomended");
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<List<dynamic>> lists = List<List<dynamic>>();
    lists.add(_listPopularMovie);
    lists.add(_listTopRatedMovie);
    List<WsMovieModel> listRec = [_listMoviesRecomendation];
    lists.add(listRec);
    return FutureBuilder(
      future: getBoolRecomendation(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            !snapshot.hasError) {
          showRecomended = snapshot.data;
          return pages(showRecomended);
        } else {
          return _buildProgressBar();
        }
      },
    );
  }

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

  Widget _cardRecomendation(WsMovieModel wsMovieModel) {
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
                  child: _checkPoster(wsMovieModel.poster)),
              ListTile(
                title: Text(
                  wsMovieModel.title,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(wsMovieModel.year),
              )
            ]));
  }

  Function _listFunctionMovie(List<dynamic> listMovie) {
    return (BuildContext context, index) {
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

  Widget containerRecomendation(WsMovieModel movie) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 20.0),
        height: 300,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 1,
            itemBuilder: (context, int index) {
              return _cardRecomendation(movie);
            }));
  }

  Widget pages(bool isChecked) {
    return ListView(
      shrinkWrap: true,
      physics: const AlwaysScrollableScrollPhysics(),
      children: <Widget>[
        Padding(
          child:
              Text("Popular Movies", style: Theme.of(context).textTheme.title),
          padding: EdgeInsets.only(left: 10, top: 10),
        ),
        FutureBuilder(
          future: omdbRepository.searchMoviesByTitle("Popular"),
          builder:
              (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                !snapshot.hasError) {
              _listPopularMovie = snapshot.data;
              return containerPop(_listPopularMovie);
            } else {
              return _buildProgressBar();
            }
          },
        ),

        SizedBox(
          height: 10,
        ),
        Padding(
          child: Text("Top Rated", style: Theme.of(context).textTheme.title),
          padding: EdgeInsets.only(left: 10, top: 10),
        ),
        FutureBuilder(
          future: omdbRepository.searchMoviesByTitle("Top"),
          builder:
              (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                !snapshot.hasError) {
              _listTopRatedMovie = snapshot.data;
              return containerPop(_listTopRatedMovie);
            } else {
              return _buildProgressBar();
            }
          },
        ),
        if (isChecked)
          SizedBox(
            height: 10,
          ),
        if (isChecked)
          Padding(
            child: Text("Recomended", style: Theme.of(context).textTheme.title),
            padding: EdgeInsets.only(left: 10, top: 10),
          ),
        if (isChecked)
          FutureBuilder(
            future: wsRepository.getAllMoviesRecomendation(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  !snapshot.hasError) {
                _listMoviesRecomendation = snapshot.data;

                return containerRecomendation(_listMoviesRecomendation);
              } else {
                return _buildProgressBar();
              }
            },
          ),
  
      ],
    );
  }

  Widget containerPop(List<dynamic> listPop) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 20.0),
        height: 300,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            itemBuilder: _listFunctionMovie(listPop)));
  }
}
