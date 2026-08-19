import 'package:movie_app/models/movie_detail_model.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/network/network_error_handling.dart';

class MovieDetailsRemote {
  final NetworkErrorHandling _network = NetworkErrorHandling();

  Future<MovieDetailModel> getMovieDetails(int movieId) async {
    final response = await _network.get('/$movieId');
    return MovieDetailModel.fromJson(response.data);
  }

  Future<List<MovieModel>> getRecommendations(int movieId) async {
    final response = await _network.get('/$movieId/recommendations');
    final List<dynamic> moviesJson = response.data['results'];
    return moviesJson.map((json) => MovieModel.fromJson(json)).toList();
  }
}