import 'package:dio/dio.dart';
import 'package:movie_app/core/api_constants.dart';
import 'package:movie_app/core/app_exceptions.dart';
import 'package:movie_app/models/movie_detail_model.dart';
import 'package:movie_app/models/movie_model.dart';

class MovieDetailsRemote {
  final Dio _dio = Dio(
    BaseOptions(baseUrl: ApiConstants.baseUrl),
  );

  Future<MovieDetailModel> getMovieDetails(int movieId) async {
    try {
      final response = await _dio.get(
        '/$movieId',
        queryParameters: {
          'api_key': ApiConstants.apiKey,
        },
      );
      return MovieDetailModel.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<List<MovieModel>> getRecommendations(int movieId) async {
    try {
      final response = await _dio.get(
        '/$movieId/recommendations',
        queryParameters: {
          'api_key': ApiConstants.apiKey,
        },
      );
      final List<dynamic> moviesJson = response.data['results'];
      return moviesJson.map((json) => MovieModel.fromJson(json)).toList();
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