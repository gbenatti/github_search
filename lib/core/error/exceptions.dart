class ServerException implements Exception {
  final int statusCode;

  ServerException({this.statusCode});
}

class LoadException implements Exception { }

class UpdateFavoriteException implements Exception { }
