import 'package:flutter/material.dart';

ElevatedButton commonRaisedButton(String text,) {
  return ElevatedButton(
    child: Text(text,
      style: TextStyle(fontSize: 23.0),
    ),
    style: ElevatedButton.styleFrom(
      primary: Colors.blue,
      onPrimary: Colors.black,
      padding: EdgeInsets.all(20.0),
    ),
    onPressed: () {
      print(text+" clicked");
      // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => SignupScreen()));
    },
  );
}