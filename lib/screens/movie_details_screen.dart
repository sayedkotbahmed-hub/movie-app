import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:movie_app/core/movie_category.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/providers/movie_detail_provider.dart';
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
   
    return ChangeNotifierProvider(
      create: (context) => MovieDetailProvider(movie.id)..fetchDetails(),
      child: Scaffold(
        body: Consumer<MovieDetailProvider>(
          builder: (context, provider, child) {
            if (provider.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (provider.errorMessage != null) {
              return Scaffold(
                appBar: AppBar(),
                body: ErrorView(
                  message: provider.errorMessage!,
                  onRetry: provider.fetchDetails,
                ),
              );
            }

            if (provider.movieDetail == null) {
              return const Center(
                child: Text('No details found.'),
              );
            }

            final detail = provider.movieDetail!;

            return CustomScrollView(
              slivers: [
                MovieDetailAppBar(detail: detail),

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
                          recommendations: provider.recommendations,
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
  }
}