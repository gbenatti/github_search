import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/core/error/exceptions.dart';
import 'package:github_search/core/error/failures.dart';
import 'package:github_search/features/common/data/data_sources/favorite_local_data_source.dart';
import 'package:github_search/features/common/data/models/user_model.dart';
import 'package:github_search/features/common/data/repositories/favorite_repository_impl.dart';
import 'package:github_search/features/common/domain/repositories/favorite_repository.dart';
import 'package:mockito/mockito.dart';

import '../../../mocks.dart';

void main() {
  FavoriteLocalDataSource dataSource;
  FavoriteRepository repository;

  setUp(() {
    dataSource = MockFavoriteLocalDataSource();
    repository = FavoriteRepositoryImpl(dataSource);
  });

  final first = MockUserModel();
  final second = MockUserModel();
  final third = MockUserModel();
  final favoriteModelList = [first, second, third];

  group("load favorites", () {
    test("should return list of favorites from data source", () async {
      // arrange
      when(dataSource.loadFavorites())
          .thenAnswer((_) async => favoriteModelList);

      // act
      final result = await repository.loadFavorites();

      // assert
      expect(result, Right(favoriteModelList));
      verify(dataSource.loadFavorites());
      verifyNoMoreInteractions(dataSource);
    });

    test("should return LoadFailure when data source throws a LoadException",
        () async {
      // arrange
      when(dataSource.loadFavorites()).thenThrow(LoadException());

      // act
      final result = await repository.loadFavorites();

      // assert
      expect(result, Left(LoadFailure()));
      verify(dataSource.loadFavorites());
      verifyNoMoreInteractions(dataSource);
    });
  });

  final firstList = [first];
  final emptyList = <UserModel>[];

  group("update favorites", () {
    test(
        "should return user on favorites from data source when adding favorite",
        () async {
      // arrange
      when(dataSource.addFavorite(any)).thenAnswer((_) async => firstList);
      
      // act
      final result = await repository.updateFavorites(first, true);
      
      // assert
      expect(result, Right(firstList));
      verify(dataSource.addFavorite(first));
      verifyNoMoreInteractions(dataSource);
    });

    test(
        "should return favorites without user from data source when removing favorite",
        () async {
      // arrange
      when(dataSource.removeFavorite(any)).thenAnswer((_) async => emptyList);
      
      // act
      final result = await repository.updateFavorites(first, false);
      
      // assert
      expect(result, Right(emptyList));
      verify(dataSource.removeFavorite(first));
      verifyNoMoreInteractions(dataSource);
    });
  });
}
