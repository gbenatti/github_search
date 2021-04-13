import 'package:flutter/material.dart';
import 'package:github_search/features/common/domain/entities/user.dart';

class UserCard extends StatelessWidget {
  const UserCard({
    Key key,
    @required this.user,
    @required this.isFavorite,
    @required this.onDetails,
    @required this.onFavorite,
  }) : super(key: key);

  final User user;
  final bool isFavorite;
  final void Function() onDetails;
  final void Function(User, bool) onFavorite;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onDetails,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                Row(
                  children: [
                    UserAvatar(user: user),
                    SizedBox(
                      width: 16,
                    ),
                    UserInfo(user: user),
                  ],
                ),
              ],
            ),
            IconButton(
              icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border_rounded),
              onPressed: () => onFavorite(user, !isFavorite),
            ),
          ],
        ),
      ),
    );
  }
}

class UserAvatar extends StatelessWidget {
  const UserAvatar({
    Key key,
    @required this.user,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      child: Hero(
        tag: user.avatarUrl,
        child: Image.network(user.avatarUrl),
      ),
    );
  }
}

class UserInfo extends StatelessWidget {
  const UserInfo({
    Key key,
    @required this.user,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          user.login,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(
          height: 12,
        ),
        Text(user.htmlUrl),
      ],
    );
  }
}
