import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_detail_model.dart';

class MovieDetailHeader extends StatelessWidget {
  final MovieDetailModel detail;

  const MovieDetailHeader({super.key, required this.detail});

  @override
  Widget build(BuildContext context) {
    return Column(
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
      ],
    );
  }
}