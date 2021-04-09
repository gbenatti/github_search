import 'package:github_search/features/user_search/domain/entities/user.dart';
import 'package:github_search/features/user_search/domain/repositories/user_repository.dart';
import 'package:mockito/mockito.dart';

class MockUserRepository extends Mock implements UserRepository {}
class MockUser extends Mock implements User {}
