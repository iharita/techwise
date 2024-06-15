import 'package:Techwise/src/common/comman_strings.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddTopicScreen extends StatefulWidget {
  final String chapterId;

  const AddTopicScreen({Key key, this.chapterId}) : super(key: key);

  @override
  _AddTopicScreenState createState() => _AddTopicScreenState();
}

class _AddTopicScreenState extends State<AddTopicScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController;
  TextEditingController indexController;
  TextEditingController videoURLController;
  TextEditingController descriptionController;
  bool isEnglish = true;
  int _radioSelected = 1;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    indexController = TextEditingController();
    videoURLController = TextEditingController();
    descriptionController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Topic"),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  controller: nameController,
                  decoration: new InputDecoration(hintText: 'Topic Name'),
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please enter valid Topic Name";
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
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  controller: videoURLController,
                  decoration: InputDecoration(hintText: 'Video URL'),
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please enter valid URL";
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  controller: descriptionController,
                  decoration: new InputDecoration(hintText: 'Description'),
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please enter valid Description";
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('English'),
                    Radio(
                      value: 1,
                      groupValue: _radioSelected,
                      activeColor: Colors.blue,
                      onChanged: (value) {
                        setState(() {
                          _radioSelected = value;
                          isEnglish = true;
                        });
                      },
                    ),
                    Text('Hindi'),
                    Radio(
                      value: 2,
                      groupValue: _radioSelected,
                      activeColor: Colors.pink,
                      onChanged: (value) {
                        setState(() {
                          _radioSelected = value;
                          isEnglish = false;
                        });
                      },
                    )
                  ],
                ),
              ),
              ElevatedButton(
                child: Text('Submit'),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    Map<String, dynamic> map = {
                      "name": nameController.text,
                      "chapter_id": widget.chapterId,
                      "vid_url": videoURLController.text,
                      "description": descriptionController.text,
                      "language": isEnglish ? "EN" : "HI",
                      "index": int.parse(indexController.text.toString()),
                      "created_at": FieldValue.serverTimestamp(),
                      "updated_at": FieldValue.serverTimestamp(),
                    };

                    ///Adding Data to Chapter Collection
                    FirebaseFirestore.instance.collection(COLLECTION_TOPIC).add(map).then((docRef) {
                      ///Adding Document ID to Topic document for future use
                      FirebaseFirestore.instance
                          .collection(COLLECTION_TOPIC)
                          .doc(docRef.id)
                          .set({'topic_id': docRef.id.toString()}, SetOptions(merge: true));
                    });
                    nameController.clear();
                    indexController.clear();
                    videoURLController.clear();
                    descriptionController.clear();
                    var snackBar = SnackBar(content: Text('Chapter Added Successfully!'));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
