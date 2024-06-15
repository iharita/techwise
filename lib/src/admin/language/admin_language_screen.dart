
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminLanguageScreen extends StatelessWidget {
  const AdminLanguageScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Languages"),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("Languages").snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            return ListView(
              children: snapshot.data.docs.map((document) {
                return ListTile(
                  title: Text(document.data().containsKey('title') &&
                      document['title'] != null
                      ? document['title']
                      : ''),
                  // subtitle: Text((document.data().containsKey('description') &&
                  //     document['description'] != null
                  //     ? document['description']
                  //     : '') +
                  //     '\n' +
                  //     (document.data().containsKey('url') &&
                  //         document['url'] != null
                  //         ? document['url']
                  //         : '')),
                  // isThreeLine: true,
                );
              }).toList(),
            );
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => AdminLanguageScreen()));
        },
      ),
    );
  }
}
