import 'package:flutter/material.dart';

import 'package:github_search/features/common/domain/entities/user.dart';

const notInformed = "Informação não disponível";

class UserDetailView extends StatelessWidget {
  const UserDetailView({Key key, this.user}) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _UserHeader(user: user),
        SizedBox(
          height: 24,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: _IconText(
            icon: Icons.email_outlined,
            text: _getTextOr(user.email, notInformed),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: _IconText(
            icon: Icons.link_outlined,
            text: _getTextOr(user.htmlUrl, notInformed),
          ),
        ),
        SizedBox(
          height: 24,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: _IconText(
            icon: Icons.map_outlined,
            text: _getTextOr(user.location, notInformed),
          ),
        ),
        SizedBox(
          height: 16,
        ),
        Divider(thickness: 1, indent: 16, endIndent: 16,),
        SizedBox(
          height: 12,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 64.0),
          child: Center(
              child: user.bio.isNotEmpty
                  ? _QuoteText(text: user.bio)
                  : Text("Biografia não disponível")),
        ),
      ],
    );
  }

  String _getTextOr(String text, String placeholder) {
    return (text != null && text.isNotEmpty) ? text : placeholder;
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
        Hero(
          tag: user.avatarUrl,
          child: Image.network(
            user.avatarUrl,
            width: double.infinity,
            height: 240,
            fit: BoxFit.fitWidth,
          ),
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

class _QuoteText extends StatelessWidget {
  _QuoteText({
    Key key,
    @required this.text,
  }) : super(key: key);

  final String text;

  final quoteStyle = TextStyle(
    fontSize: 20,
    color: Colors.black,
  );

  final textStyle = TextStyle(
    fontSize: 16,
    color: Colors.black,
  );

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: "❝ ",
        style: quoteStyle,
        children: [
          TextSpan(
            text: text,
            style: textStyle,
            children: [
              TextSpan(
                text: " ❞",
                style: quoteStyle,
              ),
            ],
          )
        ],
      ),
    );
  }
}
