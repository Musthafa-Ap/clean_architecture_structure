import 'package:dio/dio.dart';

/// Centralized Dio client class to configure interceptors, headers and options.
class DioClient {
  final Dio dio;

  DioClient._internal(this.dio);

  /// Create a configured DioClient.
  factory DioClient({String baseUrl = 'https://mock.api', List<Interceptor>? interceptors}) {
    final dio = Dio(BaseOptions(baseUrl: baseUrl));

    // Default logging interceptor for development. Replace/extend in production.
    dio.interceptors.add(LogInterceptor(
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
      error: true,
    ));

    // Add any additional interceptors provided by caller
    if (interceptors != null) {
      dio.interceptors.addAll(interceptors);
    }

    return DioClient._internal(dio);
  }

  /// Helper to set a global header, e.g. Authorization token.
  void setHeader(String name, String value) {
    dio.options.headers[name] = value;
  }

  /// Helper to remove a header.
  void removeHeader(String name) {
    dio.options.headers.remove(name);
  }

  /// Expose the underlying Dio instance when needed.
  Dio get client => dio;
}
