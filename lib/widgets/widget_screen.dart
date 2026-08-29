import 'package:flutter/material.dart';
import 'package:movie_app/core/movie_category.dart';
import 'package:movie_app/core/app_navigator.dart';
import 'package:movie_app/providers/movie_list_cubit.dart';
import 'package:movie_app/widgets/home_app_bar.dart';
import 'package:movie_app/widgets/home_bottom_nav_bar.dart';
import 'package:movie_app/widgets/home_page_view.dart';

class WidgetScreen extends StatefulWidget {
  const WidgetScreen({super.key});

  @override
  State<WidgetScreen> createState() => _WidgetScreenState();
}

class _WidgetScreenState extends State<WidgetScreen> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  final List<MovieCategory> _categories = [
    MovieCategory.topRated,
    MovieCategory.nowPlaying,
    MovieCategory.comingSoon,
  ];

  late final List<MovieListCubit> _cubits;

@override
void initState() {
  super.initState();

  _cubits = _categories
      .map((category) => MovieListCubit(category))
      .toList();

  for (final cubit in _cubits) {
    cubit.fetchMovies();
  }
}

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onTabTapped(int index) {
    AppNavigator.animateToTab(_pageController, index);
  }

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _categories[_selectedIndex].color,
      appBar: HomeAppBar(category: _categories[_selectedIndex]),
      body: HomePageView(
        controller: _pageController,
        categories: _categories,
        cubits:_cubits,
        onPageChanged: _onPageChanged,
      ),
      bottomNavigationBar: HomeBottomNavBar(
        selectedIndex: _selectedIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}