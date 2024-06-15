import 'package:Techwise/src/common/comman_strings.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddTechnologyScreen extends StatefulWidget {
  const AddTechnologyScreen({Key key}) : super(key: key);

  @override
  _AddTechnologyScreenState createState() => _AddTechnologyScreenState();
}

class _AddTechnologyScreenState extends State<AddTechnologyScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Technology"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: controller,
              validator: (value) {
                if (value.isEmpty) {
                  return "Please enter valid technology";
                } else {
                  return null;
                }
              },
            ),
            ElevatedButton(
              child: Text('Submit'),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  Map<String, dynamic> map = {
                    "name": controller.text,
                    "logo": controller.text.toLowerCase()+"_logo",
                    "created_at": FieldValue.serverTimestamp(),
                    "updated_at": FieldValue.serverTimestamp(),
                  };
                  FirebaseFirestore.instance.collection(COLLECTION_TECHNOLOGY).add(map);
                  controller.clear();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
