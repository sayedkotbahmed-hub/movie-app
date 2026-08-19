import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:movie_app/core/movie_category.dart';
import 'package:movie_app/providers/movie_list_provider.dart';
import 'package:movie_app/screens/movie_list_screen.dart';

class HomePageView extends StatelessWidget {
  final PageController controller;
  final List<MovieCategory> categories;
  final List<MovieListProvider> providers;
  final ValueChanged<int> onPageChanged;

  const HomePageView({
    super.key,
    required this.controller,
    required this.categories,
    required this.providers,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: controller,
      onPageChanged: onPageChanged,
      children: List.generate(categories.length, (index) {
        return ChangeNotifierProvider.value(
          value: providers[index],
          child: MovieListScreen(category: categories[index]),
        );
      }),
    );
  }
}