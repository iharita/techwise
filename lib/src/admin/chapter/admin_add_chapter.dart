import 'package:Techwise/src/common/comman_strings.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddChapterScreen extends StatefulWidget {
  final String technology;

  const AddChapterScreen({Key key, this.technology}) : super(key: key);

  @override
  _AddChapterScreenState createState() => _AddChapterScreenState();
}

class _AddChapterScreenState extends State<AddChapterScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController;
  TextEditingController indexController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    indexController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Chapter"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                controller: nameController,
                decoration: new InputDecoration(hintText: 'Chapter Name'),
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please enter valid Chapter Name";
                  } else {
                    return null;
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                controller: indexController,
                keyboardType: TextInputType.number,
                maxLength: 2,
                decoration: InputDecoration(hintText: 'Index of chapter', counter: SizedBox.shrink()),
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please enter valid index";
                  } else {
                    return null;
                  }
                },
              ),
            ),
            ElevatedButton(
              child: Text('Submit'),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  Map<String, dynamic> map = {
                    "name": nameController.text,
                    "technology": widget.technology,
                    "index": int.parse(indexController.text.toString()),
                    "created_at": FieldValue.serverTimestamp(),
                    "updated_at": FieldValue.serverTimestamp(),
                  };

                  ///Adding Data to Chapter Collection
                  FirebaseFirestore.instance.collection(COLLECTION_CHAPTER).add(map).then((docRef) {
                    ///Adding Document ID to Chapter document for future use (ex: retrieve topic for that chapter)
                    FirebaseFirestore.instance
                        .collection(COLLECTION_CHAPTER)
                        .doc(docRef.id)
                        .set({'chapter_id': docRef.id.toString()}, SetOptions(merge: true));
                  });
                  nameController.clear();
                  indexController.clear();

                  var snackBar = SnackBar(content: Text('Chapter Added Successfully!'));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
