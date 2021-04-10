import 'package:flutter/material.dart';

import 'package:github_search/features/common/domain/entities/user.dart';

class UserDetailView extends StatelessWidget {
  const UserDetailView({Key key, this.user}) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _UserHeader(user: user),
        SizedBox(height: 24,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: _IconText(icon: Icons.email_outlined, text: user.email),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: _IconText(icon: Icons.link_outlined, text: user.htmlUrl),
        ),
        SizedBox(height: 24,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: _IconText(icon: Icons.map_outlined, text: user.location),
        ),
        SizedBox(height: 24,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Text(user.bio, style: TextStyle(fontSize: 20.0),),
        ),
      ],
    );
  }
}

class _UserHeader extends StatelessWidget {
  const _UserHeader({
    Key key,
    @required this.user,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.network(
          user.avatarUrl,
          width: double.infinity,
          height: 240,
          fit: BoxFit.fitWidth,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 24.0, top: 16.0),
          child: Text(
            user.name,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 24.0),
          child: Text(
            user.login,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w300,
            ),
          ),
        )
      ],
    );
  }
}

class _IconText extends StatelessWidget {
  const _IconText({
    Key key,
    @required this.icon,
    @required this.text,
  }) : super(key: key);

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon), 
        SizedBox(width: 8.0),
        Text(text),
      ],
    );
  }
}
