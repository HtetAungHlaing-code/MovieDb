import 'package:dio/dio.dart';
import 'package:flutter_tmdb/model/tv_genre_response.dart';
import 'package:flutter_tmdb/model/tv_response.dart';
import 'package:flutter_tmdb/model/video_response.dart';

class TvRepository{
  final String apiKey = "4dcdb81b0222dcc00d764b4d9e2fd20a";
  static String mainUrl = "https://api.themoviedb.org/3";
  final Dio _dio = Dio();

  //Tv Shows
  var tvUrl = "$mainUrl/tv";
  var getTvUrl = "$mainUrl/discover/tv";
  var getAiringUrl = "$mainUrl/tv/airing_today";
  var getTvGenresUrl = "$mainUrl/genre/tv/list";
  var getTvPopularUrl = "$mainUrl/tv/popular";
  var getTvTopRatedUrl = "$mainUrl/tv/top_rated";

  Future<TvResponse> getAiringMovies() async{
    var params = {
      "api_key" : apiKey,
      "language" : "en-Us",
      "page" : 1
    };
    try{
      Response response = await _dio.get(getAiringUrl, queryParameters: params);
      return TvResponse.fromJson(response.data);
    }catch(error, stacktrace){
      print("Exception occured: $error stackTrace: $stacktrace");
      return TvResponse.withError("$error");
    }
  }

  Future<TvGenreResponse> getTvGenres() async{
    var params = {
      "api_key" : apiKey,
      "language" : "en-Us",
      "page" : 1
    };
    try{
      Response response = await _dio.get(getTvGenresUrl, queryParameters: params);
      return TvGenreResponse.fromJson(response.data);
    }catch(error, stacktrace){
      print("Exception occured: $error stackTrace: $stacktrace");
      return TvGenreResponse.withError("$error");
    }
  }

  Future<TvResponse> getMovieByTvGenre(int id) async{
    var params = {
      "api_key" : apiKey,
      "language" : "en-Us",
      "page" : 1,
      "with_genres" : id
    };
    try{
      Response response = await _dio.get(getTvUrl, queryParameters: params);
      return TvResponse.fromJson(response.data);
    }catch(error, stacktrace){
      print("Exception occured: $error stackTrace: $stacktrace");
      return TvResponse.withError("$error");
    }
  }

  Future<VideoResponse> getTvVideos(int id) async{
    var params = {
      "api_key" : apiKey,
      "language" : "en-Us",
      "page" : 1
    };
    try{
      Response response = await _dio.get(tvUrl + "/$id" + "/videos", queryParameters: params);
      return VideoResponse.fromJson(response.data);
    }catch(error, stacktrace){
      print("Exception occured: $error stackTrace: $stacktrace");
      return VideoResponse.withError("$error");
    }
  }

  Future<TvResponse> getTvPopular() async{
    var params = {
      "api_key" : apiKey,
      "language" : "en-Us",
      "page" : 1
    };
    try{
      Response response = await _dio.get(getTvPopularUrl, queryParameters: params);
      return TvResponse.fromJson(response.data);
    }catch(error, stacktrace){
      print("Exception occured: $error stackTrace: $stacktrace");
      return TvResponse.withError("$error");
    }
  }

  Future<TvResponse> getTvTopRated() async{
    var params = {
      "api_key" : apiKey,
      "language" : "en-Us",
      "page" : 1
    };
    try{
      Response response = await _dio.get(getTvTopRatedUrl, queryParameters: params);
      return TvResponse.fromJson(response.data);
    }catch(error, stacktrace){
      print("Exception occured: $error stackTrace: $stacktrace");
      return TvResponse.withError("$error");
    }
  }

}