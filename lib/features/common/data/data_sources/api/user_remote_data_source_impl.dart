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
      return await _searchUsers(query);
    } on DioError catch (e) {
      throw ServerException(statusCode: e.response?.statusCode);
    } on Exception {
      throw ServerException();
    }
  }

  @override
  Future<UserModel> getUserDetails(String login) async {
    try {
      return await _getUserDetails(login);
    } on DioError catch (e) {
      throw ServerException(statusCode: e.response?.statusCode);
    } on Exception {
      throw ServerException();
    }
  }

  Future<List<UserModel>> _searchUsers(String query) async {
    final result = await api.searchUser(query);
    final statusCode = result.response.statusCode;

    if (statusCode >= 200 && statusCode < 300) {
      return result.data.items.map((e) => e.toModel()).toList();
    } else {
      throw ServerException(statusCode: statusCode);
    }
  }

  Future<UserModel> _getUserDetails(String login) async {
    final result = await api.getUser(login);
    final statusCode = result.response.statusCode;
    if (statusCode >= 200 && statusCode < 300) {
      return result.data.toModel();
    } else {
      throw ServerException(statusCode: statusCode);
    }
  }
}
