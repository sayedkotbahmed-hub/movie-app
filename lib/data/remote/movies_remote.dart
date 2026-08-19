import 'package:movie_app/core/movie_category.dart';
import 'package:movie_app/models/movie_list_response.dart';
import 'package:movie_app/network/network_error_handling.dart';

class MoviesRemote {
  final NetworkErrorHandling _network = NetworkErrorHandling();

  Future<MovieListResponse> getMovies(MovieCategory category, {int page = 1}) async {
    final response = await _network.get(
      category.endpoint,
      queryParameters: {
        'page': page,
      },
    );
    return MovieListResponse.fromJson(response.data);
  }
}