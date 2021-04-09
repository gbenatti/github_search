import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class User extends Equatable {
  final int id;
  final String login;
  final String avatarUrl;
  final String htmlUrl;
  final String type;

  User({
    @required this.id,
    @required this.login,
    @required this.avatarUrl,
    @required this.htmlUrl,
    @required this.type,
  });

  @override
  List<Object> get props => [
        id,
        login,
        avatarUrl,
        htmlUrl,
        type,
      ];
}
