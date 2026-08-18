import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/core/movie_category.dart';
import 'package:movie_app/widgets/movie_card.dart';

class MovieGridView extends StatelessWidget {
  final List<MovieModel> movies;
  final MovieCategory category;
  final ScrollController controller;

  const MovieGridView({
    super.key,
    required this.movies,
    required this.category,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      controller: controller,
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 12,
        childAspectRatio: 0.62,
      ),
      itemCount: movies.length,
      itemBuilder: (context, index) {
        final movie = movies[index];
        return MovieCard(movie: movie, category: category);
      },
    );
  }
}