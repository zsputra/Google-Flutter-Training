import 'package:demo_app/common/configure/getit_configuration.dart';
import 'package:demo_app/common/models/use_case.dart';
import 'package:demo_app/data/omdb/models/omdb_movie_model.dart';
import 'package:demo_app/data/omdb/repository/omdb_repository.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
@injectable
class GetAllMoviesByTitle implements UseCase<List<OmdbMovieModel>, Map> {
  OmdbRepository omdbRepository = getIt<OmdbRepository>();

  GetAllMoviesByTitle({@required this.omdbRepository});

  @override
  Future<List<OmdbMovieModel>> call(Map payload) {
    String title = payload['title'] ?? null;
    String year = payload['year'] ?? null;
    return omdbRepository.searchMoviesByTitle(title, year);
  }
}

// @lazySingleton
// @injectable
// class GetFavoriteAsteroidByIdUsecase implements UseCase<FavoriteAsteroidEntity, int> {
//   final FavoriteAsteroidRepository favoriteAsteroidRepository;

//   GetFavoriteAsteroidByIdUsecase({@required this.favoriteAsteroidRepository});

//   @override
//   Future<FavoriteAsteroidEntity> call(int id) {
//     return favoriteAsteroidRepository.getAsteroidById(id);
//   }
// }

// @lazySingleton
// @injectable
// class CreateFavoriteAsteroidUsecase implements UseCase<void, FavoriteAsteroidEntity> {
// final FavoriteAsteroidRepository favoriteAsteroidRepository;

//   CreateFavoriteAsteroidUsecase({@required this.favoriteAsteroidRepository});

//   @override
//   Future<void> call(FavoriteAsteroidEntity asteroid) async {
//     await favoriteAsteroidRepository.createAsteroid(asteroid);
//   }
// }

// @lazySingleton
// @injectable
// class UpdateFavoriteAsteroidUsecase implements UseCase<void, FavoriteAsteroidEntity> {
//   final FavoriteAsteroidRepository favoriteAsteroidRepository;

//   UpdateFavoriteAsteroidUsecase({@required this.favoriteAsteroidRepository});

//   @override
//   Future<void> call(FavoriteAsteroidEntity asteroid) {
//     return favoriteAsteroidRepository.getAllAsteroids();
//   }
// }

// @lazySingleton
// @injectable
// class DeleteFavoriteAsteroidUsecase implements UseCase<void, FavoriteAsteroidEntity> {
//   final FavoriteAsteroidRepository favoriteAsteroidRepository;

//   DeleteFavoriteAsteroidUsecase({@required this.favoriteAsteroidRepository});

//   @override
//   Future<void> call(FavoriteAsteroidEntity asteroid) {
//     return favoriteAsteroidRepository.getAllAsteroids();
//   }
// }