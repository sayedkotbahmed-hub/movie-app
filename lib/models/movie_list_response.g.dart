// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieListResponse _$MovieListResponseFromJson(Map<String, dynamic> json) =>
    MovieListResponse(
      page: (json['page'] as num).toInt(),
      results: (json['results'] as List<dynamic>)
          .map((e) => MovieModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPages: (json['total_pages'] as num).toInt(),
    );

Map<String, dynamic> _$MovieListResponseToJson(MovieListResponse instance) =>
    <String, dynamic>{
      'page': instance.page,
      'results': instance.results,
      'total_pages': instance.totalPages,
    };
