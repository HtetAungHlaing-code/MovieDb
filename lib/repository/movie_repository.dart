import 'package:dio/dio.dart';
import 'package:flutter_tmdb/model/cast_response.dart';
import 'package:flutter_tmdb/model/genre_response.dart';
import 'package:flutter_tmdb/model/movie_detail_response.dart';
import 'package:flutter_tmdb/model/movie_response.dart';
import 'package:flutter_tmdb/model/person_response.dart';
import 'package:flutter_tmdb/model/tv_response.dart';
import 'package:flutter_tmdb/model/video.dart';
import 'package:flutter_tmdb/model/video_response.dart';

class MovieRepository{
  final String apiKey = "4dcdb81b0222dcc00d764b4d9e2fd20a";
  static String mainUrl = "https://api.themoviedb.org/3";
  final Dio _dio = Dio();
  //Movies
  var getMoviesUrl = "$mainUrl/discover/movie";
  var getPopularUrl = "$mainUrl/movie/top_rated";
  var getPlayingUrl = "$mainUrl/movie/now_playing";
  var getGenresUrl = "$mainUrl/genre/movie/list";
  var getPersonUrl = "$mainUrl/trending/person/week";
  var getUpcomingUrl = "$mainUrl/movie/upcoming";
  var movieUrl = "$mainUrl/movie";


  Future<MovieResponse> getMovies() async{
    var params = {
      "api_key" : apiKey,
      "language" : "en-Us",
      "page" : 1
    };
    try{
      Response response = await _dio.get(getPopularUrl, queryParameters: params);
      return MovieResponse.fromJson(response.data);
    }catch(error, stacktrace){
      print("Exception occured: $error stackTrace: $stacktrace");
      return MovieResponse.withError("$error");
    }
  }

  Future<MovieResponse> getUpcomingMovies() async{
    var params = {
      "api_key" : apiKey,
      "language" : "en-Us",
      "page" : 1
    };
    try{
      Response response = await _dio.get(getUpcomingUrl, queryParameters: params);
      return MovieResponse.fromJson(response.data);
    }catch(error, stacktrace){
      print("Exception occured: $error stackTrace: $stacktrace");
      return MovieResponse.withError("$error");
    }
  }

  Future<MovieResponse> getPlayingMovies() async{
    var params = {
      "api_key" : apiKey,
      "language" : "en-Us",
      "page" : 1
    };
    try{
      Response response = await _dio.get(getPlayingUrl, queryParameters: params);
      return MovieResponse.fromJson(response.data);
    }catch(error, stacktrace){
      print("Exception occured: $error stackTrace: $stacktrace");
      return MovieResponse.withError("$error");
    }
  }

  Future<GenreResponse> getGenres() async{
    var params = {
      "api_key" : apiKey,
      "language" : "en-Us",
      "page" : 1
    };
    try{
      Response response = await _dio.get(getGenresUrl, queryParameters: params);
      return GenreResponse.fromJson(response.data);
    }catch(error, stacktrace){
      print("Exception occured: $error stackTrace: $stacktrace");
      return GenreResponse.withError("$error");
    }
  }

  Future<PersonResponse> getPersons() async{
    var params = {
      "api_key" : apiKey,
      "language" : "en-Us",
      "page" : 1
    };
    try{
      Response response = await _dio.get(getPersonUrl, queryParameters: params);
      return PersonResponse.fromJson(response.data);
    }catch(error, stacktrace){
      print("Exception occured: $error stackTrace: $stacktrace");
      return PersonResponse.withError("$error");
    }
  }

  Future<MovieResponse> getMovieByGenre(int id) async{
    var params = {
      "api_key" : apiKey,
      "language" : "en-Us",
      "page" : 1,
      "with_genres" : id
    };
    try{
      Response response = await _dio.get(getMoviesUrl, queryParameters: params);
      return MovieResponse.fromJson(response.data);
    }catch(error, stacktrace){
      print("Exception occured: $error stackTrace: $stacktrace");
      return MovieResponse.withError("$error");
    }
  }

  Future<MovieDetailResponse> getMovieDetail(int id) async{
    var params = {
      "api_key" : apiKey,
      "language" : "en-Us",
      "page" : 1
    };
    try{
      Response response = await _dio.get(movieUrl + "/$id", queryParameters: params);
      return MovieDetailResponse.fromJson(response.data);
    }catch(error, stacktrace){
      print("Exception occured: $error stackTrace: $stacktrace");
      return MovieDetailResponse.withError("$error");
    }
  }

  Future<VideoResponse> getMovieVideos(int id) async{
    var params = {
      "api_key" : apiKey,
      "language" : "en-Us",
      "page" : 1
    };
    try{
      Response response = await _dio.get(movieUrl + "/$id" + "/videos", queryParameters: params);
      return VideoResponse.fromJson(response.data);
    }catch(error, stacktrace){
      print("Exception occured: $error stackTrace: $stacktrace");
      return VideoResponse.withError("$error");
    }
  }

  Future<MovieResponse> getSimilarMovies(int id) async{
    var params = {
      "api_key" : apiKey,
      "language" : "en-Us",
      "page" : 1
    };
    try{
      Response response = await _dio.get(movieUrl + "/$id" + "/similar", queryParameters: params);
      return MovieResponse.fromJson(response.data);
    }catch(error, stacktrace){
      print("Exception occured: $error stackTrace: $stacktrace");
      return MovieResponse.withError("$error");
    }
  }

  Future<CastResponse> getCasts(int id) async{
    var params = {
      "api_key" : apiKey,
      "language" : "en-Us",
      "page" : 1
    };
    try{
      Response response = await _dio.get(movieUrl + "/$id" + "/credits" , queryParameters: params);
      return CastResponse.fromJson(response.data);
    }catch(error, stacktrace){
      print("Exception occured: $error stackTrace: $stacktrace");
      return CastResponse.withError("$error");
    }
  }


}