import 'package:flutter/material.dart';
import 'package:github_search/features/common/domain/entities/user.dart';

import 'user_card.dart';

class UserListWidget extends StatelessWidget {
  final List<User> users;
  final Function(User) onDetails;
  final Function(User) onFavorite;

  const UserListWidget({
    Key key,
    this.users,
    this.onDetails,
    this.onFavorite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 4.0,
          horizontal: 4.0,
        ),
        child: UserCard(
          user: users[index],
          onDetails: onDetails != null ?  () => onDetails(users[index]) : null,
          onFavorite: onFavorite != null ? () => onFavorite(users[index]) : null,
        ),
      ),
    );
  }
}
