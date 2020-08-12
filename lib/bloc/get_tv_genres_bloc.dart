import 'package:flutter_tmdb/model/tv_genre_response.dart';
import 'package:flutter_tmdb/repository/tv_repository.dart';
import 'package:rxdart/rxdart.dart';

class TvGenreListBloc{
  final TvRepository _repository = TvRepository();
  final BehaviorSubject<TvGenreResponse> _subject = BehaviorSubject<TvGenreResponse>();

  getTvGenres() async{
    TvGenreResponse response = await _repository.getTvGenres();
    _subject.sink.add(response);
  }

  dispose(){
    _subject.close();
  }

  BehaviorSubject<TvGenreResponse> get subject => _subject;

}
final tvgenresBloc = TvGenreListBloc();