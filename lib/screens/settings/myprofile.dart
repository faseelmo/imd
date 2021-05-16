import 'package:flutter/material.dart';
import 'package:imd/global.dart' as global;
import 'package:imd/sevices/auth.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:url_launcher/url_launcher.dart';

class Myprofile extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Settings',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 5.0,
        actions: <Widget>[],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Card(
            elevation: 3,
            margin: EdgeInsets.fromLTRB(10.0, 15, 10.0, 10),
            color: Colors.grey[00],
            child: Column(
              children: [
                Container(
                  //color: Colors.black,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.fromLTRB(0, 40, 0, 20),
                  child: CircleAvatar(
                    backgroundColor: Colors.amber[900],
                    radius: 90,
                    child: Text(
                      global.uemail.substring(0, 2).toUpperCase(),
                      style: TextStyle(
                          fontSize: 90,
                          fontWeight: FontWeight.w300,
                          color: Colors.white),
                    ), //Text
                  ), //CirlceAvatar
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                  alignment: Alignment.center,
                  child: TextButton.icon(
                      onPressed: () async {
                        await _auth.signOut();
                      },
                      icon: Icon(Icons.logout, color: Colors.indigo[900]),
                      label: Text('Log out',
                          style: TextStyle(
                            color: Colors.indigo[900],
                          ))),
                )
              ],
            ),
          ),
          Container(
            //elevation: 3,
            margin: EdgeInsets.fromLTRB(10.0, 15, 10.0, 10),
            color: Colors.grey[00],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  //color: Colors.black,
                  child: TextButton.icon(
                    icon: Icon(
                      Icons.bug_report_outlined,
                      color: Colors.blueGrey,
                    ),
                    label: Text('Report Bug',
                        style: TextStyle(
                          color: Colors.indigo[900],
                        )),
                    onPressed: () async {
                      final Email email = Email(
                        body: '',
                        subject: 'Bug / New Feature Report',
                        recipients: ['imd.cgpl@gmail.com'],
                        //cc: ['cc@example.com'],
                        //bcc: ['bcc@example.com'],
                        //attachmentPaths: ['/path/to/attachment.zip'],
                        isHTML: false,
                      );
                      await FlutterEmailSender.send(email);
                    },
                  ),
                  //CirlceAvatar
                ),
                Container(
                  //color: Colors.black,
                  child: TextButton.icon(
                    icon: Icon(
                      Icons.code_outlined,
                      color: Colors.blueGrey,
                    ),
                    label: Text('Source Code',
                        style: TextStyle(
                          color: Colors.indigo[900],
                        )),
                    onPressed: () async {
                      const url = 'https://github.com/faseelmo/imd';
                      if (await canLaunch(url)) {
                        await launch(url);
                      } else {
                        throw 'Could not launch $url';
                      }
                    },
                  ),
                  //CirlceAvatar
                ),

                //CirlceAvatar
              ],
            ),
          ),
          Container(
              margin: EdgeInsets.all(30),
              child: Text(
                'made with ❤️ from mundra',
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w300,
                    color: Colors.black),
              ))
        ],
      ),
    );
  }
}
