import 'package:dartz/dartz.dart';
import 'package:github_search/core/error/failures.dart';
import 'package:github_search/features/common/domain/entities/user.dart';

abstract class FavoriteRepository {
  Future<Either<Failure, List<User>>> loadFavorites();
  Future<Either<Failure, List<User>>> updateFavorites(User user, bool value);
}
