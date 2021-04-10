import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class User extends Equatable {
  final int id;
  final String login;
  final String avatarUrl;
  final String htmlUrl;
  final String type;
  final String name;
  final String company;
  final String location;
  final String bio;
  final String email;

  User({
    @required this.id,
    @required this.login,
    @required this.avatarUrl,
    @required this.htmlUrl,
    @required this.type,
    this.name,
    this.company,
    this.location,
    this.bio,
    this.email,
  });

  @override
  List<Object> get props => [
        id,
        login,
        avatarUrl,
        htmlUrl,
        type,
        name,
        company,
        location,
        bio,
        email,
      ];
}
