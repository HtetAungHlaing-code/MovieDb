import 'package:flutter_tmdb/model/tv.dart';

class TvResponse{
    final List<Tv> tvs;
    final String error;

    TvResponse(this.tvs, this.error);

    TvResponse.fromJson(Map<String, dynamic> json) :
        tvs = (json["results"] as List).map((i) => Tv.fromJson(i) ).toList(),
        error = "";

        TvResponse.withError(String errorValue):
          tvs = List(),
          error = errorValue;

}