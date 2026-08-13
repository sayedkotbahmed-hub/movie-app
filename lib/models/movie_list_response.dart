import "package:movie_app/models/movie_model.dart";

class MovieListResponse {
  final int page;
  final List<MovieModel> results;
  final int totalPages;
 

  const MovieListResponse({
    required this.page,
    required this.results,
    required this.totalPages,
  
  });

  factory MovieListResponse.fromJson(Map<String, dynamic> json) {
    return MovieListResponse(
      page: json['page'],
      results: (json['results'] as List)
    .map((movieJson) => MovieModel.fromJson(movieJson))
    .toList(),
      totalPages: json['total_pages'],
   
    );
  }
}