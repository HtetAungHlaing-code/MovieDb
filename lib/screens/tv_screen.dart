import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tmdb/auth/sign_in.dart';
import 'package:flutter_tmdb/screens/home_screen.dart';
import 'package:flutter_tmdb/style/theme.dart' as Style;
import 'package:flutter_tmdb/widgets/now_airing.dart';
import 'package:flutter_tmdb/widgets/persons.dart';
import 'package:flutter_tmdb/widgets/tv_genres.dart';
import 'package:flutter_tmdb/widgets/tv_popular.dart';
import 'package:flutter_tmdb/widgets/tv_top_rated.dart';

class TvScreen extends StatefulWidget {
  @override
  _TvScreenState createState() => _TvScreenState();
}

class _TvScreenState extends State<TvScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.Colors.mainColor,
      appBar: AppBar(
        backgroundColor: Style.Colors.mainColor,
        centerTitle: true,
        // leading: Icon(EvaIcons.menu2Outline,color: Colors.white,),
        title: Text("Tv Shows"),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(
              EvaIcons.searchOutline,
              color: Colors.white,
            ),
          )
        ],
      ),
      drawer: Theme(
        data: Theme.of(context).copyWith(canvasColor: Colors.blueGrey),
        child: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text(name),
                accountEmail: Text(email),
                currentAccountPicture: CircleAvatar(
                  backgroundColor:
                      Theme.of(context).platform == TargetPlatform.iOS
                          ? Colors.blue
                          : Colors.white,
                  backgroundImage: NetworkImage(imageUrl),
                ),
                decoration: BoxDecoration(
                  color: Style.Colors.mainColor,
//                image: DecorationImage(
//                  image: AssetImage(),
//                  fit: BoxFit.cover
//                )
                ),
              ),
              ListTile(
                title: Text("Movies"),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context,
                      CupertinoPageRoute(builder: (context) => HomeScreen()));
                },
              ),
              ListTile(
                title: Text("Tv Shows"),
                trailing: Icon(Icons.arrow_forward),
                onTap: (){
                  Navigator.pop(context);
                  Navigator.push(context, CupertinoPageRoute(
                      builder: (context) => TvScreen()
                  ));
                },
              ),
              ListTile(
                title: Text("Sign Out"),
                trailing: Icon(EvaIcons.logOut),
                onTap: () {
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
      ),
      body: ListView(
        children: <Widget>[
          NowAiring(),
          TvGenresScreen(),
          PersonList(),
          TvPopularMovies(),
          TvTopRatedMovies(),
        ],
      ),
    );
  }
}
