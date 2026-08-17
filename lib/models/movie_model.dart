import 'package:json_annotation/json_annotation.dart';
import '../core/api_constants.dart';

part 'movie_model.g.dart';

@JsonSerializable()
class MovieModel {
  final int id;
  final String title;

  @JsonKey(name: 'vote_average')
  final double movieRate;

  @JsonKey(name: 'poster_path')
  final String? posterPath;

  @JsonKey(name: 'release_date')
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

  factory MovieModel.fromJson(Map<String, dynamic> json) =>
      _$MovieModelFromJson(json);

  Map<String, dynamic> toJson() => _$MovieModelToJson(this);
}