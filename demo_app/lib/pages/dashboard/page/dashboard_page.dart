import 'package:demo_app/common/network/network_utils.dart';
import 'package:demo_app/data/omdb/datasources/omdb_remote_datasource.dart';
import 'package:demo_app/data/omdb/repository/omdb_repository.dart';
import 'package:demo_app/data/ws/datasources/ws_remote_datasource.dart';
import 'package:demo_app/data/ws/models/ws_movie_model.dart';
import 'package:demo_app/domain/entities/movies.dart';
import 'package:demo_app/network/omdb_movie_client.dart';
import 'package:demo_app/pages/dashboard/widgets/list_movies_recomendation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class DashboardPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DashboardPageImpl();
  }
}

class _DashboardPageImpl extends State<DashboardPage> {
  List<Movie> _listMovies = new List<Movie>();
  WsMovieModel _listMoviesRecomendation = WsMovieModel();
  String _title ;
  String _year;

  //dependency injection
  WsMovieRemoteDatasourceImpl get wsMovieRDS =>
      WsMovieRemoteDatasourceImpl.create();

  TextEditingController controller = TextEditingController();
  Future<OmdbRepository> get omdbRepository async => OmdbRepositoryImpl(
        datasource: OmdbMovieRemoteDatasourceImpl(
          client: OmdbWsClientImpl(defaultHttp),
        ),
        
      );

  @override
  void initState() {
    _getData();
    super.initState();
  }

  void _getData() async {
    try {
      // final repository = await omdbRepository;
      // final list = await wsMovieRDS.getAllMovies();
      final listRecomendations = await wsMovieRDS.getAllMoviesRecomendation();

      if (mounted) {
        setState(() {
          // _listMovies = list;
          _listMoviesRecomendation = listRecomendations;
        });
      }
    } catch (e) {
      print(e);
      if (mounted) {
        setState(() {
          _listMovies = null;
          _listMoviesRecomendation = null;
        });
      }
    }
  }

  Widget _buildProgressBar() {
    return Center(child: CircularProgressIndicator());
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
                future: wsMovieRDS.getAllMoviesRecomendation(),
                builder: (BuildContext context,
                    AsyncSnapshot<WsMovieModel> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      !snapshot.hasError) {
                        List<WsMovieModel> lis = List<WsMovieModel>();
                    _listMoviesRecomendation = snapshot.data;
                    lis.add(_listMoviesRecomendation);
                    return ListMoviesRecomendation(lis);
                  } else {
                    return _buildProgressBar();
                  }
                },
              );
            
          
  }
}
