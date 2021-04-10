import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:imd/models/imd.dart';
import 'package:csv/csv.dart';
import 'package:dio/dio.dart';
import 'package:ext_storage/ext_storage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:imd/global.dart' as global;
import 'package:intl/intl.dart';

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
      .where('uemail', isEqualTo: global.selecteduser)
      .where('osdate', isGreaterThanOrEqualTo: global.fromDate)
      .snapshots()
      .map(_imdListFromSnapshot);
}

var dio = Dio();

Future details() async {
  List list = await imd.first;

  //List list2 = List.generate(list.length, (i) => List(8), growable: false);
  //List list2;

  List<List<dynamic>> rows = [];
  rows.add([
    "Employee",
    "Area",
    "Group",
    "Equipment",
    "Activity",
    "Description",
    "Unique ID",
    "Date"
  ]);

  for (var i = 0; i < list.length; i++) {
    List<dynamic> row = [];
    Map<String, dynamic> yolo = list[i].toMap();
    List values = yolo.values.toList();
    for (var j = 0; j < 8; j++) {
      row.add(values[j]);
    }
    rows.add(row);
  }

  print("Printing Rows");
  //print(rows);

  String csv = const ListToCsvConverter().convert(rows);
  print("Printing csv");
  print(csv);
  final directory = ExtStorage.getExternalStoragePublicDirectory(
      ExtStorage.DIRECTORY_DOWNLOADS);
  Map<PermissionGroup, PermissionStatus> permissions =
      await PermissionHandler().requestPermissions([PermissionGroup.storage]);
  PermissionStatus permission =
      await PermissionHandler().checkPermissionStatus(PermissionGroup.storage);
  print("permission is $permission");
  final pathOfTheFileToWrite = await directory + "/CsvFile.csv";
  print("directory is $pathOfTheFileToWrite");
  File file = File(pathOfTheFileToWrite);
  file.writeAsString(csv);
}

class _CsvHomeState extends State<CsvHome> {
  DateTime fromDate;
  DateTime toDate;
  String fromDateString = '';
  String toDateString = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            'Export to Excel',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          elevation: 5.0,
        ),
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Form(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.all(0),
                            child: Container(
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                  SizedBox(
                                    height: 100,
                                  ),
                                  ElevatedButton(
                                    //shape: RoundedRectangleBorder(
                                    //borderRadius:
                                    //BorderRadius.circular(2.0)),
                                    //elevation: 0,
                                    onPressed: () {
                                      showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime(2018),
                                              lastDate: DateTime(2030))
                                          .then((date) {
                                        setState(() {
                                          fromDate = date;
                                          fromDateString =
                                              DateFormat('dd-MM-yyyy')
                                                  .format(fromDate);
                                        });
                                      });
                                    },
                                    child: Container(
                                      //color: Colors.yellow,
                                      //alignment: Alignment.center,
                                      height: 60.0,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Icon(
                                                  Icons.date_range,
                                                  size: 25.0,
                                                  color: Colors.grey[700],
                                                ),
                                                Text(
                                                  '    From ',
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            //color: Colors.red,
                                            child: Row(
                                              children: <Widget>[
                                                Text(
                                                  fromDateString,
                                                  style: TextStyle(
                                                    color: Colors.grey[700],
                                                    //fontWeight: FontWeight.bold,
                                                    //fontSize: 30.0
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    //color: Colors.grey[50],
                                  ),
                                ]))),
                        SizedBox(height: 20.0),
                        ElevatedButton(
                            child: Text(
                              "Export",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () async {
                              global.fromDate = fromDate;

                              if (global.security == "1") {
                                global.selecteduser = null;
                              } else {
                                global.selecteduser = global.uemail;
                              }
                              //print(details());
                              await details();
                              print("Faseel look here for Global Security");
                              print(global.security);
                              Navigator.pop(context);
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Export Completed'),
                                      content: SingleChildScrollView(
                                        child: ListBody(
                                          children: <Widget>[
                                            Text(
                                                'Exported to Downloads folder'),
                                          ],
                                        ),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          child: Text('Ok'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  });
                              //Export the firestore data to a csv file
                            }),
                      ]),
                ),
              ),
            ],
          ),
        ));
  }
}
