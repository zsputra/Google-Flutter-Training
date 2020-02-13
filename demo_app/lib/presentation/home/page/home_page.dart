import 'dart:convert';

import 'package:demo_app/common/network/network_utils.dart';
import 'package:demo_app/common/network2/omdb_movie_client.dart';
import 'package:demo_app/common/routes/routes.dart';
import 'package:demo_app/data/omdb/datasources/omdb_remote_datasource.dart';
import 'package:demo_app/data/omdb/repository/omdb_repository.dart';
import 'package:demo_app/data/ws/datasources/ws_remote_datasource.dart';
import 'package:demo_app/presentation/dashboard/page/dashboard_page.dart';
import 'package:demo_app/presentation/favorite_movies/page/favorite_page.dart';
import 'package:demo_app/presentation/search/page/search_page.dart';
import 'package:demo_app/presentation/setting/page/setting_page.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';


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
        automaticallyImplyLeading: false,
        title: Text('Menu'),
      ),
      ListTile(
        leading: Icon(Icons.dashboard),
        title: Text('Dashboard'),
        onTap: () {
          _updateCurrentProject(0);
        },
      ),
      ListTile(
        leading: Icon(Icons.search),
        title: Text('Search'),
        onTap: () {
          _updateCurrentProject(1);
        },
      ),
      ListTile(
        leading: Icon(Icons.favorite),
        title: Text('Favorite'),
        onTap: () {
          _updateCurrentProject(2);
        },
      ),
      ListTile(
        leading: Icon(Icons.settings),
        title: Text('Settings'),
        onTap: () {
          _updateCurrentProject(3);
          Navigator.pop(context);
        },
      ),
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
