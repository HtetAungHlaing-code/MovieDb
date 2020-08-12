import 'package:flutter_tmdb/model/tv_genre.dart';

class TvGenreResponse{
  final List<TvGenre> genres;
  final String error;

  TvGenreResponse(this.genres, this.error);

  TvGenreResponse.fromJson(Map<String, dynamic> json):
        genres = (json["genres"] as List).map((i) => TvGenre.fromJson(i) ).toList(),
        error = "";

  TvGenreResponse.withError(String errorValue):
        genres = List(),
        error = errorValue;
}