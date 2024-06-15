import 'package:Techwise/src/admin/chapter/admin_add_chapter.dart';
import 'package:Techwise/src/admin/topic/admin_topic_screen.dart';
import 'package:Techwise/src/common/comman_strings.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminChapterListScreen extends StatefulWidget {
  final String technology;

  const AdminChapterListScreen({Key key, this.technology}) : super(key: key);

  @override
  State<AdminChapterListScreen> createState() => _AdminChapterListScreenState();
}

class _AdminChapterListScreenState extends State<AdminChapterListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.technology + " Chapters"),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection(COLLECTION_CHAPTER).orderBy("index").snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            return ListView(
              children: snapshot.data.docs.where((e) => e.get("technology") == widget.technology).map((document) {
                return ListTile(
                  title: Text(document[KEY_INDEX].toString() +
                      ". " +
                      (document.data().containsKey(KEY_NAME) && document[KEY_NAME] != null ? document[KEY_NAME] : '')),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => AdminTopicListScreen(
                              chapterId: document["chapter_id"],
                            )));
                  },
                );
              }).toList(),
            );
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => AddChapterScreen(
                    technology: widget.technology,
                  )));
        },
      ),
    );
  }
}
//added comment
