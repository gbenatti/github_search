import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:github_search/core/domain/usecases.dart';
import 'package:github_search/features/common/domain/entities/user.dart';
import 'package:github_search/features/user_search/domain/usecases/load_favorites.dart';
import 'package:github_search/features/user_search/domain/usecases/update_favorite.dart';

part 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  final LoadFavorites loader;
  final UpdateFavorite updater;

  FavoritesCubit({this.loader, this.updater}) : super(FavoritesInitial());

  void load() async {
    emit(FavoritesLoading());
    final result = await loader(NoParams());
    result.fold(
      (l) => emit(FavoritesLoadError()),
      (r) {
        emit(FavoritesUpdating());
        emit(FavoritesLoaded(favorites: r));
      },
    );
  }

  void updateFavorite(User user, bool value) async {
    final result = await updater(Params(user: user, value: value));
    result.fold(
      (l) => emit(FavoritesUpdateError()),
      (r) {
        emit(FavoritesUpdating());
        emit(FavoritesLoaded(favorites: r));
      },
    );
  }
}
