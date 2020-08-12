import 'package:flutter/material.dart';
import 'package:flutter_tmdb/bloc/get_tv_genres_bloc.dart';
import 'package:flutter_tmdb/model/tv_genre.dart';
import 'package:flutter_tmdb/model/tv_genre_response.dart';
import 'package:flutter_tmdb/widgets/tv_genres_list.dart';

class TvGenresScreen extends StatefulWidget {
  @override
  _TvGenresScreenState createState() => _TvGenresScreenState();
}

class _TvGenresScreenState extends State<TvGenresScreen> {
  @override
  void initState() {
    super.initState();
    tvgenresBloc.getTvGenres();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<TvGenreResponse>(
      stream: tvgenresBloc.subject.stream,
      builder: (context, AsyncSnapshot<TvGenreResponse> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.error != null && snapshot.data.error.length > 0) {
            return _buildErrorWidget(snapshot.data.error);
          }
          return _buildHomeWidget(snapshot.data);
        } else if (snapshot.hasError) {
          return _buildErrorWidget(snapshot.error);
        } else {
          return _buildLoadingWidget();
        }
      },
    );
  }


  Widget _buildLoadingWidget() {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 25.0,
              width: 25.0,
              child: CircularProgressIndicator(
                valueColor:
                new AlwaysStoppedAnimation<Color>(Colors.white),
                strokeWidth: 4.0,
              ),
            )
          ],
        ));
  }

  Widget _buildErrorWidget(String error) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Error occured: $error"),
          ],
        ));
  }

  Widget _buildHomeWidget(TvGenreResponse data) {
    List<TvGenre> genres = data.genres;
    print(genres);
    if (genres.length == 0) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                Text(
                  "No More Movies",
                  style: TextStyle(color: Colors.black45),
                )
              ],
            )
          ],
        ),
      );
    } else
      return TvGenresList(genres: genres,);
  }

}
