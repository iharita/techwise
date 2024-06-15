import 'package:Techwise/src/admin/topic/admin_add_topic.dart';
import 'package:Techwise/src/common/comman_strings.dart';
import 'package:Techwise/src/common/youtube_player/youtube_player_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TopicListScreen extends StatefulWidget {
  final String chapterId;
  final String chapterIndex;

  const TopicListScreen({Key key, this.chapterId, this.chapterIndex})
      : super(key: key);

  @override
  State<TopicListScreen> createState() => _TopicListScreenState();
}

class _TopicListScreenState extends State<TopicListScreen> {
  bool isEnglish = true;
  int _radioSelected = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chapter " + widget.chapterIndex),
        backgroundColor: _radioSelected == 1 ? Colors.blue : Colors.pink,
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
                  final List<DocumentSnapshot> userList = snapshot.data.docs;
                  userList.retainWhere(
                      (element) => element['chapter_id'] == widget.chapterId);
                  return ListView(
                    children: userList
                        .where((element) =>
                            element.get('language') ==
                            (_radioSelected == 1 ? 'EN' : 'HI'))
                        .map((document) {
                      return Card(
                        margin:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            title: Text(document[KEY_INDEX].toString() +
                                ". " +
                                (document.data().containsKey(KEY_NAME) &&
                                        document[KEY_NAME] != null
                                    ? document[KEY_NAME]
                                    : '')),
                            subtitle:
                                Text(document[KEY_DESCRIPTION].toString()),
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      YoutubePlayerScreen(
                                        url: document["vid_url"],
                                      )));
                            },
                          ),
                        ),
                      );
                    }).toList(),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
//added comment
