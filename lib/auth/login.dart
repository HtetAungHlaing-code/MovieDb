import 'package:flutter/material.dart';
import 'package:flutter_tmdb/UI/background.dart';
import 'package:flutter_tmdb/auth/LoginUI.dart';
import 'package:flutter_tmdb/auth/sign_in.dart';
import 'package:flutter_tmdb/screens/home_screen.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Background(),
          Login(),
         // _signInButton()
        ],
      )
    );
  }

}