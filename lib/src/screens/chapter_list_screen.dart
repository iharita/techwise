import 'package:Techwise/src/common/comman_strings.dart';
import 'package:Techwise/src/screens/topic_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChapterListScreen extends StatefulWidget {
  final String technology;

  const ChapterListScreen({Key key, this.technology}) : super(key: key);

  @override
  State<ChapterListScreen> createState() => _ChapterListScreenState();
}

class _ChapterListScreenState extends State<ChapterListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.technology + " Chapters"),
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back)),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection(COLLECTION_CHAPTER)
              .orderBy("index")
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            return ListView(
              children: snapshot.data.docs
                  .where((e) => e.get("technology") == widget.technology)
                  .map((document) {
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Text("#" +
                          document[KEY_INDEX].toString() +
                          ". " +
                          (document.data().containsKey(KEY_NAME) &&
                                  document[KEY_NAME] != null
                              ? document[KEY_NAME]
                              : '')),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) => TopicListScreen(
                                  chapterId: document["chapter_id"],
                                  chapterIndex: "#"+document[KEY_INDEX].toString(),
                                )));
                      },
                    ),
                  ),
                );
              }).toList(),
            );
          }),
    );
  }
}
//added comment
