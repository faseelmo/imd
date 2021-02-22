import 'package:flutter/material.dart';
import 'package:imd/screens/bottom%20tabs/tabspage.dart';
import 'package:imd/shared/loading.dart';
import 'package:imd/sevices/database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:imd/models/imd.dart';
import 'package:imd/global.dart' as global;

class EditHome extends StatefulWidget {
  final Imd postid;
  EditHome({Key key, @required this.postid}) : super(key: key);

  @override
  _EditHomeState createState() => _EditHomeState();
}

class _EditHomeState extends State<EditHome> {
  bool loading = false;

  String area = '';
  String group = '';
  String equipment = '';
  String activity = '';
  String optional = '';

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
            body: Container(
              child: Center(
                child: Text("YOLO"),
              ),
            ),
            bottomNavigationBar: Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Container(
                margin: EdgeInsets.fromLTRB(5, 0, 0, 5),
                child: TextField(
                  cursorColor: Theme.of(context).cursorColor,
                  obscureText: false,
                  decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.red,
                      )),
                      labelText: 'Comments',
                      suffixIcon: Icon(Icons.comment)),
                ),
              ),
            ),
          );
  }
}
