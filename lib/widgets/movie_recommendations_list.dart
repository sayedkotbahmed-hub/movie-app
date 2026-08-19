import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/widgets/movie_card.dart';

class MovieRecommendationsList extends StatelessWidget {
  final List<MovieModel> recommendations;

  const MovieRecommendationsList({super.key, required this.recommendations});

  @override
  Widget build(BuildContext context) {
    if (recommendations.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'You Might Also Like',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 220,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: recommendations.length,
            itemBuilder: (context, index) {
              return SizedBox(
                width: 130,
                child: Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: MovieCard(movie: recommendations[index], category: null),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}