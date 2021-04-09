import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:github_search/core/domain/usecases.dart';
import 'package:github_search/core/error/failures.dart';
import 'package:github_search/features/user_search/domain/entities/user.dart';
import 'package:github_search/features/user_search/domain/repositories/user_repository.dart';

class SearchUser implements UseCase<List<User>, Params> {
  final UserRepository repository;

  SearchUser(this.repository);
  
  @override
  Future<Either<Failure, List<User>>> call(params) {
    return repository.searchUsers(params.query);
  }
}

class Params extends Equatable {
  final String query;

  const Params({@required this.query});

  @override
  List<Object> get props => [query];
}