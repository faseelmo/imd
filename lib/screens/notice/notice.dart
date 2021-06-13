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
      appBar: AppBar(
        title: Text(
          'Notice Board',
          style: TextStyle(color: Colors.grey[900]),
        ),
        backgroundColor: Colors.grey[50],
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              flex: 1,
              fit: FlexFit.loose,
              child: new StreamBuilder(
                  stream: Firestore.instance.collection("notice").snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.data == null) return Container();
                    return new ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot ds = snapshot.data.documents[index];

                          return Card(
                            margin: EdgeInsets.fromLTRB(15.0, 5, 15.0, 5),
                            color: Colors.blueGrey[900],
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.white70, width: 1),
                              borderRadius: BorderRadius.circular(7),
                            ),
                            //margin: EdgeInsets.all(20.0),
                            child: Container(
                              margin: EdgeInsets.fromLTRB(15, 15, 15, 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                          );
                        });
                  }),
            ),

            Flexible(
              flex: 1,
              fit: FlexFit.loose,
              child: new StreamBuilder(
                  stream: Firestore.instance.collection("events").snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.data == null) return Container();
                    return new ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot ds = snapshot.data.documents[index];

                          return Card(
                            margin: EdgeInsets.fromLTRB(15.0, 5, 15.0, 5),
                            color: Colors.red[900],
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.white70, width: 1),
                              borderRadius: BorderRadius.circular(7),
                            ),
                            //margin: EdgeInsets.all(20.0),
                            child: Container(
                              margin: EdgeInsets.fromLTRB(15, 15, 15, 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    ds['name'],
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                      "Total Job Done " +
                                          ds['total'].toString(),
                                      style: TextStyle(
                                        color: Colors.white,
                                      )),
                                ],
                              ),
                            ),
                          );
                        });
                  }),
            ),

            //START POSTER
            Flexible(
                flex: 1,
                fit: FlexFit.loose,
                child: Card(
                  margin: EdgeInsets.fromLTRB(15.0, 10, 15.0, 5),
                  color: Colors.teal[600],
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.white70, width: 1),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          'Star Posters 🏆',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                      Flexible(
                        child: new StreamBuilder(
                            stream: Firestore.instance
                                .collection("users")
                                .orderBy('count', descending: true)
                                .limit(5)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.data == null) return Container();
                              return new ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: snapshot.data.documents.length,
                                  itemBuilder: (context, index) {
                                    DocumentSnapshot dp =
                                        snapshot.data.documents[index];

                                    return Container(
                                      //color: Colors.blue[700],
                                      margin: EdgeInsets.fromLTRB(20, 5, 20, 5),
                                      child: Row(
                                        //crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          SizedBox(height: 10),
                                          Text(dp['name'].toString(),
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                              )),
                                          Spacer(),
                                          Text(
                                            dp['count'].toString(),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                        ],
                                      ),
                                    );
                                  });
                            }),
                      ),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
