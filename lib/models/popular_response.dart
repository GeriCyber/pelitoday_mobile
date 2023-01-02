import 'dart:convert';
import 'package:pelitoday/models/models.dart';

class PopularResponse {
    PopularResponse({
        required this.page,
        required this.results,
        required this.totalResults,
        required this.totalPages,
    });

    int page;
    List<Movie> results;
    int totalResults;
    int totalPages;

    factory PopularResponse.fromJson(String str) => PopularResponse.fromMap(json.decode(str));

    factory PopularResponse.fromMap(Map<String, dynamic> json) => PopularResponse(
        page: json["page"],
        results: List<Movie>.from(json["results"].map((x) => Movie.fromMap(x))),
        totalResults: json["total_results"],
        totalPages: json["total_pages"],
    );
}
