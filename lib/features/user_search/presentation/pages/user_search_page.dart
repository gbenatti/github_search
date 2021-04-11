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
          create: (_) => sl<FavoritesCubit>(),
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
    final userList = context.read<UserSearchCubit>();
    userList.search(term);
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: searchBar.build(context),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return BlocConsumer<UserSearchCubit, UserSearchState>(
      listener: (context, state) => _handlePossibleError(state, context),
      builder: (context, state) => _buildContent(state),
    );
  }

  void _handlePossibleError(UserSearchState state, BuildContext context) {
    if (state is UserSearchError) {
      Scaffold.of(context).showSnackBar(SnackBar(content: Text(state.message)));
    }
  }

  Widget _buildContent(UserSearchState state) {
    if (state is UserSearchEmpty) {
      return const DisplayMessage(
        icon: Icon(
          Icons.search,
          size: 64,
        ),
        message: "Nenhum resultado",
        description: "Tente fazer uma busca.",
      );
    } else if (state is UserSearching) {
      return const LoadingWidget();
    } else if (state is UserSearchDone) {
      return UserListWidget(
        users: state.users,
        onDetails: (user) => Navigator.push(
          context,
          UserDetailPage.route(user.login),
        ),
      );
    }

    return Container();
  }
}
