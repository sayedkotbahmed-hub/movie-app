import '../core/api_constants.dart';

class MovieModel {
  final int id;
  final String title;
  final double movieRate;
  final String? posterPath;
  final String? releaseDate;
  final String overview;

  const MovieModel({
    required this.id,
    required this.title,
    required this.movieRate,
    this.posterPath,
    this.releaseDate,
    required this.overview,
  });

  String? get posterUrl {
    if (posterPath == null) return null;
    return '${ApiConstants.imageBaseUrl}$posterPath';
  }

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'],
      title: json['title'],
      movieRate: json['vote_average'],
      posterPath: json['poster_path'],
      releaseDate: json['release_date'],
      overview: json['overview'],
    );
  }
}