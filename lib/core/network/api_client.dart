import 'package:dio/dio.dart';
import 'network_exceptions.dart';

class ApiClient {
  final Dio dio;

  ApiClient(this.dio);

  Future<dynamic> get(String path, {Map<String, dynamic>? queryParameters}) async {
    try {
      final resp = await dio.get(path, queryParameters: queryParameters);
      _checkResponse(resp);
      return resp.data;
    } on DioException catch (e) {
      throw _mapDioError(e);
    }
  }

  Future<dynamic> post(String path, {dynamic data}) async {
    try {
      final resp = await dio.post(path, data: data);
      _checkResponse(resp);
      return resp.data;
    } on DioException catch (e) {
      throw _mapDioError(e);
    }
  }

  Future<dynamic> put(String path, {dynamic data}) async {
    try {
      final resp = await dio.put(path, data: data);
      _checkResponse(resp);
      return resp.data;
    } on DioException catch (e) {
      throw _mapDioError(e);
    }
  }

  Future<void> delete(String path) async {
    try {
      final resp = await dio.delete(path);
      _checkResponse(resp);
    } on DioException catch (e) {
      throw _mapDioError(e);
    }
  }

  void _checkResponse(Response resp) {
    final code = resp.statusCode ?? 0;
    if (code >= 200 && code < 300) return;

    final message = resp.statusMessage ?? resp.data?.toString() ?? 'Unknown error';

    switch (code) {
      case 400:
        throw BadRequestException(message);
      case 401:
      case 403:
        throw UnauthorizedException(message);
      case 404:
        throw NotFoundException(message);
      case 500:
      case 501:
      case 502:
      case 503:
        throw ServerException(code, message);
      default:
        throw ApiException(code, message);
    }
  }

  ApiException _mapDioError(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.sendTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      return RequestTimeoutException(e.message ?? 'Request timed out');
    }

    if (e.type == DioExceptionType.badResponse) {
      final status = e.response?.statusCode;
      final msg = e.response?.statusMessage ?? e.message ?? 'Bad response';
      return ApiException(status, msg);
    }

    // Network-level errors (DNS, socket)
    if (e.error != null && e.error is Exception) {
      final err = e.error as Exception;
      final errStr = err.toString();
      if (errStr.contains('SocketException')) {
        return NoConnectionException();
      }
    }

    return ApiException(null, e.message ?? 'Unknown error');
  }
}
