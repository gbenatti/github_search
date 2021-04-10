import 'package:flutter/foundation.dart';
import 'package:github_search/features/common/domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    @required int id,
    @required String login,
    @required String avatarUrl,
    @required String htmlUrl,
    @required String type,
  }) : super(
          id: id,
          login: login,
          htmlUrl: htmlUrl,
          avatarUrl: avatarUrl,
          type: type,
        );
}
