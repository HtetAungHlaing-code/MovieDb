import 'package:flutter/material.dart';
import 'package:flutter_tmdb/model/video_response.dart';
import 'package:flutter_tmdb/repository/tv_repository.dart';
import 'package:rxdart/rxdart.dart';

class TvVideosBloc{
  final TvRepository _repository = TvRepository();
  final BehaviorSubject<VideoResponse> _subject = BehaviorSubject<VideoResponse>();

  getTvVideos(int id) async{
    VideoResponse response = await _repository.getTvVideos(id);
    _subject.sink.add(response);
  }

  void drainStream(){_subject.value = null;}
  @mustCallSuper
  void dispose() async{
    await _subject.drain();
    _subject.close();
  }

  BehaviorSubject<VideoResponse> get subject => _subject;

}
final tvVideosBloc = TvVideosBloc();