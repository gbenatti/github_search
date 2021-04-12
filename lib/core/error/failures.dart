import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class Failure extends Equatable {
  const Failure() : super();

  @override
  List<Object> get props => const <dynamic>[];
}

class ServerFailure extends Failure {
  final int statusCode;

  ServerFailure({@required this.statusCode});

  @override
  List<Object> get props => [statusCode];
}

class NoConnectionFailure extends Failure {}

class LoadFailure extends Failure {}

class UpdateFavoriteFailure extends Failure {}
