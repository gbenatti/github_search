import 'package:dartz/dartz.dart';
import 'package:github_search/core/error/failures.dart';
import 'package:github_search/features/common/data/data_sources/favorite_local_data_source.dart';
import 'package:github_search/features/common/domain/entities/favorite.dart';
import 'package:github_search/features/common/domain/repositories/favorite_repository.dart';

class FavoriteRepositoryImpl implements FavoriteRepository {
  final FavoriteLocalDataSource dataSource;

  FavoriteRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, List<Favorite>>> loadFavorites() async {
    try {
      final result = await dataSource.loadFavorites();
      return Right(result);
    } on Exception {
      return Left(LoadFailure());
    }
  }
}
