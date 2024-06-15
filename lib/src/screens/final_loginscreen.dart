import 'package:Techwise/src/screens/language_screen.dart';
import 'package:Techwise/src/screens/technology_screen.dart';
import 'package:flutter/material.dart';

import '../common/comman_strings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FinalLogin extends StatefulWidget {
  final String userId;
  final String number;

  FinalLogin({Key key, this.userId, this.number}) : super(key: key);

  @override
  State<FinalLogin> createState() => _FinalLoginState();
}

class _FinalLoginState extends State<FinalLogin> {
  TextEditingController nameController = TextEditingController();
  bool isLoading = false;

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
                height: 50,
              ),
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: "Enter Name"),
              ),
              SizedBox(
                height: 50,
              ),
              ElevatedButton(
                child: isLoading
                    ? CircularProgressIndicator(color: Colors.black)
                    : Text(
                        'SUBMIT',
                        style: TextStyle(fontSize: 20.0),
                      ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  onPrimary: Colors.black,
                  padding: EdgeInsets.all(20.0),
                ),
                onPressed: () {
                  if (!isLoading) {
                    if (nameController.text.trim().isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please enter name.")));
                    } else {
                      addUser();
                    }
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> addUser() async {
    setState(() {
      isLoading = true;
    });
    Map<String, dynamic> map = {
      "name": nameController.text.trim(),
      "number": widget.number,
      "created_at": FieldValue.serverTimestamp(),
      "updated_at": FieldValue.serverTimestamp(),
    };
    await FirebaseFirestore.instance.collection(COLLECTION_USERS).doc(widget.userId).set(map);
    setState(() {
      isLoading = false;
    });
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (BuildContext context) => SelectTechnology()),
        ModalRoute.withName('/')
    );
    // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => SelectLanguage()));
  }
}
