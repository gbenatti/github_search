import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:github_search/core/domain/usecases.dart';
import 'package:github_search/core/error/failures.dart';
import 'package:github_search/features/common/domain/entities/user.dart';
import 'package:github_search/features/common/domain/repositories/favorite_repository.dart';

class UpdateFavorite implements UseCase<List<User>, Params>  {
  final FavoriteRepository repository;

  UpdateFavorite(this.repository);
  
  @override
  Future<Either<Failure, List<User>>> call(params) {
    return repository.updateFavorites(params.user, params.value);
  }
}

class Params extends Equatable {
  final User user;
  final bool value;

  const Params({@required this.user, @required this.value});

  @override
  List<Object> get props => [user, value];
}