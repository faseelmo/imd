import 'package:flutter/material.dart';
import 'package:imd/screens/bottom%20tabs/tabspage.dart';
import 'package:imd/shared/loading.dart';
import 'package:imd/sevices/database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:imd/models/imd.dart';
import 'package:imd/global.dart' as global;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:imd/models/comments.dart';

class CommentHome extends StatefulWidget {
  final Imd postid;
  CommentHome({Key key, @required this.postid}) : super(key: key);

  @override
  _CommentHomeState createState() => _CommentHomeState();
}

class _CommentHomeState extends State<CommentHome> {
  bool loading = false;

  String comment = '';

  final collectionReference = Firestore.instance.collection('imd');
  Future updateComment(String comment, DateTime date, String uemail) async {
    return await collectionReference
        .document(widget.postid.docId)
        .collection('comments')
        .document()
        .setData({
      'comment': comment,
      'uemail': uemail,
      'date': date,
      /* 'docId': document Id here*/
    });
  }

  List<Comments> _commentFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Comments(
        comment: doc.data['comment'] ?? '',
        uemail: doc.data['uemail'] ?? '',
      );
    }).toList();
  }

  Stream<List<Comments>> get stuff {
    return collectionReference
        .document(widget.postid.docId)
        .collection('comments')
        .orderBy('date', descending: true)
        .snapshots()
        .map(_commentFromSnapshot);
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            resizeToAvoidBottomPadding: false,
            backgroundColor: Colors.white,
            appBar: AppBar(
              iconTheme: IconThemeData(color: Colors.black),
              title: Text(
                'Edit Screen',
                style: TextStyle(color: Colors.black),
              ),
              backgroundColor: Colors.white,
              elevation: 5.0,
              actions: <Widget>[
                IconButton(
                    icon: Icon(
                      Icons.delete,
                    ),
                    onPressed: () async {
                      if (global.uemail == widget.postid.uemail) {
                        return showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Delete'),
                                content: SingleChildScrollView(
                                  child: ListBody(
                                    children: <Widget>[
                                      Text(
                                          'Are you sure you want to delete this post?'),
                                    ],
                                  ),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text('Yes'),
                                    onPressed: () async {
                                      setState(() => loading = true);
                                      if (widget.postid.url != "") {
                                        print("DATA.URL HERE LOOK " +
                                            widget.postid.url);
                                        FirebaseStorage.instance
                                            .getReferenceFromUrl(
                                                widget.postid.url)
                                            .then(
                                              (reference) => reference.delete(),
                                            )
                                            .catchError((e) => print(e));
                                      }

                                      if (widget.postid.docId != "") {
                                        await DatabaseService()
                                            .deletePost(widget.postid.docId);
                                      }

                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Tabs()));
                                    },
                                  ),
                                  TextButton(
                                    child: Text('No'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            });
                      } else {
                        return showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Alert'),
                                content: SingleChildScrollView(
                                  child: ListBody(
                                    children: <Widget>[
                                      Text('Only OP can delete content'),
                                    ],
                                  ),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text('Cancel'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            });
                      }

                      /* ADD LOADING HERE LOL 

                      if (widget.postid != "") {
                        await DatabaseService().deletePost(widget.postid);
                      }
                      */
                    })
              ],
            ),
            body: new StreamBuilder(
                stream: Firestore.instance
                    .collection("imd")
                    .document(widget.postid.docId)
                    .collection('comments')
                    .orderBy('date', descending: false)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.data == null) return Container();
                  return new ListView.builder(
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot ds = snapshot.data.documents[index];

                        return Card(
                          child: Container(
                            color: Colors.white,
                            height: 70,
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.all(10),
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  ds['uemail']
                                      .substring(0, ds['uemail'].indexOf("@")),
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  ds['comment'],
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                }),
            bottomNavigationBar: Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Container(
                margin: EdgeInsets.fromLTRB(5, 0, 0, 5),
                child: TextField(
                  onChanged: (val) {
                    setState(() => comment = val);
                    print("comment is " + comment);
                  },
                  cursorColor: Theme.of(context).cursorColor,
                  obscureText: false,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.red,
                    )),
                    labelText: 'Comments',
                    suffixIcon: IconButton(
                        icon: Icon(
                          Icons.chevron_right,
                        ),
                        onPressed: () async {
                          loading = true;
                          DateTime osdate = DateTime.now();

                          await updateComment(comment, osdate, global.uemail);

                          Navigator.pop(context);
                        }),
                  ),
                ),
              ),
            ));
  }
}
