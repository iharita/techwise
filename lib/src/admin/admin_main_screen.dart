import 'package:Techwise/src/admin/language/admin_language_screen.dart';
import 'package:Techwise/src/admin/technology/admin_technology_screen.dart';
import 'package:Techwise/src/screens/splash_screen.dart';
import 'package:flutter/material.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Panel"),
      ),
      body: ListView(
        children: ListTile.divideTiles(context: context, tiles: [
          ListTile(
            title: Text("Languages"),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => AdminLanguageScreen()));
            },
          ),
          ListTile(
            title: Text("Technologies"),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => AdminTechnologyScreen()));
            },
          ),
        ]).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.play_arrow),
        onPressed: () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => SplashScreen()));
        },
      ),
    );
  }
}
