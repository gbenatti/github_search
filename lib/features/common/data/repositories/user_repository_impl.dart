import 'package:dartz/dartz.dart';
import 'package:github_search/core/error/exceptions.dart';
import 'package:github_search/core/error/failures.dart';
import 'package:github_search/core/infra/network_info.dart';
import 'package:github_search/features/common/data/data_sources/user_remote_data_source.dart';
import 'package:github_search/features/common/domain/entities/user.dart';
import 'package:github_search/features/common/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository{
  final UserRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  UserRepositoryImpl(this.remoteDataSource, this.networkInfo);

  @override
  Future<Either<Failure, List<User>>> searchUsers(String username) async {
    final connected = await networkInfo.isConnected;
    if (connected) {
      try {
        final result = await remoteDataSource.searchUsers(username);
        return Right(result);
      } on ServerException catch (e) {
        return Left(ServerFailure(statusCode: e.statusCode));
      }
    } else {
      return Left(NoConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, User>> getUserDetails(String login) async {
    final connected = await networkInfo.isConnected;
    if (connected) {
      try {
        final result = await remoteDataSource.getUserDetails(login);
        return Right(result.toUser());
      } on ServerException catch (e) {
        return Left(ServerFailure(statusCode: e.statusCode));
      }
    } else {
      return Left(NoConnectionFailure());
    }
  }
}
