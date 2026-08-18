import 'package:dio/dio.dart';
import 'package:movie_app/core/app_exceptions.dart';
import 'package:movie_app/network/network_service.dart';

class NetworkErrorHandling  {
  final NetworkService _service = NetworkService();

  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) async {
    try {
      return await _service.get(path, queryParameters: queryParameters);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<Response> post(String path, {dynamic data, Map<String, dynamic>? queryParameters}) async {
    try {
      return await _service.post(path, data: data, queryParameters: queryParameters);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<Response> put(String path, {dynamic data, Map<String, dynamic>? queryParameters}) async {
    try {
      return await _service.put(path, data: data, queryParameters: queryParameters);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<Response> delete(String path, {dynamic data, Map<String, dynamic>? queryParameters}) async {
    try {
      return await _service.delete(path, data: data, queryParameters: queryParameters);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Exception _handleDioError(DioException e) {
    if (e.type == DioExceptionType.connectionError ||
        e.type == DioExceptionType.connectionTimeout) {
      return NoInternetException();
    }
    if (e.response?.statusCode == 404) {
      return NotFoundException();
    }
    if (e.response != null && e.response!.statusCode! >= 500) {
      return ServerException();
    }
    return UnknownException();
  }
}