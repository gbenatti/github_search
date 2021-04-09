
import 'package:github_search/core/error/exceptions.dart';
import 'package:github_search/features/user_search/data/data_sources/user_remote_data_source.dart';
import 'package:github_search/features/user_search/data/models/user_model.dart';

import 'github_api.dart';

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final GithubApi api;

  UserRemoteDataSourceImpl(this.api);

  @override
  Future<List<UserModel>> searchUsers(String query) async {
    final result = await api.searchUser(query);
    final statusCode = result.response.statusCode;
    
    if (statusCode >= 200 && statusCode < 300) {
      return result.data.results.map((e) => e.toModel()).toList();
    } else {
      throw ServerException(statusCode: statusCode);
    }
  }
}
