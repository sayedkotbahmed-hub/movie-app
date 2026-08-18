import 'package:movie_app/data/local/movie_details_local.dart';
import 'package:movie_app/data/remote/movie_details_remote.dart';
import 'package:movie_app/models/movie_detail_model.dart';
import 'package:movie_app/models/movie_model.dart';

class MovieDetailsRepo {
  final MovieDetailsLocal _local = MovieDetailsLocal();
  final MovieDetailsRemote _remote = MovieDetailsRemote();

  Future<MovieDetailModel> getMovieDetails(int movieId) async {
    final cached = _local.getCachedDetails(movieId);
    if (cached != null) {
      return cached;
    }

    final detail = await _remote.getMovieDetails(movieId);
    _local.cacheDetails(movieId, detail);
    return detail;
  }

  Future<List<MovieModel>> getRecommendations(int movieId) async {
    return await _remote.getRecommendations(movieId);
  }
}