import 'package:Techwise/src/common/comman_strings.dart';
import 'package:Techwise/src/screens/final_loginscreen.dart';
import 'package:Techwise/src/screens/language_screen.dart';
import 'package:Techwise/src/screens/technology_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class OTPScreen extends StatefulWidget {
  final String number;

  const OTPScreen(this.number, {Key key}) : super(key: key);

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  FirebaseAuth _auth;
  String varId = "";
  TextEditingController _otpController = new TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    loginUser(widget.number, context);
  }
//
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
                height: 100,
              ),
              Center(
                child: Text(
                  "Techwise",
                  style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 70,
              ),
              Center(
                child: Text(
                  "We have sent an OTP to number ending with +91 ***** ***${widget.number.substring(11)}",
                  style: TextStyle(fontSize: 25.0),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              TextField(
                controller: _otpController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(labelText: 'Enter OTP here'),
              ),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                child: isLoading
                    ? CircularProgressIndicator(color: Colors.black)
                    : Text(
                        'Next',
                        style: TextStyle(fontSize: 20.0),
                      ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  onPrimary: Colors.black,
                  padding: EdgeInsets.all(20.0),
                ),
                onPressed: checkOTP,
              )
            ],
          ),
        ),
      ),
    );
  }

  void loginUser(String phone, BuildContext context) async {
    try {
      _auth = FirebaseAuth.instance;
      _auth.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: const Duration(seconds: 60),
        verificationCompleted: (AuthCredential credential) async {
          UserCredential result = await _auth.signInWithCredential(credential);
          auth.User user = result.user;
          if (user != null) {
            checkUser(user.uid);
          }
        },
        verificationFailed: (error) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Something was wrong please try again.")));
        },
        codeSent: (String verificationId, int resendToken) {
          varId = verificationId;
          print(resendToken);
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("OTP sent on your mobile.")));
        },
        codeAutoRetrievalTimeout: (verificationId) {},
      );
    } catch (e) {
      print(e);
    }
  }

  void checkOTP() async {
    if (!isLoading) {
      try {
        setState(() {
          isLoading = true;
        });
        final AuthCredential credential1 = PhoneAuthProvider.credential(
            verificationId: varId, smsCode: _otpController.text);
        UserCredential result = await _auth.signInWithCredential(credential1);
        auth.User user = result.user;
        setState(() {
          isLoading = false;
        });
        if (user != null) {
          checkUser(user.uid);
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Invalid otp.")));
        }
      } catch (e) {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Invalid otp.")));
      }
    }
  }

  void checkUser(String userId) async {
    try {
      FirebaseFirestore.instance
          .collection(COLLECTION_USERS)
          .doc(userId)
          .get()
          .then((event) {
        setState(() {
          isLoading = false;
        });
        if (event.exists) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => SelectTechnology()),
              ModalRoute.withName('/'));
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (BuildContext context) => SelectLanguage()));
        } else {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) =>
                      FinalLogin(userId: userId, number: widget.number)));
        }
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) =>
                  FinalLogin(userId: userId, number: widget.number)));
    }
  }

/*
  void listenForUpdate() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+91${widget.number}',
      verificationCompleted: (PhoneAuthCredential credential) {
        print("Success >> " + credential.token.toString());
        Map<String, dynamic> map = {
          "name": widget.name,
          "number": widget.number,
          "created_at": FieldValue.serverTimestamp(),
          "updated_at": FieldValue.serverTimestamp(),
        };
        FirebaseFirestore.instance.collection(COLLECTION_USERS).add(map);
        print("Success >> " + credential.token.toString());
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => FinalLogin()));
      },
      verificationFailed: (FirebaseAuthException e) {
        print("ERROR >>> " + e.toString());
      },
      codeSent: (String verificationId, int resendToken) {
        print("verificationId >>> " + verificationId.toString());
        print("resendToken >>> " + resendToken.toString());
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        print("codeAutoRetrievalTimeout >>> " + verificationId.toString());
      },
    );
  }*/
}
