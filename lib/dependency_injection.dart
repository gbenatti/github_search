import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:github_search/core/infra/network_info.dart';
import 'package:github_search/features/user_search/data/data_sources/api/github_api.dart';
import 'package:github_search/features/user_search/data/data_sources/api/user_remote_data_source_impl.dart';
import 'package:github_search/features/user_search/data/data_sources/user_remote_data_source.dart';
import 'package:github_search/features/user_search/data/repositories/user_repository_impl.dart';
import 'package:github_search/features/user_search/domain/repositories/user_repository.dart';
import 'package:github_search/features/user_search/domain/usecases/search_users.dart';
import 'package:github_search/features/user_search/presentation/cubits/user_search_cubit.dart';

final sl = GetIt.instance;

void init() {
  // Features - MovieList

  // Cubits
  sl.registerFactory(() => UserSearchCubit(searchUsers: sl()));

  // Use cases
  sl.registerLazySingleton(() => SearchUsers(sl()));

  // Repositories
  sl.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(sl(), sl()));

  // Data sources
  sl.registerLazySingleton<UserRemoteDataSource>(
      () => UserRemoteDataSourceImpl(sl()));

  // Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // External
  sl.registerLazySingleton(() => DataConnectionChecker());
  sl.registerLazySingleton<GithubApi>(() => GithubApi.client());
}
