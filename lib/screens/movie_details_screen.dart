import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/movie_category.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/providers/movie_detail_cubit.dart';
import 'package:movie_app/providers/movie_detail_state.dart';
import 'package:movie_app/widgets/error_view.dart';
import 'package:movie_app/widgets/movie_detail_app_bar.dart';
import 'package:movie_app/widgets/movie_detail_header.dart';
import 'package:movie_app/widgets/movie_recommendations_list.dart';

class MovieDetailsScreen extends StatelessWidget {
  final MovieModel movie;
  final MovieCategory? category;

  const MovieDetailsScreen({
    super.key,
    required this.movie,
    this.category,
  });

  @override
Widget build(BuildContext context) {
  final themeColor = category?.color ?? Colors.grey;

  return BlocProvider(
    create: (context) => MovieDetailCubit(movie.id)..fetchDetails(),
    child: Scaffold(
      backgroundColor: themeColor,
      body:BlocBuilder<MovieDetailCubit, MovieDetailState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state.errorMessage != null) {
            return Scaffold(
              backgroundColor: themeColor,
              appBar: AppBar(backgroundColor: themeColor),
              body: ErrorView(
                message: state.errorMessage!,
                onRetry: () => context.read<MovieDetailCubit>().fetchDetails(),
              ),
            );
          }

          if (state.movieDetail == null) {
            return const Center(
              child: Text('No details found.'),
            );
          }

          final detail = state.movieDetail!;

          return CustomScrollView(
            slivers: [
              MovieDetailAppBar(detail: detail, themeColor: themeColor),

              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MovieDetailHeader(detail: detail),

                      const SizedBox(height: 16),

                      Text(
                        detail.overview,
                        style: const TextStyle(
                          fontSize: 15,
                          height: 1.5,
                        ),
                      ),

                      const SizedBox(height: 24),

                      MovieRecommendationsList(
                        recommendations: state.recommendations,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    ),
  );
}}