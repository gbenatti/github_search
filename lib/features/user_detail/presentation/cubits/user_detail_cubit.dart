import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:github_search/features/common/domain/entities/user.dart';

part 'user_detail_state.dart';

class UserDetailCubit extends Cubit<UserDetailState> {
  UserDetailCubit() : super(UserDetailInitial());
}
