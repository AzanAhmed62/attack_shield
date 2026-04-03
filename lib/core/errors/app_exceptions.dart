abstract class AppException implements Exception {
  final String message;
  final String? code;

  AppException({required this.message, this.code});

  @override
  String toString() => 'AppException: $message';
}

class CacheException extends AppException {
  CacheException({required super.message, super.code});
}

class DataException extends AppException {
  DataException({required super.message, super.code});
}

class NetworkException extends AppException {
  NetworkException({required super.message, super.code});
}

class ValidationException extends AppException {
  ValidationException({required super.message, super.code});
}

class UnknownException extends AppException {
  UnknownException({required super.message, super.code});
}
