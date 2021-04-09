import 'package:retrofit/dio.dart' show HttpResponse;

import 'search_user_result_dto.dart';

abstract class GithubApi {
  Future<HttpResponse<SearchUserResultDto>> searchUser(String query);
}

