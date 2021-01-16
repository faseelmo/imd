import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:imd/shared/loading.dart';

class EditHome extends StatefulWidget {
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
              actions: <Widget>[],
            ),
            body: Container(
              child: Center(
                child: Text('Coming Soon :^)'),
              ),
            ),
          );
  }
}
