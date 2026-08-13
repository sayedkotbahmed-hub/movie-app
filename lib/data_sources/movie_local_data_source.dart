import '../core/movie_category.dart';
import '../models/movie_model.dart';

class MovieLocalDataSource {
  final Map<MovieCategory, List<MovieModel>> _cache = {};

  List<MovieModel>? getCachedMovies(MovieCategory category) {
    return _cache[category];
  }

  void appendMovies(MovieCategory category, List<MovieModel> newMovies) {
    final existing = _cache[category] ?? [];
    _cache[category] = [...existing, ...newMovies];
  }
}