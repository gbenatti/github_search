import 'package:dio/dio.dart' show Dio, RequestOptions;
import 'package:retrofit/dio.dart' show HttpResponse;
import 'package:retrofit/http.dart' show GET, Query, RestApi;

import 'search_user_result_dto.dart';

part 'github_api.g.dart';

@RestApi(baseUrl: "https://api.github.com/search/users")
abstract class GithubApi {
  factory GithubApi(Dio dio, {String baseUrl}) = _GithubApi;

  factory GithubApi.client({String baseUrl}) {
    final dio = Dio();
    dio.options.headers["Content-Type"] = "application/json";
    dio.options.headers["Accept"] = "application/vnd.github.v3+json";

    return GithubApi(dio, baseUrl: baseUrl);
  }

  @GET("search/movie")
  Future<HttpResponse<SearchUserResultDto>> searchUser(@Query("q") String query);
}

