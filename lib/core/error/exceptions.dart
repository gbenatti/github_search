class ServerException implements Exception {
  final int statusCode;

  ServerException({this.statusCode});
}
