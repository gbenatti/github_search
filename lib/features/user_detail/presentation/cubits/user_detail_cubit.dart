import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:github_search/core/error/failures.dart';
import 'package:github_search/features/common/domain/entities/user.dart';
import 'package:github_search/features/user_detail/domain/usecases/get_user_detail.dart';

part 'user_detail_state.dart';

class UserDetailCubit extends Cubit<UserDetailState> {
  UserDetailCubit({@required this.getUserDetails}) : super(UserDetailInitial());

  final GetUserDetails getUserDetails;

  void getDetails(String login) async {
    emit(UserDetailLoading());
    final result = await getUserDetails(Params(login: login));
    result.fold(
      (failure) => emit(UserDetailLoadError(message: _errorMessage(failure))),
      (user) => emit(UserDetailLoaded(user: user)),
    );
  }

  String _errorMessage(Failure failure) {
    return "Falha na carga dos dados";
  }
}
