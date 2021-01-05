import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:imd/screens/bottom%20tabs/tabspage.dart';
import 'package:imd/sevices/database.dart';
import 'package:imd/shared/loading.dart';

class DataPage extends StatefulWidget {
  @override
  _DataPageState createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {
  bool loading = false;

  String area = '';
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
                'Add data',
                style: TextStyle(color: Colors.black),
              ),
              backgroundColor: Colors.white,
              elevation: 5.0,
              actions: <Widget>[],
            ),
            body: Form(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                child: Column(children: <Widget>[
                  SizedBox(height: 20.0),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      hintText: 'Area',
                      fillColor: Colors.grey[50],
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.grey[50], width: 2.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blueGrey[300])),
                    ),
                    items: <String>[
                      'Boiler 1',
                      'Boiler 2',
                      'Feed Cycle',
                      'BOP',
                      'CHP',
                      'Turbine',
                      'DCS',
                      'IT'
                    ].map((String value) {
                      return new DropdownMenuItem<String>(
                        value: value,
                        child: new Text(value),
                      );
                    }).toList(),
                    onChanged: (val) {
                      setState(() => area = val);
                    },
                  ),
                  SizedBox(height: 10.0),
                  TextFormField(
                    onChanged: (val) {
                      setState(() => equipment = val);
                    },
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
                      hintText: 'Equipment',
                      fillColor: Colors.grey[50],
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.grey[50], width: 2.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blueGrey[300])),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      hintText: 'Activity',
                      fillColor: Colors.grey[50],
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.grey[50], width: 2.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blueGrey[300])),
                    ),
                    items: <String>[
                      'Simulation',
                      'Replacement',
                      'Set Point Change',
                      'PM',
                      'Calibration',
                      'Improvement',
                      'New Installation'
                    ].map((String value) {
                      return new DropdownMenuItem<String>(
                        value: value,
                        child: new Text(value),
                      );
                    }).toList(),
                    onChanged: (val) {
                      setState(() => activity = val);
                    },
                  ),
                  SizedBox(height: 10.0),
                  TextFormField(
                    onChanged: (val) {
                      setState(() => optional = val);
                    },
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
                      hintText: 'Optional',
                      fillColor: Colors.grey[50],
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.grey[50], width: 2.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blueGrey[300])),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  RaisedButton(
                    color: Colors.blueGrey[600],
                    child: Text(
                      "Submit",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      //adding date and time
                      //
                      DateTime date = DateTime.now();
                      setState(() => loading = true);
                      await DatabaseService()
                          .updateImd(area, equipment, activity, optional, date);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Tabs()));
                    },
                  ),
                ]),
              ),
            ));
  }
}
