import 'package:movie_app/models/movie_model.dart';

class MovieListState {
  final List<MovieModel> movies;
  final bool isLoading;
  final bool isLoadingMore;
  final String? errorMessage;

  const MovieListState({
    required this.movies,
    required this.isLoading,
    required this.isLoadingMore,
    this.errorMessage,
  });

  factory MovieListState.initial() {
    return const MovieListState(
      movies: [],
      isLoading: false,
      isLoadingMore: false,
    );
  }

  MovieListState copyWith({
    List<MovieModel>? movies,
    bool? isLoading,
    bool? isLoadingMore,
    String? errorMessage,
  }) {
    return MovieListState(
      movies: movies ?? this.movies,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      errorMessage: errorMessage,
    );
  }
}