import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:github_search/core/infra/network_info.dart';
import 'package:github_search/features/common/data/data_sources/api/github_api.dart';
import 'package:github_search/features/common/data/data_sources/api/user_remote_data_source_impl.dart';
import 'package:github_search/features/common/data/data_sources/favorite_local_data_source.dart';
import 'package:github_search/features/common/data/data_sources/favorite_local_data_source_impl.dart';
import 'package:github_search/features/common/data/data_sources/user_remote_data_source.dart';
import 'package:github_search/features/common/data/repositories/favorite_repository_impl.dart';
import 'package:github_search/features/common/data/repositories/user_repository_impl.dart';
import 'package:github_search/features/common/domain/repositories/favorite_repository.dart';
import 'package:github_search/features/common/domain/repositories/user_repository.dart';
import 'package:github_search/features/user_detail/domain/usecases/get_user_detail.dart';
import 'package:github_search/features/user_detail/presentation/cubits/user_detail_cubit.dart';
import 'package:github_search/features/user_search/domain/usecases/load_favorites.dart';
import 'package:github_search/features/user_search/domain/usecases/search_users.dart';
import 'package:github_search/features/user_search/presentation/cubits/favorites_cubit.dart';
import 'package:github_search/features/user_search/presentation/cubits/user_search_cubit.dart';

final sl = GetIt.instance;

void init() {
  // Features

  // Cubits
  sl.registerFactory(() => UserSearchCubit(searchUsers: sl()));
  sl.registerFactory(() => UserDetailCubit(getUserDetails: sl()));
  sl.registerFactory(() => FavoritesCubit(loader: sl()));

  // Use cases
  sl.registerLazySingleton(() => SearchUsers(sl()));
  sl.registerLazySingleton(() => GetUserDetails(sl()));
  sl.registerLazySingleton(() => LoadFavorites(sl()));

  // Repositories
  sl.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(sl(), sl()));
  sl.registerLazySingleton<FavoriteRepository>(
      () => FavoriteRepositoryImpl(sl()));

  // Data sources
  sl.registerLazySingleton<UserRemoteDataSource>(
      () => UserRemoteDataSourceImpl(sl()));
  sl.registerLazySingleton<FavoriteLocalDataSource>(
      () => FavoriteLocalDataSourceImpl());

  // Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // External
  sl.registerLazySingleton(() => DataConnectionChecker());
  sl.registerLazySingleton<GithubApi>(() => GithubApi.client());
}
