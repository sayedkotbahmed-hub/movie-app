import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/core/movie_category.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final MovieCategory category;

  const HomeAppBar({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: category.color,
      title: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Text(
          category.label,
          style: GoogleFonts.cinzel(
            color: Colors.white,
            fontSize: 26,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 20);
}