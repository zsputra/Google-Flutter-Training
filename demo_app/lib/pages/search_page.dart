import 'package:demo_app/data/omdb/datasources/omdb_remote_datasource.dart';
import 'package:demo_app/data/omdb/models/movies.dart';
import 'package:demo_app/data/omdb/repository/omdb_repository.dart';
import 'package:demo_app/data/ws/datasources/ws_remote_datasource.dart';
import 'package:demo_app/network/omdb_movie_client.dart';
import 'package:demo_app/widgets/list_movies.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SearchPageImpl();
  }
}

class _SearchPageImpl extends State<SearchPage> {
  List<MovieDetail> _listMovies = new List<MovieDetail>();
  String _title;
  String _year;
  WsMovieRemoteDatasourceImpl get wsMovieRDS =>
      WsMovieRemoteDatasourceImpl.create();

  
      
  OmdbMovieRemoteDatasource get nasaAsteroidRDS =>
      OmdbMovieRemoteDatasourceImpl(
        client: OmdbWsClientImpl(Client()),
      );

  TextEditingController controller = TextEditingController();
  Future<OmdbRepository> get omdbRepository async => OmdbRepositoryImpl(
        datasource: OmdbMovieRemoteDatasourceImpl(
          client: OmdbWsClientImpl(Client()),
        ),
      );

  @override
  void initState() {
    _title = 'Ave';
    _getData();
    super.initState();
  }

  void _getData() async {
    try {
      // final repository = await omdbRepository;
      final list = await nasaAsteroidRDS.getMoviesByTitle(_title, null);

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

  void _addToMovieList(MovieDetail movieDetail)async {
    final repository = wsMovieRDS;
    setState(()  {
      repository.postMovie(movieDetail);
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
              child: FutureBuilder(
                future: nasaAsteroidRDS.getMoviesByTitle(_title, _year),
                builder: (BuildContext context,
                    AsyncSnapshot<List<MovieDetail>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      !snapshot.hasError) {
                    _listMovies = snapshot.data;
                    return ListMovies(_listMovies, _addToMovieList);
                  } else {
                    return _buildProgressBar();
                  }
                },
              ),
            )
          ],
        ));
  }
}
