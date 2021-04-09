import 'package:github_search/core/infra/network_info.dart';
import 'package:github_search/features/user_search/data/data_sources/user_remote_data_source.dart';
import 'package:github_search/features/user_search/data/models/user_model.dart';
import 'package:github_search/features/user_search/domain/entities/user.dart';
import 'package:github_search/features/user_search/domain/repositories/user_repository.dart';
import 'package:mockito/mockito.dart';

class MockUserRepository extends Mock implements UserRepository {}
class MockUser extends Mock implements User {}

class MockUserRemoteDataSource extends Mock implements UserRemoteDataSource {}
class MockNetworkInfo extends Mock implements NetworkInfo {}
class MockUserModel extends Mock implements UserModel {}
