
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/core/error/exceptions.dart';
import 'package:github_search/core/error/failures.dart';
import 'package:github_search/core/infra/network_info.dart';
import 'package:github_search/features/user_search/data/data_sources/user_remote_data_source.dart';
import 'package:github_search/features/user_search/data/repositories/user_repository_impl.dart';
import 'package:github_search/features/user_search/domain/repositories/user_repository.dart';
import 'package:mockito/mockito.dart';

import '../../../../mocks.dart';

void main() {
  UserRemoteDataSource remoteDataSource;
  NetworkInfo networkInfo;
  UserRepository repository;

  setUp(() {
    remoteDataSource = MockUserRemoteDataSource();
    networkInfo = MockNetworkInfo();
    repository = UserRepositoryImpl(remoteDataSource, networkInfo);
  });

  final first = MockUserModel();
  final second = MockUserModel();
  final third = MockUserModel();
  final userModelList = [first, second, third];
  const query = "John Snow";

  group("when connection is on", () {
    setUp(() {
      when(networkInfo.isConnected).thenAnswer((_) async => true);
    });

    test("should return list of users from data source", () async {
      // arrange
      when(remoteDataSource.searchUsers(any))
          .thenAnswer((_) async => userModelList);

      // act
      final result = await repository.searchUsers(query);

      // assert
      expect(result, Right(userModelList));
      verify(networkInfo.isConnected);
      verify(remoteDataSource.searchUsers(query));
      verifyNoMoreInteractions(remoteDataSource);
      verifyNoMoreInteractions(networkInfo);
    });

    test("should return ServerFailure when data source throws a ServerException", () async {
      // arrange
      when(remoteDataSource.searchUsers(any)).thenThrow(ServerException(statusCode: 404));

      // act
      final result = await repository.searchUsers(query);

      // assert
      expect(result, Left(ServerFailure(statusCode: 404)));
      verify(networkInfo.isConnected);
      verify(remoteDataSource.searchUsers(query));
      verifyNoMoreInteractions(networkInfo);
      verifyNoMoreInteractions(remoteDataSource);
    });
  });
  
  group("when connection is off", () {
    setUp(() {
      when(networkInfo.isConnected).thenAnswer((_) async => false);
    });

    test("should return NoConnectionFailure", () async {
      // arrange
      when(remoteDataSource.searchUsers(any))
          .thenAnswer((_) async => userModelList);

      // act
      final result = await repository.searchUsers(query);

      // assert
      expect(result, Left(NoConnectionFailure()));
      verify(networkInfo.isConnected);
      verifyNever(remoteDataSource.searchUsers(query));
      verifyNoMoreInteractions(networkInfo);
    });
  });
}
