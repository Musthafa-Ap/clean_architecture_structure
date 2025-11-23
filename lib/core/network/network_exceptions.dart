class ApiException implements Exception {
  final int? statusCode;
  final String message;

  ApiException([this.statusCode, this.message = 'An unknown error occurred']);

  @override
  String toString() => 'ApiException: $statusCode - $message';
}

class BadRequestException extends ApiException {
  BadRequestException([String message = 'Bad request']) : super(400, message);
}

class UnauthorizedException extends ApiException {
  UnauthorizedException([String message = 'Unauthorized']) : super(401, message);
}

class NotFoundException extends ApiException {
  NotFoundException([String message = 'Resource not found']) : super(404, message);
}

class ServerException extends ApiException {
  ServerException([int? statusCode, String message = 'Server error']) : super(statusCode, message);
}

class NoConnectionException extends ApiException {
  NoConnectionException([String message = 'No internet connection']) : super(null, message);
}

class RequestTimeoutException extends ApiException {
  RequestTimeoutException([String message = 'Request timed out']) : super(null, message);
}
