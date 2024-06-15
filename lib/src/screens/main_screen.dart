import 'package:Techwise/src/screens/login_screen.dart';
import 'package:Techwise/src/screens/signup_screen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(40.0),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Center(
              child: Text(
                "Techwise",
                style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
              ),
            ),

            SizedBox(
              height: 70,
            ),

            ElevatedButton(
              child: Text('Login',
                style: TextStyle(fontSize: 23.0),),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                onPrimary: Colors.black,
                padding: EdgeInsets.all(20.0),
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => LoginScreen()));
              },
            ),

            SizedBox(
              height: 20,
            ),

            ElevatedButton(
              child: Text('Signup',
                style: TextStyle(fontSize: 23.0),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                onPrimary: Colors.black,
                padding: EdgeInsets.all(20.0),
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => SignupScreen()));
              },
            )
          ],
        ),
      ),
    );
  }
}
