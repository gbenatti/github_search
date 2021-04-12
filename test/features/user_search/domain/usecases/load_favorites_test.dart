import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/core/domain/usecases.dart';
import 'package:github_search/core/error/failures.dart';
import 'package:github_search/features/common/domain/repositories/favorite_repository.dart';
import 'package:github_search/features/user_search/domain/usecases/load_favorites.dart';
import 'package:mockito/mockito.dart';

import '../../../../mocks.dart';

void main() {
  FavoriteRepository repository;
  LoadFavorites usecase;

  setUp(() {
    repository = MockFavoriteRepository();
    usecase = LoadFavorites(repository);
  });

  final first = MockUser();
  final second = MockUser();
  final third = MockUser();
  final favoriteList = [first, second, third];

  test("should get list of favorites from repository", () async {
    // arrange
    when(repository.loadFavorites())
        .thenAnswer((_) async => Right(favoriteList));

    // act
    final result = await usecase(NoParams());

    // assert
    expect(result, Right(favoriteList));
    verify(repository.loadFavorites());
    verifyNoMoreInteractions(repository);
  });

  final failure = LoadFailure();

  test("should return failure if the repository fails", () async {
    // arrange
    when(repository.loadFavorites())
        .thenAnswer((_) async => Left(failure));

    // act
    final result = await usecase(NoParams());

    // assert
    expect(result, Left(failure));
    verify(repository.loadFavorites());
    verifyNoMoreInteractions(repository);
  });
}
