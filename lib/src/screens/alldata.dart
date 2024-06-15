import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AllData extends StatefulWidget {
  const AllData({Key key}) : super(key: key);

  @override
  _AllDataState createState() => _AllDataState();
}

class _AllDataState extends State<AllData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("Chapters").snapshots(),
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
    );
  }
}
