import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:imd/global.dart';
import 'package:imd/models/imd.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:csv/csv.dart';

import 'package:path_provider/path_provider.dart';

class CsvHome extends StatefulWidget {
  @override
  _CsvHomeState createState() => _CsvHomeState();
}

final collectionReference = Firestore.instance.collection('imd');

List<Imd> _imdListFromSnapshot(QuerySnapshot snapshot) {
  return snapshot.documents.map((doc) {
    return Imd(
        area: doc.data['area'] ?? '',
        group: doc.data['group'] ?? '',
        equipment: doc.data['equipment'] ?? '',
        activity: doc.data['activity'] ?? '',
        optional: doc.data['optional'] ?? '',
        url: doc.data['url'] ?? '',
        uemail: doc.data['uemail'] ?? '',
        docId: doc.data['docId'] ?? '',
        date: doc.data['date'] ?? '');
  }).toList();
}

Stream<List<Imd>> get imd {
  return collectionReference
      .orderBy('osdate', descending: true)
      .snapshots()
      .map(_imdListFromSnapshot);
}

Future<List<Imd>> details() async {
  List list = await imd.first;
  //List list2 = List.generate(list.length, (i) => List(8), growable: false);
  //List list2;

  List<List<dynamic>> rows = List<List<dynamic>>();
  rows.add([
    "Name",
    "Gender",
    "Phone Number",
    "Email",
    "Age",
    "Area",
    "Assembly",
    "Meal Ticket"
  ]);

  for (var i = 0; i < list.length; i++) {
    List<dynamic> row = List<dynamic>();
    Map<String, dynamic> yolo = list[i].toMap();
    List values = yolo.values.toList();
    for (var j = 0; j < 8; j++) {
      row.add(values[j]);
    }
    rows.add(row);
  }

  print("Printing Rows");
  print(rows);

  //for (var i = 0; i < list.length; i++) {
  //Map<String, dynamic> yolo = list[i].toMap();
  //List values = yolo.values.toList();
  //list2[i] = values;
  //for (var j = 0; j < 8; j++) {
  //list2[i][j] = values[j];
  //}
  //}
  //File f = await _localFile;

  String csv = const ListToCsvConverter().convert(rows);
  print("Printing csv");
  print(csv);
  //f.writeAsString(csv);
  //String csv = const ListToCsvConverter().convert(list2);
  //print(rows);
}

class _CsvHomeState extends State<CsvHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                  child: Column(children: <Widget>[
                    SizedBox(height: 20.0),
                    RaisedButton(
                        color: Colors.blueGrey[600],
                        child: Text(
                          "Export as Excel",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          //print(details());
                          details();
                          //Export the firestore data to a csv file
                        })
                  ]),
                ),
              ),
            ],
          ),
        ));
  }
}
