import 'package:flutter/material.dart';
import 'package:movie_app/core/app_exceptions.dart';
import 'package:movie_app/models/movie_detail_model.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/repositories/movie_repository.dart';

class MovieDetailProvider extends ChangeNotifier {
  final MovieRepository _repository = MovieRepository();
  final int movieId;

  MovieDetailProvider(this.movieId);

  MovieDetailModel? movieDetail;
  List<MovieModel> recommendations = [];
  bool isLoading = false;
  String? errorMessage;

  Future<void> fetchDetails() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      movieDetail = await _repository.getMovieDetails(movieId);
      recommendations = await _repository.getRecommendations(movieId);
    } on NoInternetException catch (e) {
      errorMessage = e.message;
    } on ServerException catch (e) {
      errorMessage = e.message;
    } on NotFoundException catch (e) {
      errorMessage = e.message;
    } catch (e) {
      errorMessage = 'An unexpected error occurred.';
    }

    isLoading = false;
    notifyListeners();
  }
}