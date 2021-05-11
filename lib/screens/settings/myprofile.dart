import 'package:flutter/material.dart';
import 'package:imd/global.dart' as global;
import 'package:imd/sevices/auth.dart';

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
      body: SingleChildScrollView(
          child: Column(
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: [
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
                      label: Text('logout',
                          style: TextStyle(
                            color: Colors.indigo[900],
                          ))),
                )
              ],
            ),
          ),
        ],
      )),
    );
  }
}
