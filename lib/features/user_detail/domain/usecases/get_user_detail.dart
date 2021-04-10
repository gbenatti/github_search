import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:github_search/core/domain/usecases.dart';
import 'package:github_search/core/error/failures.dart';
import 'package:github_search/features/common/domain/entities/user.dart';
import 'package:github_search/features/common/domain/repositories/user_repository.dart';

class GetUserDetails implements UseCase<User, Params> {
  final UserRepository repository;

  GetUserDetails(this.repository);

  @override
  Future<Either<Failure, User>> call(params) {
    return repository.getUserDetails(params.login);
  }
} 

class Params extends Equatable {
  final String login;

  const Params({@required this.login});

  @override
  List<Object> get props => [login];
}