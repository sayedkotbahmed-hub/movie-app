import 'package:movie_app/models/movie_detail_model.dart';

class MovieDetailsLocal {
  final Map<int, MovieDetailModel> _cache = {};

  MovieDetailModel? getCachedDetails(int movieId) {
    return _cache[movieId];
  }

  void cacheDetails(int movieId, MovieDetailModel detail) {
    _cache[movieId] = detail;
  }
}