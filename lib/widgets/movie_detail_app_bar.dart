import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_detail_model.dart';

class MovieDetailAppBar extends StatelessWidget {
  final MovieDetailModel detail;
  final Color themeColor;

  const MovieDetailAppBar({
    super.key,
    required this.detail,
    required this.themeColor,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: themeColor,
      expandedHeight: 400,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: detail.posterUrl != null
            ? Image.network(detail.posterUrl!, fit: BoxFit.cover)
            : Container(color: Colors.grey[300]),
      ),
    );
  }
}