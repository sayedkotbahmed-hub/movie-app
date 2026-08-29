import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/movie_category.dart';
import 'package:movie_app/network/network_error_messages.dart';
import 'package:movie_app/data/repo/movies_repo.dart';
import 'package:movie_app/providers/movie_list_state.dart';

class MovieListCubit extends Cubit<MovieListState> {
  final MoviesRepo _repo = MoviesRepo();
  final MovieCategory category;

  MovieListCubit(this.category) : super(MovieListState.initial());

  Future<void> fetchMovies() async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    try {
      final movies = await _repo.getMovies(category);
      emit(state.copyWith(movies: movies, isLoading: false));
    } on NoInternetException catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.message));
    } on ServerException catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.message));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: 'An unexpected error occurred.'));
    }
  }

  Future<void> loadMoreMovies() async {
    if (state.isLoadingMore) return;

    emit(state.copyWith(isLoadingMore: true));

    try {
      final movies = await _repo.getMovies(category, loadMore: true);
      emit(state.copyWith(movies: movies, isLoadingMore: false));
    } catch (e) {
      emit(state.copyWith(isLoadingMore: false));
    }
  }
}