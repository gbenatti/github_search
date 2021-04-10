import 'package:github_search/core/error/exceptions.dart';
import 'package:github_search/features/common/data/data_sources/user_remote_data_source.dart';
import 'package:github_search/features/common/data/models/user_model.dart';

import 'package:dio/dio.dart';
import 'github_api.dart';

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final GithubApi api;

  UserRemoteDataSourceImpl(this.api);

  @override
  Future<List<UserModel>> searchUsers(String query) async {
    try {
      final result = await api.searchUser(query);
      final statusCode = result.response.statusCode;

      if (statusCode >= 200 && statusCode < 300) {
        return result.data.items.map((e) => e.toModel()).toList();
      } else {
        throw ServerException(statusCode: statusCode);
      }
    } on DioError catch(e){
      throw ServerException(statusCode: e.response?.statusCode);
    } on Exception {
      throw ServerException();
    }
  }

  @override
  Future<UserModel> getUserDetails(String login) {
    return null;
  }
}
