import 'package:flutter/material.dart';
import 'package:flutter_tmdb/bloc/get_movies_byTvGenre_bloc.dart';
import 'package:flutter_tmdb/bloc/get_tv_genres_bloc.dart';
import 'package:flutter_tmdb/model/tv_genre.dart';
import 'package:flutter_tmdb/style/theme.dart' as Style;
import 'package:flutter_tmdb/widgets/movies_by_tv_genre.dart';

class TvGenresList extends StatefulWidget {
  final List<TvGenre> genres;

  const TvGenresList({Key key, this.genres}) : super(key: key);

  @override
  _TvGenresListState createState() => _TvGenresListState(genres);
}

class _TvGenresListState extends State<TvGenresList> with SingleTickerProviderStateMixin {
  final List<TvGenre> genres;

  _TvGenresListState(this.genres);
  TabController _tabController;

  @override
  void initState() {
  super.initState();
  _tabController = TabController(vsync: this,length: genres.length );
  _tabController.addListener(() {
  if(_tabController.indexIsChanging){
  moviesByTvGenreBloc.drainStream();
  }
  });
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 307.0,
        child: DefaultTabController(
          length: genres.length,
          child: Scaffold(
            backgroundColor: Style.Colors.mainColor,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(50.0),
              child: AppBar(
                backgroundColor: Style.Colors.mainColor,
                bottom: TabBar(
                  controller: _tabController,
                  indicatorColor: Style.Colors.secondColor,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorWeight: 3.0,
                  unselectedLabelColor: Style.Colors.titleColor,
                  labelColor: Colors.white,
                  isScrollable: true,
                  tabs: genres.map((TvGenre genre) {
                    return Container(
                        padding: EdgeInsets.only(bottom: 15.0, top: 10.0),
                        child: new Text(genre.name.toUpperCase(),
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                            )));
                  }).toList(),
                ),
              ),
            ),
            body: TabBarView(
              controller: _tabController,
              physics: NeverScrollableScrollPhysics(),
              children: genres.map((TvGenre genre) {
                return TvGenreMovies(
                  tvgenreId: genre.id,
                );
              }).toList(),
            ),
          ),
        ));
  }
}
