import 'package:Techwise/src/screens/otp_screen.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  SignupScreen({Key key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController numberController;

  @override
  void initState() {
    super.initState();
    numberController = TextEditingController();
  }

  @override
  void dispose() {
    numberController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 120,
              ),
              Center(
                child: Text(
                  "Techwise",
                  style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              TextField(
                controller: numberController,
                keyboardType: TextInputType.phone,
                maxLength: 10,
                decoration: InputDecoration(
                    labelText: "Enter Mobile Number", counter: Container()),
              ),
              SizedBox(
                height: 50,
              ),
              ElevatedButton(
                child: Text(
                  'CONTINUE',
                  style: TextStyle(fontSize: 20.0),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  onPrimary: Colors.black,
                  padding: EdgeInsets.all(20.0),
                ),
                onPressed: () {
                  if (numberController.text.toString().trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Please enter your mobile number.")));
                  } else if (numberController.text.toString().isNotEmpty &&
                      numberController.text.toString().trim().length != 10) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Please enter mobile valid number.")));
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                OTPScreen("+91${numberController.text}")));
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }


}
