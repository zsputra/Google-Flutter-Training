import 'dart:convert';

import 'package:demo_app/data/dummy_movies.dart';
import 'package:demo_app/data/omdb/datasources/omdb_remote_datasource.dart';
import 'package:demo_app/data/omdb/models/movies.dart';
import 'package:demo_app/data/omdb/repository/omdb_repository.dart';
import 'package:demo_app/data/ws/datasources/ws_remote_datasource.dart';
import 'package:demo_app/network/omdb_movie_client.dart';
import 'package:demo_app/pages/dashboard_page.dart';
import 'package:demo_app/pages/favorite_page.dart';
import 'package:demo_app/pages/search_page.dart';
import 'package:demo_app/pages/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyHomePage();
  }
}

class _MyHomePage extends State<MyHomePage> {
  int myCurrentIndex ;
  Widget page;
  String _title;

  Future<OmdbRepository> get nasaAsteroidRepository async => OmdbRepositoryImpl(
        datasource: OmdbMovieRemoteDatasourceImpl(
          client: OmdbWsClientImpl(http.Client()),
        ),
      );

  OmdbMovieRemoteDatasource get nasaAsteroidRDS =>
      OmdbMovieRemoteDatasourceImpl(
        client: OmdbWsClientImpl(http.Client()),
      );

  WsMovieRemoteDatasource get wsRDS => WsMovieRemoteDatasourceImpl.create();

  List<Widget> pages = [
    DashboardPage(),
    SearchPage(),
    FavoritePage(),
    SettingPage()
  ];

  List<String> _pageTitle = [
    "Dashboard",
    "Search Page",
    "Favorite Page",
    "Settings"
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    page = pages[0];
    myCurrentIndex = 0;
    // _title = "Dashboard";
  }

  void _updateCurrentProject(int index) {
    setState(() {
      myCurrentIndex = index;
      page = pages[index];
    });
  }

  final List<BottomNavigationBarItem> _bottomNavigators = [
    BottomNavigationBarItem(
      // backgroundColor: Colors.deepOrange,
      icon: Icon(Icons.dashboard),
      title: Text('Dashboard'),
    ),
    BottomNavigationBarItem(
        // backgroundColor: Colors.deepOrange,
        icon: Icon(Icons.search),
        title: Text("Search")),
    BottomNavigationBarItem(
        // backgroundColor: Colors.deepOrange,
        icon: Icon(
          Icons.favorite,
        ),
        title: Text('Favorite')),
    BottomNavigationBarItem(
        // backgroundColor: Colors.deepOrange,
        icon: Icon(Icons.settings),
        title: Text('Settings'))
  ];

  @override
  Widget build(BuildContext context) {
    final List<Widget> _drawersMenu = [
      AppBar(
        // leading: IconButton(icon: Icon(Icons.child_care), tooltip: 'Menu', onPressed: (){},),
        automaticallyImplyLeading: false,
        title: Text('Drawer'),
      ),
      ListTile(
        title: Text('Dashboard'),
        onTap: () async {
          String token = "zainudin.saputra@dkatalis.com";
          String uri =
              "https://demo-video-ws-chfmsoli4q-ew.a.run.app/video-ws/videos";
          Map<String, String> headers = {
            'token': token,
            'Content-Type': 'application/json'
          };
          // coba2();
          // Response response = await wsRDS.postMovie(new MovieDetail());
          // final repository = await nasaAsteroidRepository;
          // final list = await repository.getAllMovies();
          MovieDetail movies = MovieDetail(
              id: "1434ss",
              title: "Berenang",
              label: "label",
              priority: 1,
              poster: "poster",
              rating: 10,
              timestamp: 12331,
              viewed: true,
              year: "2020");
          var json = jsonEncode(movies.toJson());
          print(json);
          Response response =
              await http.post(uri, headers: headers, body: json);
          final list2 = await wsRDS.getAllMovies();

          print(list2[0].poster);

          _updateCurrentProject(0);
        },
      ),
      ListTile(
        title: Text('Search'),
        onTap: () {
          _updateCurrentProject(1);
        },
      ),
      ListTile(
        title: Text('Favorite'),
        onTap: () {
          _updateCurrentProject(2);
        },
      ),
      ListTile(
        title: Text('Settings'),
        onTap: () {
          _updateCurrentProject(3);
        },
      )
    ];
    return Scaffold(
      drawer: Drawer(
        child: Column(children: _drawersMenu),
      ),
      appBar: AppBar(
        title: Text(_pageTitle[myCurrentIndex]),
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        currentIndex: myCurrentIndex,
        items: _bottomNavigators,
        onTap: _updateCurrentProject,
      ),
      body: page,
    );
  }
}
