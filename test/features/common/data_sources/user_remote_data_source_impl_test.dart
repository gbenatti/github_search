import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/core/error/exceptions.dart';
import 'package:github_search/features/common/data/data_sources/api/github_api.dart';
import 'package:github_search/features/common/data/data_sources/api/search_user_result_dto.dart';
import 'package:github_search/features/common/data/data_sources/api/user_dto.dart';
import 'package:github_search/features/common/data/data_sources/api/user_remote_data_source_impl.dart';
import 'package:github_search/features/common/data/data_sources/user_remote_data_source.dart';
import 'package:github_search/features/common/data/models/user_model.dart';
import 'package:mockito/mockito.dart';

import '../../../mocks.dart';

void main() {
  GithubApi api;
  MockHttpResponse<SearchUserResultDto> searchResultHttpResponse;
  MockHttpResponse<UserDto> getUserHttpResponse;
  MockResponse response;
  UserRemoteDataSource dataSource;

  setUp(() {
    api = MockGithubApi();
    searchResultHttpResponse = MockHttpResponse();
    getUserHttpResponse = MockHttpResponse();
    response = MockResponse();
    dataSource = UserRemoteDataSourceImpl(api);
  });

  final userDtos = [
    UserDto(
        id: 1,
        login: "ana",
        avatarUrl: "https://avatar/1.jpg",
        htmlUrl: "https://html/1.html",
        type: "User"),
    UserDto(
        id: 2,
        login: "joe",
        avatarUrl: "https://avatar/2.jpg",
        htmlUrl: "https://html/2.html",
        type: "User"),
  ];

  final userModels = [
    UserModel(
        id: 1,
        login: "ana",
        avatarUrl: "https://avatar/1.jpg",
        htmlUrl: "https://html/1.html",
        type: "User"),
    UserModel(
        id: 2,
        login: "joe",
        avatarUrl: "https://avatar/2.jpg",
        htmlUrl: "https://html/2.html",
        type: "User"),
  ];
  const query = "Bilbo";
  final searchResult = SearchUserResultDto(items: userDtos);

  const login = "the_white";

  final gandalfDto = UserDto(
      id: 3,
      login: login,
      avatarUrl: "https://avatar/3.jpg",
      htmlUrl: "https://html/3.html",
      type: "User",
      name: "Gandalf",
      company: "Mages S/A",
      bio: "Reborn from the ashes",
      location: "Middle Earth",
      email: "gandalf@middle.earth.com");

  final gandalfModel = UserModel(
      id: 3,
      login: login,
      avatarUrl: "https://avatar/3.jpg",
      htmlUrl: "https://html/3.html",
      type: "User",
      name: "Gandalf",
      company: "Mages S/A",
      bio: "Reborn from the ashes",
      location: "Middle Earth",
      email: "gandalf@middle.earth.com");

  group("search users", () {
    test("should load data from api and convert from dto to model", () async {
      // arrange
      when(response.statusCode).thenReturn(200);
      when(searchResultHttpResponse.response).thenReturn(response);
      when(searchResultHttpResponse.data).thenReturn(searchResult);
      when(api.searchUser(any)).thenAnswer((_) async => searchResultHttpResponse);

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
      when(searchResultHttpResponse.response).thenReturn(response);
      when(searchResultHttpResponse.data).thenReturn(searchResult);
      when(api.searchUser(any)).thenAnswer((_) async => searchResultHttpResponse);

      // act
      final call = dataSource.searchUsers;

      // assert
      expect(() => call(query), throwsA(isA<ServerException>()));
      verify(api.searchUser(query));
      verifyNoMoreInteractions(api);
    });
  });

  group("get user details", () {
    test("should load data from api and convert from dto to model", () async {
      // arrange
      when(response.statusCode).thenReturn(200);
      when(getUserHttpResponse.response).thenReturn(response);
      when(getUserHttpResponse.data).thenReturn(gandalfDto);
      when(api.getUser(any)).thenAnswer((_) async => getUserHttpResponse);

      // act
      final result = await dataSource.getUserDetails(login);

      // assert
      expect(result, gandalfModel);
      verify(api.getUser(login));
      verifyNoMoreInteractions(api);
    });

    test("should throw ServerException when statusCode >=300", () async {
      // arrange
      when(response.statusCode).thenReturn(300);
      when(getUserHttpResponse.response).thenReturn(response);
      when(getUserHttpResponse.data).thenReturn(gandalfDto);
      when(api.getUser(any)).thenAnswer((_) async => getUserHttpResponse);

      // act
      final call = dataSource.getUserDetails;

      // assert
      expect(() => call(login), throwsA(isA<ServerException>()));
      verify(api.getUser(login));
      verifyNoMoreInteractions(api);
    });
  });
}
