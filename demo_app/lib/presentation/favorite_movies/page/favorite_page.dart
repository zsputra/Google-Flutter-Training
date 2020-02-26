import 'package:demo_app/common/network/network_utils.dart';
import 'package:demo_app/common/network2/omdb_movie_client.dart';
import 'package:demo_app/data/omdb/datasources/omdb_remote_datasource.dart';
import 'package:demo_app/data/omdb/repository/omdb_repository.dart';
import 'package:demo_app/data/ws/datasources/ws_remote_datasource.dart';
import 'package:demo_app/data/ws/models/ws_movie_model.dart';
import 'package:demo_app/domain/entities/movies.dart';
import 'package:demo_app/presentation/favorite_movies/bloc/favoritemovies_bloc.dart';
import 'package:demo_app/presentation/favorite_movies/widgets/list_movies_favorite.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FavoritePageImpl();
  }
}

class _FavoritePageImpl extends State<FavoritePage> {
  List<Movie> _listMovies = new List<Movie>();
  // WsMovieModel _listMoviesRecomendation = WsMovieModel();
  String _title;
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
    BlocProvider.of<FavoritemoviesBloc>(context).add(GetAllFavoriteMovie());
  }

  void _getData() async {
    try {
      // final repository = await omdbRepository;
      // final list = await wsMovieRDS.getAllMovies();
      final listRecomendations = await wsMovieRDS.getAllMovies();

      if (mounted) {
        setState(() {
          // _listMovies = list;
          _listMovies = listRecomendations;
        });
      }
    } catch (e) {
      print(e);
      if (mounted) {
        setState(() {
          _listMovies = null;
          // _listMoviesRecomendation = null;
        });
      }
    }
  }

  Widget _buildProgressBar() {
    return Center(child: CircularProgressIndicator());
  }

  Future<void> _deleteMovie(String index) async {
    await wsMovieRDS.deleteMovieById(index);
    final listRecomendations = await wsMovieRDS.getAllMovies();
    setState(() {
      _listMovies = listRecomendations;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavoritemoviesBloc, FavoritemoviesState>(
      listener: (context, state) {
        if (state is OnDeleteSuccess) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text('Deleted'),
          ));
        }
      },
      builder: (context, state) {
        if (state is FavoriteMovieLists) {
          _listMovies = state.favoriteMovieLists;
          return ListMoviesFavorite(_listMovies, _deleteMovie);
        } else {
          return _buildProgressBar();
        }
      },
    );
    // return FutureBuilder(
    //   future: wsMovieRDS.getAllMovies(),
    //   builder:
    //       (BuildContext context, AsyncSnapshot<List<WsMovieModel>> snapshot) {
    //     if (snapshot.connectionState == ConnectionState.done &&
    //         !snapshot.hasError) {
    //       // List<WsMovieModel> lis = List<WsMovieModel>();
    //       _listMovies = snapshot.data;
    //       // lis.add(_listMoviesRecomendation);
    //       return ListMoviesFavorite(_listMovies, _deleteMovie);
    //     } else {
    //       return _buildProgressBar();
    //     }
    //   },
    // );
  }
}
