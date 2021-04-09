import 'package:github_search/core/infra/network_info.dart';
import 'package:github_search/features/user_search/data/data_sources/api/github_api.dart';
import 'package:github_search/features/user_search/data/data_sources/user_remote_data_source.dart';
import 'package:github_search/features/user_search/data/models/user_model.dart';
import 'package:github_search/features/user_search/domain/entities/user.dart';
import 'package:github_search/features/user_search/domain/repositories/user_repository.dart';
import 'package:mockito/mockito.dart';
import 'package:retrofit/dio.dart';
import 'package:dio/dio.dart' show Response;

class MockUserRepository extends Mock implements UserRepository {}
class MockUser extends Mock implements User {}

class MockUserRemoteDataSource extends Mock implements UserRemoteDataSource {}
class MockNetworkInfo extends Mock implements NetworkInfo {}
class MockUserModel extends Mock implements UserModel {}

class MockGithubApi extends Mock implements GithubApi {}
class MockHttpResponse<T> extends Mock
    implements HttpResponse<T> {}

class MockResponse extends Mock implements Response<dynamic>{}
