import 'package:Techwise/src/screens/technology_screen.dart';
import 'package:flutter/material.dart';

class SelectLanguage extends StatelessWidget {
  const SelectLanguage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(90.0),
          child: Text(
            "Techwise",
            style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 40,
            ),
            Center(
              child: Text(
                "Select your Language:",
                style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            ElevatedButton(
              child: Text(
                'English',
                style: TextStyle(fontSize: 20.0),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                onPrimary: Colors.black,
                padding: EdgeInsets.all(20.0),
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => SelectTechnology()));
              },
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              child: Text(
                'Hindi',
                style: TextStyle(fontSize: 20.0),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                onPrimary: Colors.black,
                padding: EdgeInsets.all(20.0),
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => SelectTechnology()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
