import 'package:flutter/material.dart';
import 'package:movie_app/core/movie_category.dart';

class HomeBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTap;

  const HomeBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.shifting,
      currentIndex: selectedIndex,
      onTap: onTap,
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
    );
  }
}