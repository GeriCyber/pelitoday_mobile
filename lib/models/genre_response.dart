import 'dart:convert';

class GenresResponse {
    GenresResponse({
      this.adult,
      this.backdropPath,
      this.belongsToCollection,
      this.budget,
      required this.genres,
      this.homepage,
      this.id,
      this.imdbId,
      this.originalLanguage,
      this.originalTitle,
      this.overview,
      this.popularity,
      this.posterPath,
      this.releaseDate,
      this.revenue,
      this.runtime,
      this.status,
      this.tagline,
      this.title,
      this.video,
      this.voteAverage,
      this.voteCount,
    });

    bool? adult;
    String? backdropPath;
    dynamic? belongsToCollection;
    int? budget;
    List<Genre> genres;
    String? homepage;
    int? id;
    String? imdbId;
    String? originalLanguage;
    String? originalTitle;
    String? overview;
    double? popularity;
    dynamic? posterPath;
    DateTime? releaseDate;
    int? revenue;
    int? runtime;
    String? status;
    String? tagline;
    String? title;
    bool? video;
    double? voteAverage;
    int? voteCount;

    factory GenresResponse.fromJson(String str) => GenresResponse.fromMap(json.decode(str));

    factory GenresResponse.fromMap(Map<String, dynamic> json) => GenresResponse(
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        belongsToCollection: json["belongs_to_collection"],
        budget: json["budget"],
        genres: List<Genre>.from(json["genres"].map((x) => Genre.fromMap(x))),
        homepage: json["homepage"],
        id: json["id"],
        imdbId: json["imdb_id"],
        originalLanguage: json["original_language"],
        originalTitle: json["original_title"],
        overview: json["overview"],
        popularity: json["popularity"].toDouble(),
        posterPath: json["poster_path"],
        releaseDate: DateTime.parse(json["release_date"]),
        revenue: json["revenue"],
        runtime: json["runtime"],
        status: json["status"],
        tagline: json["tagline"],
        title: json["title"],
        video: json["video"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
    );
}

class Genre {
    Genre({
      required  this.id,
      required  this.name,
    });

    int id;
    String name;

    factory Genre.fromJson(String str) => Genre.fromMap(json.decode(str));

    factory Genre.fromMap(Map<String, dynamic> json) => Genre(
        id: json["id"],
        name: json["name"],
    );
}
