import 'package:flutter/material.dart';
import 'package:flutter_tmdb/model/cast_response.dart';
import 'package:flutter_tmdb/repository/movie_repository.dart';
import 'package:rxdart/rxdart.dart';

class CastsBloc{
  final MovieRepository _repository = MovieRepository();
  final BehaviorSubject<CastResponse> _subject = BehaviorSubject<CastResponse>();

  getCasts(int id) async{
    CastResponse response = await _repository.getCasts(id) ;
    _subject.sink.add(response);
  }

  void drainStream(){_subject.value =null;}
  @mustCallSuper
  void dispose() async{
    await _subject.close();
  }

  BehaviorSubject<CastResponse> get subject => _subject;

}
final castsBloc = CastsBloc();