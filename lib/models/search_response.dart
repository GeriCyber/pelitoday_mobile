import 'dart:convert';

import 'package:pelitoday/models/movie.dart';

class SearchResponse {
    SearchResponse({
        required this.page,
        required this.results,
        required this.totalResults,
        required this.totalPages,
    });

    int page;
    List<Movie> results;
    int totalResults;
    int totalPages;

    factory SearchResponse.fromJson(String str) => SearchResponse.fromMap(json.decode(str));

    factory SearchResponse.fromMap(Map<String, dynamic> json) => SearchResponse(
        page: json["page"],
        results: List<Movie>.from(json["results"].map((x) => Movie.fromMap(x))),
        totalResults: json["total_results"],
        totalPages: json["total_pages"],
    );
}
