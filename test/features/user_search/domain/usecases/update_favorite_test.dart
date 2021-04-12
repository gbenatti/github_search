import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/core/error/failures.dart';
import 'package:github_search/features/common/domain/repositories/favorite_repository.dart';
import 'package:github_search/features/user_search/domain/usecases/update_favorite.dart';
import 'package:mockito/mockito.dart';

import '../../../../mocks.dart';

void main() {
  FavoriteRepository repository;
  UpdateFavorite usecase;

  setUp(() {
    repository = MockFavoriteRepository();
    usecase = UpdateFavorite(repository);
  });

  final first = MockUser();
  final favoriteList = [first];

  group("set/add favorite", () {
    test("should set/add user as favorite using repository", () async {
      // arrange
      when(repository.updateFavorites(any, any))
          .thenAnswer((_) async => Right(favoriteList));

      // act
      final result = await usecase(Params(user: first, value: true));

      // assert
      expect(result, Right(favoriteList));
      verify(repository.updateFavorites(first, true));
      verifyNoMoreInteractions(repository);
    });

    final failure = LoadFailure();

    test(
        "should return failure if the repository fails to set/add user as favorite",
        () async {
      // arrange
      when(repository.updateFavorites(any, any))
          .thenAnswer((_) async => Left(failure));

      // act
      final result = await usecase(Params(user: first, value: true));

      // assert
      expect(result, Left(failure));
      verify(repository.updateFavorites(first, true));
      verifyNoMoreInteractions(repository);
    });
  });

  group("reset/remove", () {
    final emptyList = [first];

    test("should reset/remove user as favorite using repository", () async {
      // arrange
      when(repository.updateFavorites(any, any))
          .thenAnswer((_) async => Right(emptyList));

      // act
      final result = await usecase(Params(user: first, value: false));

      // assert
      expect(result, Right(emptyList));
      verify(repository.updateFavorites(first, false));
      verifyNoMoreInteractions(repository);
    });

    final failure = LoadFailure();

    test(
        "should return failure if the repository fails to reset/remove user as favorite",
        () async {
      // arrange
      when(repository.updateFavorites(any, any))
          .thenAnswer((_) async => Left(failure));

      // act
      final result = await usecase(Params(user: first, value: false));

      // assert
      expect(result, Left(failure));
      verify(repository.updateFavorites(first, false));
      verifyNoMoreInteractions(repository);
    });
  });
}
