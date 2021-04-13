import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:github_search/dependency_injection.dart';
import 'package:github_search/features/user_detail/presentation/pages/user_detail_page.dart';
import 'package:github_search/features/user_search/presentation/cubits/favorites_cubit.dart';
import 'package:github_search/features/user_search/presentation/cubits/user_search_cubit.dart';
import 'package:github_search/features/common/presentation/widgets/display_message.dart';
import 'package:github_search/features/common/presentation/widgets/loading_widget.dart';
import 'package:github_search/features/user_search/presentation/widgets/user_list_widget.dart';

class UserSearchPage extends StatelessWidget {
  const UserSearchPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserSearchCubit>(
          create: (_) => sl<UserSearchCubit>(),
        ),
        BlocProvider<FavoritesCubit>(
          create: (_) => sl<FavoritesCubit>()..load(),
        ),
      ],
      child: const _UserSearchPage(),
    );
  }
}

class _UserSearchPage extends StatefulWidget {
  const _UserSearchPage({Key key}) : super(key: key);

  @override
  _UserSearchPageState createState() => _UserSearchPageState();
}

class _UserSearchPageState extends State<_UserSearchPage> {
  SearchBar searchBar;
  bool showingFavorites = false;

  @override
  void initState() {
    searchBar = SearchBar(
      inBar: false,
      buildDefaultAppBar: _buildAppBar,
      setState: setState,
      onSubmitted: _submit,
    );
    super.initState();
  }

  void _submit(String term) {
    final searchCubit = context.read<UserSearchCubit>();
    searchCubit.search(term);
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text("Github users"),
      actions: [
        if (!showingFavorites) searchBarAction(),
        favoriteFilterAction(),
      ],
    );
  }

  Widget searchBarAction() {
    return searchBar.getSearchAction(context);
  }

  Widget favoriteFilterAction() {
    return IconButton(
        icon: Icon(showingFavorites ? Icons.favorite : Icons.favorite_outline),
        onPressed: toggleFavorites);
  }

  void toggleFavorites() {
    setState(() {
      showingFavorites = !showingFavorites;
    });
    if (showingFavorites) _loadFavorites(context);
  }

  void _loadFavorites(BuildContext context) {
    final favoritesCubit = context.read<FavoritesCubit>();
    favoritesCubit.load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: searchBar.build(context),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return !showingFavorites ? _buildSearchBody() : _buildFavoritesBody();
  }

  Widget _buildSearchBody() {
    return BlocConsumer<UserSearchCubit, UserSearchState>(
      listener: (context, state) => _handleSearchPossibleError(state, context),
      builder: (context, state) => _buildSearchContent(state),
    );
  }

  Widget _buildFavoritesBody() {
    return BlocConsumer<FavoritesCubit, FavoritesState>(
      listener: (context, state) =>
          _handleFavoritesPossibleError(state, context),
      builder: (context, state) => _buildFavoritesContent(state),
    );
  }

  void _handleSearchPossibleError(UserSearchState state, BuildContext context) {
    if (state is UserSearchError) {
      Scaffold.of(context).showSnackBar(SnackBar(content: Text(state.message)));
    }
  }

  Widget _buildSearchContent(UserSearchState state) {
    if (state is UserSearchEmpty) {
      return _showEmptyMessage(
        icon: Icons.search,
        message: "Nenhum resultado",
        description: "Tente fazer uma busca.",
      );
    } else if (state is UserSearching) {
      return const LoadingWidget();
    } else if (state is UserSearchDone) {
      return UserListWidget(
        users: state.users,
        onFavorite: (user, value) {
          final favoritesCubit = context.read<FavoritesCubit>();
          favoritesCubit.updateFavorite(user, value);
        },
        onDetails: (user) => Navigator.push(
          context,
          UserDetailPage.route(user.login),
        ),
      );
    }

    return Container();
  }

  DisplayMessage _showEmptyMessage(
      {IconData icon, String message, String description}) {
    return DisplayMessage(
      icon: Icon(
        icon,
        size: 64,
      ),
      message: message,
      description: description,
    );
  }

  void _handleFavoritesPossibleError(
      FavoritesState state, BuildContext context) {
    if (state is FavoritesLoadError) {
      Scaffold.of(context).showSnackBar(
          SnackBar(content: Text("Erro carregando os favoritos")));
    }
  }

  Widget _buildFavoritesContent(FavoritesState state) {
    if (state is FavoritesLoading) {
      return LoadingWidget();
    }
    if (state is FavoritesLoaded) {
      if (state.favorites.isEmpty) {
        return _showEmptyMessage(
          icon: Icons.favorite,
          message: "Nenhum favorito",
          description: "Tente mostrar seu amor por alguem",
        );
      } else {
        return UserListWidget(
          users: state.favorites,
          onFavorite: (user, value) {
            final favoritesCubit = context.read<FavoritesCubit>();
            favoritesCubit.updateFavorite(user, value);
          },
          onDetails: (user) => Navigator.push(
            context,
            UserDetailPage.route(user.login),
          ),
        );
      }
    }

    return Container();
  }
}
