import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:imd/models/noticemodel.dart';

class NoticeBoard extends StatefulWidget {
  @override
  _NoticeBoardState createState() => _NoticeBoardState();
}

class _NoticeBoardState extends State<NoticeBoard> {
  List<NoticeModel> _commentFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return NoticeModel(
        title: doc.data['title'] ?? '',
        content: doc.data['content'] ?? '',
      );
    }).toList();
  }

  final collectionReference = Firestore.instance.collection('notice');

  Stream<List<NoticeModel>> get stuff {
    return collectionReference.snapshots().map(_commentFromSnapshot);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new StreamBuilder(
          stream: Firestore.instance.collection("notice").snapshots(),
          builder: (context, snapshot) {
            if (snapshot.data == null) return Container();
            return new ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data.documents[index];

                  return Padding(
                    padding: EdgeInsets.fromLTRB(10, 6, 10, 0),
                    child: Card(
                      color: Colors.grey[900],
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.white70, width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      //margin: EdgeInsets.all(20.0),
                      child: Container(
                        margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Column(
                          children: <Widget>[
                            Text(
                              ds['title'],
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                            SizedBox(height: 10),
                            Text(ds['content'],
                                style: TextStyle(
                                  color: Colors.white,
                                )),
                          ],
                        ),
                      ),
                    ),
                  );
                });
          }),
    );
  }
}
