import 'dart:async';
import 'package:Techwise/src/admin/admin_main_screen.dart';
import 'package:Techwise/src/screens/language_screen.dart';
import 'package:Techwise/src/screens/signup_screen.dart';
import 'package:Techwise/src/screens/technology_screen.dart';
import 'package:flutter/material.dart';

import 'main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    FirebaseAuth auth = FirebaseAuth.instance;
    if (auth.currentUser != null && auth.currentUser.uid.isNotEmpty) {
      Timer(
          Duration(seconds: 3),
          () => Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) => SelectTechnology())));
    } else {
      Timer(
          Duration(seconds: 3),
          () => Navigator.of(context).pushReplacement(MaterialPageRoute(
              // builder: (BuildContext context) => SelectTechnology())));
              builder: (BuildContext context) => SignupScreen())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.purple.shade500, Colors.greenAccent])),
        child: Center(
          child: InkWell(
            onTap: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => AdminScreen()));
            },
            child: Text(
              'Techwise',
              style: TextStyle(
                  fontSize: 48.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
