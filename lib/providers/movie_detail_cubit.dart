import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/network/network_error_messages.dart';
import 'package:movie_app/data/repo/movie_details_repo.dart';
import 'package:movie_app/providers/movie_detail_state.dart';

class MovieDetailCubit extends Cubit<MovieDetailState> {
  final MovieDetailsRepo _repo = MovieDetailsRepo();
  final int movieId;

  MovieDetailCubit(this.movieId) : super(MovieDetailState.initial());

  Future<void> fetchDetails() async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    try {
      final detail = await _repo.getMovieDetails(movieId);
      final recommendations = await _repo.getRecommendations(movieId);
      emit(state.copyWith(
        movieDetail: detail,
        recommendations: recommendations,
        isLoading: false,
      ));
    } on NoInternetException catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.message));
    } on ServerException catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.message));
    } on NotFoundException catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.message));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: 'An unexpected error occurred.'));
    }
  }
}