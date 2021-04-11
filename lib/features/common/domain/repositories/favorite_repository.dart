import 'package:dartz/dartz.dart';
import 'package:github_search/core/error/failures.dart';
import 'package:github_search/features/common/domain/entities/favorite.dart';

abstract class FavoriteRepository {
  Future<Either<Failure, List<Favorite>>> loadFavorites();
}