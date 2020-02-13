import 'package:demo_app/common/configure/getit_configuration.dart';
import 'package:demo_app/common/network/network_utils.dart';
import 'package:demo_app/common/network2/omdb_movie_client.dart';
import 'package:demo_app/data/omdb/datasources/omdb_remote_datasource.dart';
import 'package:demo_app/data/omdb/repository/omdb_repository.dart';
import 'package:demo_app/data/ws/datasources/ws_remote_datasource.dart';
import 'package:demo_app/data/ws/models/ws_movie_model.dart';
import 'package:demo_app/domain/entities/movies.dart';
import 'package:demo_app/domain/search/use_cases/search_use_case.dart';
import 'package:demo_app/presentation/search/bloc/bloc/search_movie_bloc_bloc.dart';
import 'package:demo_app/presentation/search/widgets/list_movies.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SearchPageImpl();
  }
}

class _SearchPageImpl extends State<SearchPage> {
  List<Movie> _listMovies = new List<Movie>();
  String _title;
  String _year;

  final WsMovieRemoteDatasource wsMovieRDS = getIt<WsMovieRemoteDatasource>();

  final GetAllMoviesByTitle getAllMoviesByTitle = getIt<GetAllMoviesByTitle>();

  final OmdbMovieRemoteDatasource omdbMovieRDS = getIt<OmdbMovieRemoteDatasource>();
 

  TextEditingController controller = TextEditingController();
  Future<OmdbRepository> get omdbRepository async => OmdbRepositoryImpl(
        datasource: OmdbMovieRemoteDatasourceImpl(
          client: OmdbWsClientImpl(defaultHttp),
        ),
      );

  @override
  void initState() {
    _title = 'Ave';
    // _getData();
    BlocProvider.of<SearchMovieBlocBloc>(context)
        .add(SearchMovieByTitleYear({'title' : 'Ave', 'year' : null}));
    super.initState();
  }

  void _initDataList(){

  }

  void _getData() async {
    try {
      // final repository = await omdbRepository;
      final list = await getAllMoviesByTitle.call({'title': _title, 'year' : null});

      if (mounted) {
        setState(() {
          _listMovies = list;
        });
      }
    } catch (e) {
      print(e);
      if (mounted) {
        setState(() {
          _listMovies = null;
        });
      }
    }
  }


  Widget _buildProgressBar() {
    return Center(child: CircularProgressIndicator());
  }

  void filterSearchResultByTitle(String title) {
    setState(() {
      _title = title;
      // _year = year;
    });
  }

  void filterSearchResultByYear(String year) {
    setState(() {
      // _title = title;
      _year = year;
    });
  }

  void _addToMovieList(Movie movieDetail)async {
    final repository = wsMovieRDS;
    setState(()  {
      WsMovieModel wsMovieModel = new WsMovieModel(id: movieDetail.id, poster: movieDetail.poster, year: movieDetail.year, title: movieDetail.title, type: movieDetail.type);
      repository.postMovie(wsMovieModel);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 50,
              child: Container(
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
                  child: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Flexible(
                          child: Container(
                            padding: EdgeInsets.all(5.0),
                            child: TextField(
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(8.0))),
                                  labelText: "Title"),
                              style: Theme.of(context).textTheme.body1,
                              onChanged: (value) {
                                filterSearchResultByTitle(value);
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Flexible(
                          child: Container(
                            padding: EdgeInsets.all(5.0),
                            child: TextField(
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(8.0))),
                                  labelText: "Year"),
                              style: Theme.of(context).textTheme.body1,
                              onChanged: (value) {
                                filterSearchResultByYear(value);
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        IconButton(
                          icon: Icon(Icons.search),
                          onPressed: () {},
                        )
                      ],
                    ),
                  )),
            ),
            Expanded(
              child: listMovie(),
            )
          ],
        ));
  }

  Widget listMovie() {
    return BlocBuilder<SearchMovieBlocBloc, SearchMovieBlocState>( 
        builder: (context, state){
          if(state is SearchMovieByTitleYearState){
            _listMovies = state.searchMovieLists;
            return ListMovies(_listMovies, _addToMovieList);
          } else {
            return const SizedBox.shrink();
          }
        }
    ,);
  }
}
