import 'package:flutter/material.dart';
import 'package:imd/sevices/auth.dart';
import 'package:imd/models/imd.dart';

class Account extends StatelessWidget {
  final AuthService _auth = AuthService();
  final Imd data;
  Account({this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(''),
          backgroundColor: Colors.grey[50],
          elevation: 0.0,
        ),
        body: Container(
            child: Center(
          child: FlatButton.icon(
              onPressed: () async {
                await _auth.signOut();
              },
              icon: Icon(Icons.person),
              label: Text('logout')),
        )));
  }
}
