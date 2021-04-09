import 'package:dartz/dartz.dart';
import 'package:github_search/core/error/failures.dart';
import 'package:github_search/features/user_search/domain/entities/user.dart';

abstract class UserRepository {
  Future<Either<Failure, List<User>>> searchUser(String username);
}
