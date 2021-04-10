import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/core/error/failures.dart';
import 'package:github_search/features/user_search/domain/usecases/search_users.dart';
import 'package:github_search/features/user_search/presentation/cubits/user_search_cubit.dart';
import 'package:mockito/mockito.dart';

import '../../../../mocks.dart';

class MockSearchUsers extends Mock implements SearchUsers {}

void main() {
  MockSearchUsers searchUsers;

  test("initialState should be empty", () async {
    final searchUsers = MockSearchUsers();
    final cubit = UserSearchCubit(searchUsers: searchUsers);
    expect(cubit.state, UserSearchEmpty());
  });

  final users = [MockUser(), MockUser()];
  const query = "Batman";

  group("-", () {
    blocTest<UserSearchCubit, UserSearchState>(
      "should emit searching and done when a valid search is run",
      build: () {
        searchUsers = MockSearchUsers();
        when(searchUsers.call(any)).thenAnswer((_) async => Right(users));
        return UserSearchCubit(searchUsers: searchUsers);
      },
      act: (c) => c.search(query),
      expect: <UserSearchState>[
        UserSearching(),
        UserSearchDone(users: users),
      ],
    );

    blocTest<UserSearchCubit, UserSearchState>(
      "should emit searching and error when a search has some problem",
      build: () {
        searchUsers = MockSearchUsers();
        when(searchUsers.call(any))
            .thenAnswer((_) async => Left(ServerFailure(statusCode: 404)));
        return UserSearchCubit(searchUsers: searchUsers);
      },
      act: (c) => c.search(query),
      expect: <UserSearchState>[
        UserSearching(),
        const UserSearchError(message: "Falha na busca"),
      ],
    );
  });
}
