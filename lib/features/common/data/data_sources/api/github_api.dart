import 'package:dio/dio.dart' show Dio, RequestOptions;
import 'package:github_search/features/common/data/data_sources/api/user_dto.dart';
import 'package:retrofit/dio.dart' show HttpResponse;
import 'package:retrofit/http.dart' show GET, Query, Path, RestApi;

import 'search_user_result_dto.dart';

part 'github_api.g.dart';

@RestApi(baseUrl: "https://api.github.com")
abstract class GithubApi {
  factory GithubApi(Dio dio, {String baseUrl}) = _GithubApi;

  factory GithubApi.client({String baseUrl}) {
    final dio = Dio();
    dio.options.headers["Accept"] = "application/vnd.github.v3.text-match+json";

    return GithubApi(dio, baseUrl: baseUrl);
  }

  @GET("/search/users")
  Future<HttpResponse<SearchUserResultDto>> searchUser(@Query("q") String query);

  @GET("/users/{username}")
  Future<HttpResponse<UserDto>> getUser(@Path("username") String username);
}

