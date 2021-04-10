import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/core/error/failures.dart';
import 'package:github_search/features/user_detail/domain/usecases/get_user_detail.dart';
import 'package:github_search/features/user_detail/presentation/cubits/user_detail_cubit.dart';
import 'package:mockito/mockito.dart';

import '../../../../mocks.dart';

class MockGetUserDetails extends Mock implements GetUserDetails {}

void main() {
  MockGetUserDetails getUserDetails;

  test("initialState should be initial", () async {
    final getUserDetails = MockGetUserDetails();
    final cubit = UserDetailCubit(getUserDetails: getUserDetails);
    expect(cubit.state, UserDetailInitial());
  });

  final user = MockUser();
  const login = "the_dark_knight";

  group("-", () {
    blocTest<UserDetailCubit, UserDetailState>(
      "should emit loading and done when get details is run",
      build: () {
        getUserDetails = MockGetUserDetails();
        when(getUserDetails.call(any)).thenAnswer((_) async => Right(user));
        return UserDetailCubit(getUserDetails: getUserDetails);
      },
      act: (c) => c.getDetails(login),
      expect: <UserDetailState>[
        UserDetailLoading(),
        UserDetailLoaded(user: user),
      ],
    );

    blocTest<UserDetailCubit, UserDetailState>(
      "should emit loading and error when get details has some problem",
      build: () {
        getUserDetails = MockGetUserDetails();
        when(getUserDetails.call(any))
            .thenAnswer((_) async => Left(ServerFailure(statusCode: 404)));
        return UserDetailCubit(getUserDetails: getUserDetails);
      },
      act: (c) => c.getDetails(login),
      expect: <UserDetailState>[
        UserDetailLoading(),
        const UserDetailLoadError(message: "Falha na carga dos dados"),
      ],
    );
  });
}
