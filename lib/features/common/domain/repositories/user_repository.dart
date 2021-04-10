import 'package:dartz/dartz.dart';
import 'package:github_search/core/error/failures.dart';
import 'package:github_search/features/common/domain/entities/user.dart';

abstract class UserRepository {
  Future<Either<Failure, List<User>>> searchUsers(String username);
  Future<Either<Failure, User>> getUserDetails(String login);
}
