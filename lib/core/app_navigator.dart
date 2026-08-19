import 'package:flutter/material.dart';
import 'package:movie_app/core/movie_category.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/screens/movie_details_screen.dart';

class AppNavigator {
 static void toMovieDetails(BuildContext context, MovieModel movie, MovieCategory? category) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => MovieDetailsScreen(movie: movie, category: category),
    ),
  );
}

  static void animateToTab(PageController controller, int index) {
    controller.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
}