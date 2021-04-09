import 'package:flutter/foundation.dart';
import 'package:github_search/features/user_search/domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    @required int id,
    @required String login,
    @required String avatarUrl,
    @required String type,
  }) : super(
          id: id,
          login: login,
          avatarUrl: avatarUrl,
          type: type,
        );
}
