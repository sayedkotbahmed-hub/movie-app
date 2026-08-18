import 'package:dio/dio.dart';
import 'package:movie_app/core/api_constants.dart';
import 'package:movie_app/core/app_exceptions.dart';
import 'package:movie_app/core/movie_category.dart';
import 'package:movie_app/models/movie_list_response.dart';

class MoviesRemote {
  final Dio _dio = Dio(
    BaseOptions(baseUrl: ApiConstants.baseUrl),
  );

  Future<MovieListResponse> getMovies(MovieCategory category, {int page = 1}) async {
    try {
      final response = await _dio.get(
        category.endpoint,
        queryParameters: {
          'api_key': ApiConstants.apiKey,
          'page': page,
        },
      );
      return MovieListResponse.fromJson(response.data);
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