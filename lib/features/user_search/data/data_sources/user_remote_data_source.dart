import 'package:github_search/features/user_search/data/models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<List<UserModel>> searchUsers(String query);
}
