import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:csv/csv.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';

class NotAnalytics extends StatefulWidget {
  @override
  _NotAnalyticsState createState() => _NotAnalyticsState();
}

class _NotAnalyticsState extends State<NotAnalytics> {
  DateTime fromDate;
  DateTime toDate;
  String fromDateString = '';
  String toDateString = '';

  String filePath;

  Future<String> get _localPath async {
    final directory = await getApplicationSupportDirectory();
    return directory.absolute.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    filePath = '$path/data.csv';
    return File('$path/data.csv').create();
  }

  final collectionReference = Firestore.instance.collection('imd');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(''),
          backgroundColor: Colors.grey[50],
          elevation: 0.0,
        ),
        body: Container(
          child: Column(
            children: [
              Form(
                  child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                child: Column(
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.all(0),
                        child: Container(
                            child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                              ElevatedButton(
                                //shape: RoundedRectangleBorder(
                                //borderRadius: BorderRadius.circular(2.0)),
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
                                      fromDateString = DateFormat('dd-MM-yyyy')
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

                    ///

                    Padding(
                        padding: const EdgeInsets.all(0),
                        child: Container(
                            child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                              ElevatedButton(
                                //: RoundedRectangleBorder(
                                //borderRadius: BorderRadius.circular(2.0)),
                                //elevation: 0,
                                onPressed: () {
                                  showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(2018),
                                          lastDate: DateTime(2030))
                                      .then((date) {
                                    setState(() {
                                      toDate = date;

                                      toDateString = DateFormat('dd-MM-yyyy')
                                          .format(toDate);
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
                                              '    To ',
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        //color: Colors.red,
                                        child: Row(
                                          children: <Widget>[
                                            Text(
                                              toDateString,
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
                    ElevatedButton(
                        //color: Colors.blueGrey[600],
                        child: Text(
                          "Export as Excel",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          List<List<dynamic>> rows = [];

                          var cloud = await Firestore.instance
                              .collection("datum")
                              .document("data")
                              .get();

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

                          if (cloud.data != null) {
                            for (int i = 0;
                                i < cloud.data["collected"].length;
                                i++) {
                              List<dynamic> row = [];
                              row.add(cloud.data["collected"][i]["name"]);
                              row.add(cloud.data["collected"][i]["gender"]);
                              row.add(cloud.data["collected"][i]["phone"]);
                              row.add(cloud.data["collected"][i]["email"]);
                              row.add(
                                  cloud.data["collected"][i]["age_bracket"]);
                              row.add(cloud.data["collected"][i]["area"]);
                              row.add(cloud.data["collected"][i]["assembly"]);
                              row.add(
                                  cloud.data["collected"][i]["meal_ticket"]);
                              rows.add(row);
                            }

                            File f = await _localFile;

                            String csv =
                                const ListToCsvConverter().convert(rows);
                            f.writeAsString(csv);
                          }
                        })
                  ],
                ),
              ))
            ],
          ),
        ));
  }
}
