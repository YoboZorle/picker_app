class InvalidAuthentication implements Exception {}

class ServiceError implements Exception {
  final message;
  ServiceError(this.message);
}

class NotFoundError implements Exception {}
