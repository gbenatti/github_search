import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/core/error/failures.dart';
import 'package:github_search/features/user_search/domain/usecases/load_favorites.dart';
import 'package:github_search/features/user_search/presentation/cubits/favorites_cubit.dart';
import 'package:mockito/mockito.dart';

import '../../../../mocks.dart';

class MockLoadFavorites extends Mock implements LoadFavorites {}

void main() {
  LoadFavorites loader;

  test("initialState should be empty", () async {
    final loader = MockLoadFavorites();
    final cubit = FavoritesCubit(loader: loader);
    expect(cubit.state, FavoritesInitial());
  });

  final favorites = [MockUser(), MockUser(),];

  group("-", () {
    blocTest<FavoritesCubit, FavoritesState>(
      "should emit loading and loaded when load is called",
      build: () {
        loader = MockLoadFavorites();
        when(loader.call(any)).thenAnswer((_) async => Right(favorites));
        return FavoritesCubit(loader: loader);
      },
      act: (c) => c.load(),
      expect: <FavoritesState>[
        FavoritesLoading(),
        FavoritesLoaded(),
      ],
      verify: (c) {
        expect(c.state, FavoritesLoaded(favorites: favorites));
      },
    );

    blocTest<FavoritesCubit, FavoritesState>(
      "should emit loading and error when load failed",
      build: () {
        loader = MockLoadFavorites();
        when(loader.call(any)).thenAnswer((_) async => Left(LoadFailure()));
        return FavoritesCubit(loader: loader);
      },
      act: (c) => c.load(),
      expect: <FavoritesState>[
        FavoritesLoading(),
        FavoritesLoadError(),
      ],
    );
  });

}
