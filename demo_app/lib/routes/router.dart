import 'package:demo_app/data/omdb/models/movies.dart';
import 'package:demo_app/pages/dashboard_page.dart';
import 'package:demo_app/pages/favorite_page.dart';
import 'package:demo_app/pages/home_page.dart';
import 'package:demo_app/pages/login_page.dart';
import 'package:demo_app/pages/search_page.dart';
import 'package:demo_app/pages/setting_page.dart';
import 'package:demo_app/pages/splash_page.dart';
import 'package:demo_app/routes/routes.dart';
import 'package:flutter/material.dart';


abstract class Router {
  static List<MovieDetail> lists;
  static Map<String, WidgetBuilder> routes = {
    Routes.splash: (BuildContext context) => SplashScreen(),
    Routes.login: (BuildContext context) => LoginPage(),
    Routes.home: (BuildContext context) => MyHomePage(),
    Routes.dashboard: (BuildContext context) => DashboardPage(),
    Routes.search: (BuildContext context) => SearchPage(),
    Routes.favoriteList: (BuildContext context) => FavoritePage(),
    Routes.settings: (BuildContext context) => SettingPage(),
  };

  ///   settings/profile/edit/?title=Matrix&year=2010

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {

    return null;
  }

  static Route<dynamic> onUnknownRoute(RouteSettings settings) {
    return null;
  }

}