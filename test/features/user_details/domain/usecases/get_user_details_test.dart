import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/core/error/failures.dart';
import 'package:github_search/features/common/domain/entities/user.dart';
import 'package:github_search/features/common/domain/repositories/user_repository.dart';
import 'package:github_search/features/user_detail/domain/usecases/get_user_detail.dart';
import 'package:mockito/mockito.dart';

import '../../../../mocks.dart';

void main() {
  GetUserDetails usecase;
  UserRepository repository;

  setUp(() {
    repository = MockUserRepository();
    usecase = GetUserDetails(repository);
  });

  final login = "sholmes";

  final userData = User(
    id: 1,
    login: login,
    type: "User",
    avatarUrl: "http://holmes.jpeg",
    htmlUrl: "http://htmls/holmes.html",
    name: "Sherlock Holmes",
    location: "londres",
    bio: "The greatest detective in the world",
    company: "Holmes & Watson",
    email: "sholmes@holmes.com",
  );

  test("should get user detail from repository", () async {
    // arrange
    when(repository.getUserDetails(any))
        .thenAnswer((_) async => Right(userData));

    // act
    final result = await usecase(Params(login: login));

    // assert
    expect(result, Right(userData));
    verify(repository.getUserDetails(login));
    verifyNoMoreInteractions(repository);
  });

  final failure = ServerFailure(statusCode: 404);

  test("should return failure if the repository fails", () async {
    // arrange
    when(repository.getUserDetails(any))
        .thenAnswer((_) async => Left(failure));

    // act
    final result = await usecase(Params(login: login));

    // assert
    expect(result, Left(failure));
    verify(repository.getUserDetails(login));
    verifyNoMoreInteractions(repository);
  });
}

