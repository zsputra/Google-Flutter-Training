// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:demo_app/common/network2/omdb_movie_client.dart';
import 'package:http/src/client.dart';
import 'package:demo_app/data/omdb/datasources/omdb_remote_datasource.dart';
import 'package:demo_app/data/omdb/repository/omdb_repository.dart';
import 'package:demo_app/data/ws/datasources/ws_remote_datasource.dart';
import 'package:demo_app/data/ws/repository/ws_repository.dart';
import 'package:demo_app/domain/search/use_cases/search_use_case.dart';
import 'package:demo_app/presentation/search/bloc/bloc/search_movie_bloc_bloc.dart';
import 'package:demo_app/domain/edit_movie/use_cases/edit_movie_use_case.dart';
import 'package:demo_app/presentation/edit_movie/page/bloc/movieeditor_bloc.dart';
import 'package:demo_app/presentation/edit_favorite_movie/bloc/favoritedetail_bloc.dart';
import 'package:demo_app/presentation/favorite_movies/bloc/favoritemovies_bloc.dart';
import 'package:demo_app/presentation/favorite_movies/use_cases/favorite_movie_use_cases.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;
void $initGetIt({String environment}) {
  getIt
    ..registerFactory<OmdbWsClient>(() => OmdbWsClientImpl(getIt<Client>()))
    ..registerLazySingleton<OmdbWsClientImpl>(
        () => OmdbWsClientImpl(getIt<Client>()))
    ..registerFactory<OmdbMovieRemoteDatasource>(
        () => OmdbMovieRemoteDatasourceImpl(client: getIt<OmdbWsClient>()))
    ..registerLazySingleton<OmdbMovieRemoteDatasourceImpl>(
        () => OmdbMovieRemoteDatasourceImpl(client: getIt<OmdbWsClient>()))
    ..registerFactory<OmdbRepository>(() =>
        OmdbRepositoryImpl(datasource: getIt<OmdbMovieRemoteDatasource>()))
    ..registerSingleton<OmdbRepositoryImpl>(
        OmdbRepositoryImpl(datasource: getIt<OmdbMovieRemoteDatasource>()))
    ..registerFactory<WsMovieRemoteDatasource>(
        () => WsMovieRemoteDatasourceImpl(client: getIt<OmdbWsClient>()))
    ..registerLazySingleton<WsMovieRemoteDatasourceImpl>(
        () => WsMovieRemoteDatasourceImpl(client: getIt<OmdbWsClient>()))
    ..registerFactory<WsRepository>(
        () => WsRepositoryImpl(datasource: getIt<WsMovieRemoteDatasource>()))
    ..registerLazySingleton<WsRepositoryImpl>(
        () => WsRepositoryImpl(datasource: getIt<WsMovieRemoteDatasource>()))
    ..registerLazySingleton<GetAllMoviesByTitle>(
        () => GetAllMoviesByTitle(omdbRepository: getIt<OmdbRepository>()))
    ..registerFactory<SearchMovieBlocBloc>(() => SearchMovieBlocBloc())
    ..registerLazySingleton<LikeMovieUseCase>(
        () => LikeMovieUseCase(wsRepository: getIt<WsRepository>()))
    ..registerLazySingleton<UpdateMoveCase>(
        () => UpdateMoveCase(wsRepository: getIt<WsRepository>()))
    ..registerFactory<MovieeditorBloc>(() => MovieeditorBloc())
    ..registerFactory<FavoritedetailBloc>(() => FavoritedetailBloc())
    ..registerFactory<FavoritemoviesBloc>(() => FavoritemoviesBloc())
    ..registerLazySingleton<GetAllFavoriteMovieUseCase>(() => GetAllFavoriteMovieUseCase(wsRepository: getIt<WsRepository>()))
    ..registerLazySingleton<DeleteFavoriteMovieById>(() => DeleteFavoriteMovieById(wsRepository: getIt<WsRepository>()));
}
