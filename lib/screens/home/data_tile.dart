import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:imd/models/imd.dart';
import 'package:imd/screens/Comments/CommentHome.dart';
import 'package:imd/global.dart' as global;

// ignore: must_be_immutable
class DataTile extends StatelessWidget {
  final Imd data;

  DataTile({this.data});

  String uemail = "";

  @override
  Widget build(BuildContext context) {
    if (global.uemail == data.uemail) {
      print("global.uemail == data.uemail");
    }

    print("data.uemail is " + data.uemail);
    print(data.group);

    return Padding(
      padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
      child: GestureDetector(
        onTap: () async {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CommentHome(postid: data)));
        },
        child: Card(
            elevation: 2,
            margin: EdgeInsets.fromLTRB(20.0, 0, 20.0, 5),
            child: Column(
              children: [
                Container(
                  color: Colors.white,
                  height: 40,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.all(10),
                  width: double.infinity,
                  child: Text.rich(TextSpan(children: <TextSpan>[
                    TextSpan(
                        text:
                            data.uemail.substring(0, data.uemail.indexOf("@")),
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
