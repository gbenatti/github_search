part of 'user_search_cubit.dart';

abstract class UserSearchState extends Equatable {
  const UserSearchState();

  @override
  List<Object> get props => [];
}

class UserSearchEmpty extends UserSearchState {}
class UserSearching extends UserSearchState {}

class UserSearchDone extends UserSearchState {
  final List<User> users;

  const UserSearchDone({@required this.users});

  @override
  List<Object> get props => [users];
}

class UserSearchError extends UserSearchState {
  final String message;
 
 const UserSearchError({@required this.message});

  @override
  List<Object> get props => [message];
}
