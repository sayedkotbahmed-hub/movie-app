// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieModel _$MovieModelFromJson(Map<String, dynamic> json) => MovieModel(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  movieRate: (json['vote_average'] as num).toDouble(),
  posterPath: json['poster_path'] as String?,
  releaseDate: json['release_date'] as String?,
  overview: json['overview'] as String,
);

Map<String, dynamic> _$MovieModelToJson(MovieModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'vote_average': instance.movieRate,
      'poster_path': instance.posterPath,
      'release_date': instance.releaseDate,
      'overview': instance.overview,
    };
