import '../core/api_constants.dart';

class MovieDetailModel {
  final int id;
  final String title;
  final String? posterPath;
  final String overview;
  final String? releaseDate;
  final double movieRate;
  final int? runtime;

  const MovieDetailModel({
    required this.id,
    required this.title,
    this.posterPath,
    required this.overview,
    this.releaseDate,
    required this.movieRate,
    this.runtime,
  });

  String? get posterUrl {
    if (posterPath == null) return null;
    return '${ApiConstants.imageBaseUrl}$posterPath';
  }

  factory MovieDetailModel.fromJson(Map<String, dynamic> json) {
    return MovieDetailModel(
      id: json['id'],
      title: json['title'],
      posterPath: json['poster_path'],
      overview: json['overview'],
      releaseDate: json['release_date'],
      movieRate: json['vote_average'],
      runtime: json['runtime'],
    );
  }
}