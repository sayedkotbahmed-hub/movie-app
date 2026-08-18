import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:movie_app/core/movie_category.dart';
import 'package:movie_app/providers/movie_list_provider.dart';
import 'package:movie_app/screens/movie_list_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/core/app_navigator.dart';

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

  late final List<MovieListProvider> _providers;

  @override
  void initState() {
    super.initState();

    _providers = _categories
        .map((category) => MovieListProvider(category))
        .toList();

    Future.microtask(() {
      for (final provider in _providers) {
        provider.fetchMovies();
      }
    });
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
      appBar: AppBar(
        backgroundColor: _categories[_selectedIndex].color,
        title: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Text(
            _categories[_selectedIndex].label,
            style: GoogleFonts.cinzel(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
        ),
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: List.generate(_categories.length, (index) {
          return ChangeNotifierProvider.value(
            value: _providers[index],
            child: MovieListScreen(category: _categories[index]),
          );
        }),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        currentIndex: _selectedIndex,
        onTap: _onTabTapped,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.star),
            label: 'Top Rated',
            backgroundColor: MovieCategory.topRated.color,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.play_circle),
            label: 'Now Playing',
            backgroundColor: MovieCategory.nowPlaying.color,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.upcoming),
            label: 'Coming Soon',
            backgroundColor: MovieCategory.comingSoon.color,
          ),
        ],
      ),
    );
  }
}
