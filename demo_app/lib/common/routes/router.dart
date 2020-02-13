import 'package:demo_app/common/configure/getit_configuration.dart';
import 'package:demo_app/common/routes/routes.dart';
import 'package:demo_app/domain/entities/movies.dart';
import 'package:demo_app/presentation/dashboard/page/dashboard_page.dart';
import 'package:demo_app/presentation/favorite_movies/page/favorite_detail_page.dart';
import 'package:demo_app/presentation/favorite_movies/page/favorite_page.dart';
import 'package:demo_app/presentation/home/page/home_page.dart';
import 'package:demo_app/presentation/login/page/login_page.dart';
import 'package:demo_app/presentation/search/bloc/bloc/search_movie_bloc_bloc.dart';
import 'package:demo_app/presentation/search/page/search_page.dart';
import 'package:demo_app/presentation/setting/page/setting_page.dart';
import 'package:demo_app/presentation/splash/page/splash_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


abstract class Router {
  static Movie movie;
  static Map<String, WidgetBuilder> routes = {
    Routes.splash: (BuildContext context) => SplashScreen(),
    Routes.login: (BuildContext context) => LoginPage(),
    Routes.home: (BuildContext context) => BlocProvider<SearchMovieBlocBloc>(
      create: (context) => getIt<SearchMovieBlocBloc>(),
      child: MyHomePage(),
    ),
    Routes.dashboard: (BuildContext context) => DashboardPage(),
    Routes.search: (BuildContext context) => BlocProvider<SearchMovieBlocBloc>(
      create: (context) => getIt<SearchMovieBlocBloc>(),
      child: SearchPage(),
    ),
    Routes.favoriteList: (BuildContext context) => FavoritePage(),
    Routes.settings: (BuildContext context) => SettingPage(),
    Routes.favoriteDetails : (BuildContext context) => FavoriteDetailMoviePage(movie)
  };

  ///   settings/profile/edit/?title=Matrix&year=2010

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {

    return null;
  }

  static Route<dynamic> onUnknownRoute(RouteSettings settings) {
    return null;
  }

}