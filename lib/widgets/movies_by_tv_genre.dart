import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_tmdb/bloc/get_movies_byTvGenre_bloc.dart';
import 'package:flutter_tmdb/model/tv.dart';
import 'package:flutter_tmdb/model/tv_response.dart';
import 'package:flutter_tmdb/screens/tv_detail_screen.dart';
import 'package:flutter_tmdb/style/theme.dart' as Style;

class TvGenreMovies extends StatefulWidget {
  final int tvgenreId;

  const TvGenreMovies({Key key, this.tvgenreId}) : super(key: key);

  @override
  _TvGenreMoviesState createState() => _TvGenreMoviesState(tvgenreId);
}

class _TvGenreMoviesState extends State<TvGenreMovies> {
  final int tvgenreId;

  _TvGenreMoviesState(this.tvgenreId);

  @override
  void initState() {
    super.initState();
    moviesByTvGenreBloc..getMoviesByTvGenre(tvgenreId);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<TvResponse>(
      stream: moviesByTvGenreBloc.subject.stream,
      builder: (context, AsyncSnapshot<TvResponse> snapshot) {
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

  Widget _buildHomeWidget(TvResponse data) {
    List<Tv> movies = data.tvs;
    if (movies.length == 0) {
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
      return Container(
        height: 270.0,
        padding: EdgeInsets.only(left: 10.0),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: movies.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(
                  top: 10.0,
                  bottom: 10.0,
                  right: 15.0
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TvDetailScreen(tv: movies[index]),
                    ),
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    movies[index].poster == null?
                    Container(
                      width: 120.0,
                      height: 180.0,
                      decoration: new BoxDecoration(
                        color: Style.Colors.secondColor,
                        borderRadius:
                        BorderRadius.all(Radius.circular(2.0)),
                        shape: BoxShape.rectangle,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(EvaIcons.filmOutline, color: Colors.white, size: 60.0,)
                        ],
                      ),
                    ):
                    Container(
                        width: 120.0,
                        height: 180.0,
                        decoration: new BoxDecoration(
                          borderRadius:
                          BorderRadius.all(Radius.circular(2.0)),
                          shape: BoxShape.rectangle,
                          image: new DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage("https://image.tmdb.org/t/p/w200/" + movies[index].poster)),
                        )),
                    SizedBox(
                      height: 10.0,
                    ),
                    movies[index].title == null ? Container(
                      width: 100,
                      child: Text(
                        "No Title",
                        style: TextStyle(
                            height: 1.4,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 11.0),
                      ),
                    ):
                    Container(
                      width: 100,
                      child: Text(
                        movies[index].title,
                        maxLines: 2,
                        style: TextStyle(
                            height: 1.4,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 11.0),
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(movies[index].rating.toString(), style: TextStyle(
                            color: Colors.white,
                            fontSize: 10.0,
                            fontWeight: FontWeight.bold
                        ),),
                        SizedBox(
                          width: 5.0,
                        ),
                        RatingBar(
                          itemSize: 8.0,
                          initialRating: movies[index].rating / 2,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                          itemBuilder: (context, _) => Icon(
                            EvaIcons.star,
                            color: Style.Colors.secondColor,
                          ),
                          onRatingUpdate: (rating) {
                            print(rating);
                          },
                        )
                      ],
                    )

                  ],
                ),
              ),
            );
          },
        ),
      );
  }

}
