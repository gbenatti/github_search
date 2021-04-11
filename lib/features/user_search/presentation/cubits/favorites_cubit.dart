import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:github_search/core/domain/usecases.dart';
import 'package:github_search/features/common/domain/entities/favorite.dart';
import 'package:github_search/features/user_search/domain/usecases/load_favorites.dart';

part 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  final LoadFavorites loader;

  FavoritesCubit({this.loader}) : super(FavoritesInitial());

  void load() async {
    emit(FavoritesLoading());
    final result = await loader(NoParams());
    result.fold(
      (l) => emit(FavoritesLoadError()),
      (r) => emit(FavoritesLoaded(favorites: r)),
    );
  }
}
