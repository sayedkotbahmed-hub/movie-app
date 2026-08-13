import 'package:movie_app/core/movie_category.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/data_sources/movie_local_data_source.dart';
import 'package:movie_app/data_sources/movie_remote_data_source.dart';
import 'package:movie_app/models/movie_detail_model.dart';

class MovieRepository {
  final MovieLocalDataSource _localDataSource = MovieLocalDataSource();
  final MovieRemoteDataSource _remoteDataSource = MovieRemoteDataSource();

  final Map<MovieCategory, int> _currentPage = {};
  final Map<MovieCategory, bool> _hasReachedMax = {};

  Future<List<MovieModel>> getMovies(MovieCategory category, {bool loadMore = false}) async {
    if (!loadMore) {
      final cachedMovies = _localDataSource.getCachedMovies(category);
      if (cachedMovies != null) {
        return cachedMovies;
      }
    }

    if (_hasReachedMax[category] == true) {
      return _localDataSource.getCachedMovies(category) ?? [];
    }

    final nextPage = loadMore ? (_currentPage[category] ?? 1) + 1 : 1;

    final result = await _remoteDataSource.getMovies(category, page: nextPage);

    _currentPage[category] = nextPage;
    _hasReachedMax[category] = nextPage >= result.totalPages;
    _localDataSource.appendMovies(category, result.results);

    return _localDataSource.getCachedMovies(category) ?? [];
  }   // ← getMovies بتتقفل هنا تماماً

  Future<MovieDetailModel> getMovieDetails(int movieId) async {
    final json = await _remoteDataSource.getMovieDetails(movieId);
    return MovieDetailModel.fromJson(json);
  }   // ← فنكشن مستقلة، منفصلة تماماً

  Future<List<MovieModel>> getRecommendations(int movieId) async {
    return await _remoteDataSource.getRecommendations(movieId);
  }   // ← وكمان دي منفصلة
}