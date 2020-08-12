import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tmdb/auth/login.dart';
import 'package:flutter_tmdb/auth/sign_in.dart';
import 'package:flutter_tmdb/screens/tv_screen.dart';
import 'package:flutter_tmdb/style/theme.dart' as Style;
import 'package:flutter_tmdb/widgets/top_rated_movies.dart';
import 'package:flutter_tmdb/widgets/genres.dart';
import 'package:flutter_tmdb/widgets/now_playing.dart';
import 'package:flutter_tmdb/widgets/persons.dart';
import 'package:flutter_tmdb/style/theme.dart' as Style;
import 'package:flutter_tmdb/widgets/upcoming_movies.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => showDialog<bool>(context: context,builder: (c) => AlertDialog(
        backgroundColor: Colors.grey,
        title: Text("Warning"),
        content: Text('Do you really want to exit?'),
        actions: <Widget>[
          FlatButton(
            child: Text('Yes'),
            onPressed: () => SystemNavigator.pop(),
          ),
          FlatButton(
            child: Text('No'),
            onPressed: () => Navigator.pop(c, false),
          ),
        ],
      )),
      child: Scaffold(
        backgroundColor: Style.Colors.mainColor,
        appBar: AppBar(
          backgroundColor: Style.Colors.mainColor,
          centerTitle: true,
         // leading: Icon(EvaIcons.menu2Outline,color: Colors.white,),
          title: Text("Movies"),
          actions: <Widget>[
            IconButton(
              onPressed: (){},
              icon: Icon(EvaIcons.searchOutline,color: Colors.white,),
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
                  onTap: (){
                    Navigator.pop(context);
                    Navigator.push(context, CupertinoPageRoute(
                      builder: (context) => HomeScreen()
                    ));
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
                  onTap: (){
                    signOutGoogle();
                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginPage()), ModalRoute.withName('/'));
                  },
                )
              ],
            ),
          ),
        ),
        body: ListView(
          children: <Widget>[
            NowPlaying(),
            GenresScreen(),
            PersonList(),
            TopRatedMovies(),
            UpcomingMovies(),
          ]
        ),
      ),
    );
  }
}
