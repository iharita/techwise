import 'package:Techwise/src/admin/chapter/admin_chapter_screen.dart';
import 'package:Techwise/src/admin/technology/admin_add_technology.dart';
import 'package:Techwise/src/common/comman_strings.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminTechnologyScreen extends StatelessWidget {
  const AdminTechnologyScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Technologies"),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection(COLLECTION_TECHNOLOGY).snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            return ListView(
              children: snapshot.data.docs.map((document) {
                return document.data().containsKey(KEY_NAME) && document[KEY_NAME] != null
                    ? ListTile(
                        title: Text(document[KEY_NAME]),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  AdminChapterListScreen(technology: document[KEY_NAME])));
                        },
                      )
                    : Container();
              }).toList(),
            );
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => AddTechnologyScreen()));
        },
      ),
    );
  }
}
