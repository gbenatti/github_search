import 'package:dartz/dartz.dart';
import 'package:github_search/core/domain/usecases.dart';
import 'package:github_search/core/error/failures.dart';
import 'package:github_search/features/common/domain/entities/favorite.dart';
import 'package:github_search/features/common/domain/repositories/favorite_repository.dart';

class LoadFavorites implements UseCase<List<Favorite>, NoParams>{
  final FavoriteRepository repository;

  LoadFavorites(this.repository);
  
  @override
  Future<Either<Failure, List<Favorite>>> call(NoParams params) {
    throw UnimplementedError();
  }
 }