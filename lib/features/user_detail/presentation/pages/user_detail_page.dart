import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_search/dependency_injection.dart';
import 'package:github_search/features/user_detail/presentation/cubits/user_detail_cubit.dart';
import 'package:github_search/features/common/presentation/widgets/loading_widget.dart';
import 'package:github_search/features/user_detail/presentation/widgets/user_detail_view.dart';

class UserDetailPage extends StatelessWidget {
  const UserDetailPage({
    Key key,
    @required this.username,
  }) : super(key: key);

  final String username;

  static Route route(String username) => MaterialPageRoute(
      builder: (context) => UserDetailPage(username: username));

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<UserDetailCubit>()..getDetails(username),
      child: _UserDetailPage(username: username),
    );
  }
}

class _UserDetailPage extends StatelessWidget {
  const _UserDetailPage({
    Key key,
    @required this.username,
  }) : super(key: key);

  final String username;

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
    return BlocConsumer<UserDetailCubit, UserDetailState>(
      listener: (context, state) => _handlePossibleError(state, context),
      builder: (context, state) => _buildContent(state),
    );
  }

  void _handlePossibleError(UserDetailState state, BuildContext context) {
    if (state is UserDetailLoadError) {
      Scaffold.of(context).showSnackBar(SnackBar(content: Text(state.message)));
    }
  }

  Widget _buildContent(UserDetailState state) {
    if (state is UserDetailLoading) {
      return LoadingWidget();
    } else if (state is UserDetailLoaded) {
      return UserDetailView(user: state.user);
    }

    return Container();
  }
}
