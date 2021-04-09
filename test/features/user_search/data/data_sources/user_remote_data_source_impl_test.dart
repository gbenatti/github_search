import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/core/error/exceptions.dart';
import 'package:github_search/features/user_search/data/data_sources/api/github_api.dart';
import 'package:github_search/features/user_search/data/data_sources/api/search_user_result_dto.dart';
import 'package:github_search/features/user_search/data/data_sources/api/user_dto.dart';
import 'package:github_search/features/user_search/data/data_sources/api/user_remote_data_source_impl.dart';
import 'package:github_search/features/user_search/data/data_sources/user_remote_data_source.dart';
import 'package:github_search/features/user_search/data/models/user_model.dart';
import 'package:mockito/mockito.dart';

import '../../../../mocks.dart';

void main() {
  GithubApi api;
  MockHttpResponse<SearchUserResultDto> httpResponse;
  MockResponse response;
  UserRemoteDataSource dataSource;

  setUp(() {
    api = MockGithubApi();
    httpResponse = MockHttpResponse();
    response = MockResponse();
    dataSource = UserRemoteDataSourceImpl(api);
  });

  final userDtos = [
    UserDto(id: 1, login: "ana", avatarUrl: "https://avatar/1.jpg", type: "User"),
    UserDto(id: 2, login: "joe", avatarUrl: "https://avatar/2.jpg", type: "User"),
  ];

  final userModels = [
    UserModel(id: 1, login: "ana", avatarUrl: "https://avatar/1.jpg", type: "User"),
    UserModel(id: 2, login: "joe", avatarUrl: "https://avatar/2.jpg", type: "User"),
  ];
  const query = "Bilbo";
  final searchResult = SearchUserResultDto(items: userDtos);

  test("should load data from api and convert from dto to model", () async {
    // arrange
    when(response.statusCode).thenReturn(200);
    when(httpResponse.response).thenReturn(response);
    when(httpResponse.data).thenReturn(searchResult);
    when(api.searchUser(any)).thenAnswer((_) async => httpResponse);

    // act
    final result = await dataSource.searchUsers(query);

    // assert
    expect(result, userModels);
    verify(api.searchUser(query));
    verifyNoMoreInteractions(api);
  });

  test("should throw ServerException when statusCode >=300", () async {
    // arrange
    when(response.statusCode).thenReturn(300);
    when(httpResponse.response).thenReturn(response);
    when(httpResponse.data).thenReturn(searchResult);
    when(api.searchUser(any)).thenAnswer((_) async => httpResponse);

    // act
    final call = dataSource.searchUsers;

    // assert
    expect(() => call(query), throwsA(isA<ServerException>()));
    verify(api.searchUser(query));
    verifyNoMoreInteractions(api);
  });
}
