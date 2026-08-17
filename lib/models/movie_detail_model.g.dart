// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieDetailModel _$MovieDetailModelFromJson(Map<String, dynamic> json) =>
    MovieDetailModel(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      posterPath: json['poster_path'] as String?,
      overview: json['overview'] as String,
      releaseDate: json['release_date'] as String?,
      movieRate: (json['vote_average'] as num).toDouble(),
      runtime: (json['runtime'] as num?)?.toInt(),
    );

Map<String, dynamic> _$MovieDetailModelToJson(MovieDetailModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'poster_path': instance.posterPath,
      'overview': instance.overview,
      'release_date': instance.releaseDate,
      'vote_average': instance.movieRate,
      'runtime': instance.runtime,
    };
