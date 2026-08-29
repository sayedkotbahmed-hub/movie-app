import 'package:movie_app/models/movie_detail_model.dart';
import 'package:movie_app/models/movie_model.dart';

class MovieDetailState {
  final MovieDetailModel? movieDetail;
  final List<MovieModel> recommendations;
  final bool isLoading;
  final String? errorMessage;

  const MovieDetailState({
    required this.movieDetail,
    required this.recommendations,
    required this.isLoading,
    this.errorMessage,
  });

  factory MovieDetailState.initial() {
    return const MovieDetailState(
      movieDetail: null,
      recommendations: [],
      isLoading: false,
    );
  }

  MovieDetailState copyWith({
    MovieDetailModel? movieDetail,
    List<MovieModel>? recommendations,
    bool? isLoading,
    String? errorMessage,
  }) {
    return MovieDetailState(
      movieDetail: movieDetail ?? this.movieDetail,
      recommendations: recommendations ?? this.recommendations,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}