import 'package:movie_app/core/movie_category.dart';
import 'package:movie_app/data/local/movies_local.dart';
import 'package:movie_app/data/remote/movies_remote.dart';
import 'package:movie_app/models/movie_model.dart';

class MoviesRepo {
  final MoviesLocal _local = MoviesLocal();
  final MoviesRemote _remote = MoviesRemote();

  final Map<MovieCategory, int> _currentPage = {};
  final Map<MovieCategory, bool> _hasReachedMax = {};

  Future<List<MovieModel>> getMovies(MovieCategory category, {bool loadMore = false}) async {
    if (!loadMore) {
      final cachedMovies = _local.getCachedMovies(category);
      if (cachedMovies != null) {
        return cachedMovies;
      }
    }

    if (_hasReachedMax[category] == true) {
      return _local.getCachedMovies(category) ?? [];
    }

    final nextPage = loadMore ? (_currentPage[category] ?? 1) + 1 : 1;

    final result = await _remote.getMovies(category, page: nextPage);

    _currentPage[category] = nextPage;
    _hasReachedMax[category] = nextPage >= result.totalPages;
    _local.appendMovies(category, result.results);

    return _local.getCachedMovies(category) ?? [];
  }
}