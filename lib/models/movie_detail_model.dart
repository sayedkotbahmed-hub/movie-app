import 'package:json_annotation/json_annotation.dart';
import 'package:movie_app/core/api_constants.dart';

part 'movie_detail_model.g.dart';

@JsonSerializable()
class MovieDetailModel {
  final int id;
  final String title;

  @JsonKey(name: 'poster_path' )
  final String? posterPath;
  
  final String overview;
  @JsonKey(name: 'release_date' )
  final String? releaseDate;

@JsonKey(name: 'vote_average' )
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

  factory MovieDetailModel.fromJson(Map<String, dynamic> json) => _$MovieDetailModelFromJson(json);
  Map<String, dynamic> toJson() => _$MovieDetailModelToJson(this);
}