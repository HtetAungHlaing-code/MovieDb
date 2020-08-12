import 'package:flutter/material.dart';
import 'package:flutter_tmdb/model/tv_response.dart';
import 'package:flutter_tmdb/repository/tv_repository.dart';
import 'package:rxdart/rxdart.dart';

class MovieListByTvGenreBloc{
  final TvRepository _repository = TvRepository();
  final BehaviorSubject<TvResponse> _subject = BehaviorSubject<TvResponse>();

  getMoviesByTvGenre(int id) async{
    TvResponse response = await _repository.getMovieByTvGenre(id);
    _subject.sink.add(response);
  }

  void drainStream(){_subject.value = null;}
  @mustCallSuper
  void dispose() async{
    await _subject.drain();
    _subject.close();
  }

  BehaviorSubject<TvResponse> get subject => _subject;
}
final moviesByTvGenreBloc = MovieListByTvGenreBloc();