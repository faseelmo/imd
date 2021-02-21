import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:imd/models/imd.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:imd/screens/settings/accountservice.dart';
import 'package:imd/global.dart' as global;

// ignore: must_be_immutable
class Accountdatatile extends StatelessWidget {
  final Imd data;
  Accountdatatile({this.data});

  String uemail = "";

  final databaseReference = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    print("LOOK HERE FOR GLOBAL EMAIL" +
        global.uemail +
        "\n data email is" +
        data.uemail);
    if (global.uemail == data.uemail) {
      print("THE PROPHECY IS TRUE YALL");
    }

    return Padding(
      padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
      child: GestureDetector(
        onTap: () async {
          /*This can be deleted in future I think */

          if (global.uemail == data.uemail) {
            return showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Delete'),
                    content: SingleChildScrollView(
                      child: ListBody(
                        children: <Widget>[
                          Text('Would you like to delete this post?'),
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: Text('Yes'),
                        onPressed: () async {
                          if (data.url != "") {
                            print("DATA.URL HERE LOOK " + data.url);
                            FirebaseStorage.instance
                                .getReferenceFromUrl(data.url)
                                .then(
                                  (reference) => reference.delete(),
                                )
                                .catchError((e) => print(e));
                          }

                          if (data.docId != "") {
                            await AccountServices().deletePost(data.docId);
                          }

                          Navigator.of(context).pop();
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

          /*Navigator.push(
              context, MaterialPageRoute(builder: (context) => EditHome()));*/
        },
        child: Card(
            margin: EdgeInsets.fromLTRB(20.0, 0, 20.0, 5),
            child: Column(
              children: [
                global.uemail == data.uemail
                    ? Container(
                        color: Colors.blueGrey[100],
                        height: 40,
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.all(10),
                        width: double.infinity,
                        child: Text.rich(TextSpan(children: <TextSpan>[
                          TextSpan(
                              text: data.uemail
                                  .substring(0, data.uemail.indexOf("@")),
                              style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  color: Colors.black87)),
                          TextSpan(
                              text: '',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ])),
                      )
                    : Container(
                        color: Colors.white,
                        height: 40,
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.all(10),
                        width: double.infinity,
                        child: Text.rich(TextSpan(children: <TextSpan>[
                          TextSpan(
                              text: data.uemail
                                  .substring(0, data.uemail.indexOf("@")),
                              style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  color: Colors.black87)),
                          TextSpan(
                              text: '',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ])),
                      ),
                data.url != ''
                    ? CachedNetworkImage(
                        imageUrl: data.url,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                                CircularProgressIndicator(
                                    value: downloadProgress.progress),
                      )
                    : Container(
                        height: 1,
                        color: Colors.blueGrey[900],
                      ),
                /*Image.network(data.url, width: double.infinity), */
                Container(
                  height: 40,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.all(10),
                  width: double.infinity,
                  child: Text.rich(TextSpan(children: <TextSpan>[
                    TextSpan(
                        text: data.date,
                        /*data.uemail.substring(0, data.uemail.indexOf("@")),*/
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Colors.black54)),
                    TextSpan(
                        text: '',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ])),
                ),
                ListTile(
                  title: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: data.activity != '' && data.group != ''
                        ? Text('${data.activity} (${data.group})')
                        : Text('${data.activity} ${data.group}'),
                  ),
                  subtitle: data.equipment != '' && data.area != ''
                      ? Text("${data.equipment} in ${data.area}")
                      : Text("${data.equipment}${data.area}"),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: data.optional != ''
                        ? Padding(
                            padding: const EdgeInsets.fromLTRB(16.0, 4, 12, 5),
                            child: Text('${data.optional}',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.6))),
                          )
                        : null,
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
