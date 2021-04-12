import 'package:dartz/dartz.dart';
import 'package:github_search/core/error/failures.dart';
import 'package:github_search/features/common/data/data_sources/favorite_local_data_source.dart';
import 'package:github_search/features/common/data/models/user_model.dart';
import 'package:github_search/features/common/domain/entities/user.dart';
import 'package:github_search/features/common/domain/repositories/favorite_repository.dart';

class FavoriteRepositoryImpl implements FavoriteRepository {
  final FavoriteLocalDataSource dataSource;

  FavoriteRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, List<User>>> loadFavorites() async {
    try {
      final result = await dataSource.loadFavorites();
      return Right(result);
    } on Exception {
      return Left(LoadFailure());
    }
  }

  @override
  Future<Either<Failure, List<User>>> updateFavorites(User user, bool value) async {
    try {
      final result = await _updateFavorites(user, value);
      return Right(result);
    } on Exception {
      return Left(UpdateFavoriteFailure());
    }    
  }

  Future<List<UserModel>> _updateFavorites(User user, bool value) async {
    if (value) {
      return await dataSource.addFavorite(user);
    } else {
      return await dataSource.removeFavorite(user);
    }
  }
}
