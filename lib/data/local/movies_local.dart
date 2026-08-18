import 'package:movie_app/core/movie_category.dart';
import 'package:movie_app/models/movie_model.dart';

class MoviesLocal {
  final Map<MovieCategory, List<MovieModel>> _cache = {};

  List<MovieModel>? getCachedMovies(MovieCategory category) {
    return _cache[category];
  }

  void appendMovies(MovieCategory category, List<MovieModel> newMovies) {
    final existing = _cache[category] ?? [];
    _cache[category] = [...existing, ...newMovies];
  }
}