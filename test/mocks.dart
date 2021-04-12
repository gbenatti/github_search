import 'package:github_search/core/infra/network_info.dart';
import 'package:github_search/features/common/data/data_sources/api/github_api.dart';
import 'package:github_search/features/common/data/data_sources/favorite_local_data_source.dart';
import 'package:github_search/features/common/data/data_sources/user_remote_data_source.dart';
import 'package:github_search/features/common/data/models/user_model.dart';
import 'package:github_search/features/common/domain/entities/user.dart';
import 'package:github_search/features/common/domain/repositories/favorite_repository.dart';
import 'package:github_search/features/common/domain/repositories/user_repository.dart';
import 'package:mockito/mockito.dart';
import 'package:retrofit/dio.dart';
import 'package:dio/dio.dart' show Response;

class MockUserRepository extends Mock implements UserRepository {}
// ignore: must_be_immutable
class MockUser extends Mock implements User {}

class MockUserRemoteDataSource extends Mock implements UserRemoteDataSource {}
class MockNetworkInfo extends Mock implements NetworkInfo {}
// ignore: must_be_immutable
class MockUserModel extends Mock implements UserModel {}

class MockGithubApi extends Mock implements GithubApi {}
class MockHttpResponse<T> extends Mock
    implements HttpResponse<T> {}

class MockResponse extends Mock implements Response<dynamic>{}

class MockFavoriteRepository extends Mock implements FavoriteRepository {}
class MockFavoriteLocalDataSource extends Mock implements FavoriteLocalDataSource {}
