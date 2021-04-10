import 'package:github_search/features/common/data/models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<List<UserModel>> searchUsers(String query);
}
