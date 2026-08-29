import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/movie_category.dart';
import 'package:movie_app/providers/movie_list_cubit.dart';
import 'package:movie_app/screens/movie_list_screen.dart';

class HomePageView extends StatelessWidget {
  final PageController controller;
  final List<MovieCategory> categories;
  final List<MovieListCubit> cubits ;
  final ValueChanged<int> onPageChanged;

  const HomePageView({
    super.key,
    required this.controller,
    required this.categories,
    required this.cubits,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: controller,
      onPageChanged: onPageChanged,
      children: List.generate(categories.length, (index) {
        return BlocProvider.value(
          value: cubits[index],
          child: MovieListScreen(category: categories[index]),
        );
      }),
    );
  }
}