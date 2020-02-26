import 'package:demo_app/common/configure/getit_configuration.dart';
import 'package:demo_app/common/routes/routes.dart';
import 'package:demo_app/domain/entities/movies.dart';
import 'package:demo_app/presentation/dashboard/page/dashboard_page.dart';
import 'package:demo_app/presentation/edit_favorite_movie/bloc/favoritedetail_bloc.dart';
import 'package:demo_app/presentation/edit_movie/page/bloc/movieeditor_bloc.dart';
import 'package:demo_app/presentation/edit_movie/page/movie_editor_page.dart';
import 'package:demo_app/presentation/favorite_movies/bloc/favoritemovies_bloc.dart';
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
    // Routes.movieEditor: (BuildContext context) => LoginPage(),
    Routes.home: (BuildContext context) => MultiBlocProvider(
          providers: [
            BlocProvider<SearchMovieBlocBloc>(
                create: (context) => getIt<SearchMovieBlocBloc>()),
            BlocProvider<FavoritemoviesBloc>(
                create: (context) => getIt<FavoritemoviesBloc>()),
          ],
          child: MyHomePage(),
        ),

    Routes.dashboard: (BuildContext context) => DashboardPage(),
    Routes.search: (BuildContext context) => BlocProvider<SearchMovieBlocBloc>(
          create: (context) => getIt<SearchMovieBlocBloc>(),
          child: SearchPage(),
        ),
    Routes.favoriteList: (BuildContext context) => FavoritePage(),
    Routes.settings: (BuildContext context) => SettingPage(),

    // Routes.movieEditor : (BuildContext context) =>
  };

  ///   settings/profile/edit/?title=Matrix&year=2010

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final Object _args = settings.arguments;
    switch (settings.name) {
      case Routes.movieEditor:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<MovieeditorBloc>(
              create: (context) => getIt<MovieeditorBloc>(),
              child: MovieEditorPage(movie: _args)),
        );
      case Routes.favoriteDetails:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<FavoritedetailBloc>(
              create: (context) => getIt<FavoritedetailBloc>(),
              child: FavoriteDetailMoviePage(movie: _args)),
        );
    }
  }

  static Route<dynamic> onUnknownRoute(RouteSettings settings) {
    return null;
  }
}
