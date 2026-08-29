import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/movie_category.dart';
import 'package:movie_app/providers/movie_list_cubit.dart';
import 'package:movie_app/providers/movie_list_state.dart';
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
      context.read<MovieListCubit>().loadMoreMovies();
    }
  }

  @override
  Widget build(BuildContext context) {
   return BlocBuilder<MovieListCubit,MovieListState>(
      builder: (context, state) {
        return _buildBody(context, state);
      },
    );
  }

  Widget _buildBody(BuildContext context, MovieListState state) {
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.errorMessage != null) {
      return ErrorView(
        message: state.errorMessage!,
        onRetry: () => context.read<MovieListCubit>().fetchMovies(),
      );
    }

    if (state.movies.isEmpty) {
      return const Center(child: Text('No movies found.'));
    }

    return MovieGridView(
      movies: state.movies,
      category: widget.category,
      controller: _scrollController,
    );
  }
}