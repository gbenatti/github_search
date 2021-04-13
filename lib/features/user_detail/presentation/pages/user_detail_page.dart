import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_search/dependency_injection.dart';
import 'package:github_search/features/user_detail/presentation/cubits/user_detail_cubit.dart';
import 'package:github_search/features/common/presentation/widgets/loading_widget.dart';
import 'package:github_search/features/user_detail/presentation/widgets/user_detail_view.dart';
import 'package:github_search/features/user_search/presentation/cubits/favorites_cubit.dart';

class UserDetailPage extends StatelessWidget {
  const UserDetailPage({
    Key key,
    @required this.username,
    this.isFavorite,
  }) : super(key: key);

  final String username;
  final bool isFavorite;

  static Route route(String username, {bool isFavorite = false}) =>
      MaterialPageRoute(
        builder: (context) => UserDetailPage(
          username: username,
          isFavorite: isFavorite,
        ),
      );

  @override
  Widget build(BuildContext context) {
    if (!isFavorite) {
      return BlocProvider(
        create: (_) => sl<UserDetailCubit>()..getDetails(username),
        child: _UserDetailPage(
          username: username,
          isFavorite: isFavorite,
        ),
      );
    } else {
      return BlocProvider(
        create: (_) => sl<FavoritesCubit>()..load(),
        child: _UserDetailPage(
          username: username,
          isFavorite: isFavorite,
        ),
      );
    }
  }
}

class _UserDetailPage extends StatelessWidget {
  const _UserDetailPage({
    Key key,
    @required this.username,
    @required this.isFavorite,
  }) : super(key: key);

  final String username;
  final bool isFavorite;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(username),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (!isFavorite) {
      return BlocConsumer<UserDetailCubit, UserDetailState>(
        listener: (context, state) => _handleDetailsPossibleError(state, context),
        builder: (context, state) => _buildDetailsContent(state),
      );
    } else {
      return BlocConsumer<FavoritesCubit, FavoritesState>(
        listener: (context, state) => _handleFavoritesPossibleError(state, context),
        builder: (context, state) => _buildFavoritesContent(state),
      );
    }
  }

  void _handleDetailsPossibleError(UserDetailState state, BuildContext context) {
    if (state is UserDetailLoadError) {
      Scaffold.of(context).showSnackBar(SnackBar(content: Text(state.message)));
    }
  }

  Widget _buildDetailsContent(UserDetailState state) {
    if (state is UserDetailLoading) {
      return LoadingWidget();
    } else if (state is UserDetailLoaded) {
      return UserDetailView(user: state.user);
    }

    return Container();
  }

  void _handleFavoritesPossibleError(FavoritesState state, BuildContext context) {
    if (state is FavoritesLoadError) {
      Scaffold.of(context).showSnackBar(SnackBar(content: Text("Falha na carga do favorito")));
    }
  }

  Widget _buildFavoritesContent(FavoritesState state) {
    if (state is FavoritesLoading) {
      return LoadingWidget();
    } else if (state is FavoritesLoaded) {
      return UserDetailView(user: state.favorites.firstWhere((fav) => fav.login == username));
    }

    return Container();
  }
}
