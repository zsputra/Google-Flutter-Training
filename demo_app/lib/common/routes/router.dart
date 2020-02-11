import 'package:demo_app/common/routes/routes.dart';
import 'package:demo_app/pages/dashboard/page/dashboard_page.dart';
import 'package:demo_app/pages/favorite_movies/page/favorite_page.dart';
import 'package:demo_app/pages/home/page/home_page.dart';
import 'package:demo_app/pages/login/page/login_page.dart';
import 'package:demo_app/pages/search/page/search_page.dart';
import 'package:demo_app/pages/setting/page/setting_page.dart';
import 'package:demo_app/pages/splash/page/splash_page.dart';
import 'package:flutter/material.dart';


abstract class Router {
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