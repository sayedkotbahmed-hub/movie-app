import 'package:flutter/material.dart';
import 'package:movie_app/core/app_exceptions.dart';
import 'package:movie_app/data/repo/movie_details_repo.dart';
import 'package:movie_app/models/movie_detail_model.dart';
import 'package:movie_app/models/movie_model.dart';

class MovieDetailProvider extends ChangeNotifier {
  final MovieDetailsRepo _repo = MovieDetailsRepo();
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
      movieDetail = await _repo.getMovieDetails(movieId);
      recommendations = await _repo.getRecommendations(movieId);
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