import 'package:Techwise/src/admin/topic/admin_add_topic.dart';
import 'package:Techwise/src/common/comman_strings.dart';
import 'package:Techwise/src/common/youtube_player/youtube_player_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminTopicListScreen extends StatefulWidget {
  final String chapterId;

  const AdminTopicListScreen({Key key, this.chapterId}) : super(key: key);

  @override
  State<AdminTopicListScreen> createState() => _AdminTopicListScreenState();
}

class _AdminTopicListScreenState extends State<AdminTopicListScreen> {
  bool isEnglish = true;
  int _radioSelected = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chapter " + widget.chapterId),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: RadioListTile(
                      value: 1,
                      groupValue: _radioSelected,
                      activeColor: Colors.blue,
                      onChanged: (value) {
                        setState(() {
                          _radioSelected = value;
                          isEnglish = true;
                        });
                      },
                      title: Text('English')),
                ),
                Expanded(
                  child: RadioListTile(
                      value: 2,
                      groupValue: _radioSelected,
                      activeColor: Colors.pink,
                      onChanged: (value) {
                        setState(() {
                          _radioSelected = value;
                          isEnglish = false;
                        });
                      },
                      title: Text('Hindi')),
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection(COLLECTION_TOPIC)
                    .orderBy("index")
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return ListView(
                    children: snapshot.data.docs
                        .where((e) =>
                            e.get("chapter_id") == widget.chapterId &&
                            e.get('language') ==
                                (_radioSelected == 1 ? 'EN' : 'HI'))
                        .map((document) {
                      return ListTile(
                        title: Text(document[KEY_INDEX].toString() +
                            ". " +
                            (document.data().containsKey(KEY_NAME) &&
                                    document[KEY_NAME] != null
                                ? document[KEY_NAME]
                                : '')),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  YoutubePlayerScreen(
                                    url: document["vid_url"],
                                  )));
                        },
                      );
                    }).toList(),
                  );
                }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => AddTopicScreen(
                    chapterId: widget.chapterId,
                  )));
        },
      ),
    );
  }
}
//added comment
