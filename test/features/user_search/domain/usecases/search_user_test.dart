import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/core/error/failures.dart';
import 'package:github_search/features/user_search/domain/repositories/user_repository.dart';
import 'package:github_search/features/user_search/domain/usecases/search_user.dart';
import 'package:mockito/mockito.dart';

import '../../../../mocks.dart';

void main() {
  UserRepository repository;
  SearchUser usecase;

  setUp(() {
    repository = MockUserRepository();
    usecase = SearchUser(repository);
  });

  final first = MockUser();
  final second = MockUser();
  final third = MockUser();
  final userList = [first, second, third];
  const username = "James";

  test("should get list of users from repository", () async {
    // arrange
    when(repository.searchUsers(any))
        .thenAnswer((_) async => Right(userList));

    // act
    final result = await usecase(const Params(query: username));

    // assert
    expect(result, Right(userList));
    verify(repository.searchUsers(username));
    verifyNoMoreInteractions(repository);
  });

  final failure = ServerFailure(statusCode: 404);

  test("should return failure if the repository fails", () async {
    // arrange
    when(repository.searchUsers(any))
        .thenAnswer((_) async => Left(failure));

    // act
    final result = await usecase(const Params(query: username));

    // assert
    expect(result, Left(failure));
    verify(repository.searchUsers(username));
    verifyNoMoreInteractions(repository);
  });
}
