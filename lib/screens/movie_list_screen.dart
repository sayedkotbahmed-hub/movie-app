import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:movie_app/core/movie_category.dart';
import 'package:movie_app/providers/movie_list_provider.dart';
import 'package:movie_app/widgets/movie_grid_view.dart';
import 'package:movie_app/widgets/error_view.dart';

class MovieListScreen extends StatefulWidget {
  final MovieCategory category;

  const MovieListScreen({super.key, required this.category});

  @override
  State<MovieListScreen> createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;

    if (currentScroll >= maxScroll - 200) {
      context.read<MovieListProvider>().loadMoreMovies();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MovieListProvider>(
      builder: (context, provider, child) {
        return _buildBody(provider);
      },
    );
  }

  Widget _buildBody(MovieListProvider provider) {
    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (provider.errorMessage != null) {
      return ErrorView(
        message: provider.errorMessage!,
        onRetry: provider.fetchMovies,
      );
    }

    if (provider.movies.isEmpty) {
      return const Center(child: Text('No movies found.'));
    }

    return MovieGridView(
      movies: provider.movies,
      category: widget.category,
      controller: _scrollController,
    );
  }
}