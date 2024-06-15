import 'package:Techwise/src/common/comman_strings.dart';
import 'package:Techwise/src/screens/chapter_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SelectTechnology extends StatelessWidget {
  const SelectTechnology({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(90.0),
          child: Text(
            "Techwise",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection(COLLECTION_TECHNOLOGY).snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            return Center(
              child: GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                children: snapshot.data.docs.map((document) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => ChapterListScreen(
                                    technology: document.data().containsKey(KEY_NAME) && document[KEY_NAME] != null
                                        ? document[KEY_NAME]
                                        : '',
                                  )));
                    },
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(border: Border.all(color: Colors.black, width: 1.0)),
                          child: Image.asset(
                            "assets/${document.data().containsKey(KEY_LOGO) && document[KEY_LOGO] != null ? document[KEY_LOGO] : 'default'}.jpg",
                            height: 100.0,
                            width: 100.0,
                          ),
                        ),
                        Text(
                          document.data().containsKey(KEY_NAME) && document[KEY_NAME] != null ? document[KEY_NAME] : '',
                          style: TextStyle(fontSize: 24.0),
                        )
                      ],
                    ),
                  );
                }).toList(),
              ),
            );
          }),
    );
  }
}
