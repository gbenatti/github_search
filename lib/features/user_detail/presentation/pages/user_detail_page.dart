import 'package:flutter/material.dart';

class UserDetailPage extends StatelessWidget {
  const UserDetailPage({
    Key key,
    @required this.username,
  }) : super(key: key);

  static Route route(String username) => MaterialPageRoute(
      builder: (context) => UserDetailPage(username: username));

  final String username;

  @override
  Widget build(BuildContext context) {
    return _UserDetailPage(username: username);
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

  Container _buildBody() => Container();
}
