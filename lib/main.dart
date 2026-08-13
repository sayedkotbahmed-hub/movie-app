import 'package:flutter/material.dart';
import 'package:movie_app/widgets/widget_screen.dart';
import 'package:provider/provider.dart';

import 'package:movie_app/providers/movie_list_provider.dart';
import 'package:movie_app/core/movie_category.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MovieListProvider(MovieCategory.topRated),
      child: MaterialApp(
        home: const WidgetScreen(),
      ),
    );
  }
}