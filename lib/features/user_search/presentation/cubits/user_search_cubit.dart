import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:github_search/core/error/failures.dart';
import 'package:github_search/features/common/domain/entities/user.dart';
import 'package:github_search/features/user_search/domain/usecases/search_users.dart';

part 'user_search_state.dart';

class UserSearchCubit extends Cubit<UserSearchState> {
  final SearchUsers searchUsers;

  UserSearchCubit({this.searchUsers}) : super(UserSearchEmpty());

  Future<void> search(String username) async {
    emit(UserSearching());
    final result = await searchUsers(Params(query: username));
    result.fold(
      (l) => emit(UserSearchError(message: errorMessage(l))),
      (r) => emit(UserSearchDone(users: r)),
    );
  }

  String errorMessage(Failure failure) {
    return "Falha na busca";
  }
}
