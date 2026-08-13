import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/movie_model.dart';
import '../providers/movie_detail_provider.dart';
import '../widgets/movie_card.dart';
import '../widgets/error_view.dart';

class MovieDetailsScreen extends StatelessWidget {
  final MovieModel movie;

  const MovieDetailsScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MovieDetailProvider(movie.id)..fetchDetails(),
      child: Scaffold(
        body: Consumer<MovieDetailProvider>(
          builder: (context, provider, child) {
            if (provider.isLoading) {
              return const Center(child: CircularProgressIndicator());
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
              return const Center(child: Text('No details found.'));
            }

            final detail = provider.movieDetail!;

            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 400,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    background: detail.posterUrl != null
                        ? Image.network(detail.posterUrl!, fit: BoxFit.cover)
                        : Container(color: Colors.grey[300]),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          detail.title,
                          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.star, color: Colors.amber, size: 20),
                            const SizedBox(width: 4),
                            Text(detail.movieRate.toStringAsFixed(1)),
                            const SizedBox(width: 16),
                            if (detail.releaseDate != null)
                              Text(detail.releaseDate!),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          detail.overview,
                          style: const TextStyle(fontSize: 15, height: 1.5),
                        ),
                        const SizedBox(height: 24),
                        if (provider.recommendations.isNotEmpty) ...[
                          const Text(
                            'You Might Also Like',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 12),
                          SizedBox(
                            height: 220,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: provider.recommendations.length,
                              itemBuilder: (context, index) {
                                return SizedBox(
                                  width: 130,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 12),
                                    child: MovieCard(movie: provider.recommendations[index]),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
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