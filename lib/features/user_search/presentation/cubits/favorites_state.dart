part of 'favorites_cubit.dart';

abstract class FavoritesState extends Equatable {
  const FavoritesState();

  @override
  List<Object> get props => [];
}

class FavoritesInitial extends FavoritesState {}
class FavoritesLoading extends FavoritesState {}
class FavoritesLoaded extends FavoritesState {
  final List<User> favorites;

  FavoritesLoaded({this.favorites});
}

class FavoritesUpdating extends FavoritesState {}
class FavoritesLoadError extends FavoritesState {}
class FavoritesUpdateError extends FavoritesState {}
