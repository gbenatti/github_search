import 'package:flutter/foundation.dart';
import 'package:github_search/features/common/domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    @required int id,
    @required String login,
    @required String avatarUrl,
    @required String htmlUrl,
    @required String type,
    String name,
    String company,
    String location,
    String bio,
    String email,
  }) : super(
          id: id,
          login: login,
          htmlUrl: htmlUrl,
          avatarUrl: avatarUrl,
          type: type,
          name: name,
          company: company,
          location: location,
          bio: bio,
          email: email,
        );

  User toUser() => User(
        id: this.id,
        login: this.login,
        htmlUrl: this.htmlUrl,
        avatarUrl: this.avatarUrl,
        type: this.type,
        name: this.name,
        company: this.company,
        location: this.location,
        bio: this.bio,
        email: this.email,
      );
}
