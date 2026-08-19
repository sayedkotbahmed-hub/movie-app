import 'package:dio/dio.dart';
import 'package:movie_app/core/api_constants.dart';

class NetworkService {
  final Dio _dio = Dio(
    BaseOptions(baseUrl: ApiConstants.baseUrl),
  );

  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) {
    return _dio.get(
      path,
      queryParameters: _withApiKey(queryParameters),
    );
  }

  Future<Response> post(String path, {dynamic data, Map<String, dynamic>? queryParameters}) {
    return _dio.post(
      path,
      data: data,
      queryParameters: _withApiKey(queryParameters),
    );
  }

  Future<Response> put(String path, {dynamic data, Map<String, dynamic>? queryParameters}) {
    return _dio.put(
      path,
      data: data,
      queryParameters: _withApiKey(queryParameters),
    );
  }

  Future<Response> delete(String path, {dynamic data, Map<String, dynamic>? queryParameters}) {
    return _dio.delete(
      path,
      data: data,
      queryParameters: _withApiKey(queryParameters),
    );
  }

  Map<String, dynamic> _withApiKey(Map<String, dynamic>? queryParameters) {
    return {
      'api_key': ApiConstants.apiKey,
      ...?queryParameters,
    };
  }
}