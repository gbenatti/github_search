import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'user_detail_state.dart';

class UserDetailCubit extends Cubit<UserDetailState> {
  UserDetailCubit() : super(UserDetailInitial());
}
