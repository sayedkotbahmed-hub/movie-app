import 'package:flutter/material.dart';
import '../core/movie_category.dart';
import '../core/app_exceptions.dart';
import '../models/movie_model.dart';
import '../repositories/movie_repository.dart';

class MovieListProvider extends ChangeNotifier {
  final MovieRepository _repository = MovieRepository();
  final MovieCategory category;

  MovieListProvider(this.category);

  List<MovieModel> movies = [];
  bool isLoading = false;
  bool isLoadingMore = false;
  String? errorMessage;

  Future<void> fetchMovies() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      movies = await _repository.getMovies(category);
    } on NoInternetException catch (e) {
      errorMessage = e.message;
    } on ServerException catch (e) {
      errorMessage = e.message;
    } catch (e) {
      errorMessage = 'An unexpected error occurred.';
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> loadMoreMovies() async {
    if (isLoadingMore) return;

    isLoadingMore = true;
    notifyListeners();

    try {
      movies = await _repository.getMovies(category, loadMore: true);
    } catch (e) {
    }

    isLoadingMore = false;
    notifyListeners();
  }
}