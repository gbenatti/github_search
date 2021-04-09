import 'package:flutter/material.dart';
import 'package:github_search/features/user_search/domain/entities/user.dart';

class UserCard extends StatelessWidget {
  const UserCard({
    Key key,
    @required this.user,
    @required this.onDetails,
  }) : super(key: key);

  final User user;
  final void Function() onDetails;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Container(
        height: 80,
      ),
    );
  }
}
