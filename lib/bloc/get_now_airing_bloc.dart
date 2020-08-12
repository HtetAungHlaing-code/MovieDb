import 'package:flutter_tmdb/model/tv_response.dart';
import 'package:flutter_tmdb/repository/tv_repository.dart';
import 'package:rxdart/rxdart.dart';

class NowAiringListBloc{
  final TvRepository _repository = TvRepository();
  final BehaviorSubject<TvResponse> _subject = BehaviorSubject<TvResponse>();

  getAiringMovies()async{
    TvResponse response = await _repository.getAiringMovies();
    _subject.sink.add(response);
  }

  dispose(){
    _subject.close();
  }
  BehaviorSubject<TvResponse> get subject => _subject;

}
final nowAiringMoviesBloc = NowAiringListBloc();