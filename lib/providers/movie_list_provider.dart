import 'package:flutter/material.dart';
import 'package:movie_app/core/movie_category.dart';
import 'package:movie_app/network/network_error_messages.dart';
import 'package:movie_app/data/repo/movies_repo.dart';
import 'package:movie_app/models/movie_model.dart';

class MovieListProvider extends ChangeNotifier {
  final MoviesRepo _repo = MoviesRepo();
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
      movies = await _repo.getMovies(category);
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
      movies = await _repo.getMovies(category, loadMore: true);
    } catch (e) {
      // فشل تحميل صفحة إضافية مش لازم يمسح الأفلام الموجودة أصلاً
    }

    isLoadingMore = false;
    notifyListeners();
  }
}