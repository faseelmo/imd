import 'package:flutter/material.dart';
import 'analyticshome.dart';
import 'package:imd/global.dart' as global;

class Analytics extends StatefulWidget {
  @override
  _AnalyticsState createState() => _AnalyticsState();
}

class _AnalyticsState extends State<Analytics> {
  String area = '';
  String group = '';
  String equipment = '';
  String activity = '';
  String optional = '';

  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            'Search',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          elevation: 5.0,
          actions: <Widget>[],
        ),
        body: Column(
          children: [
            Form(
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
                      'Unit 10',
                      'Unit 20',
                      'Unit 30',
                      'Unit 40',
                      'Unit 50',
                      'CHP',
                      'BOP',
                    ].map((String value) {
                      return new DropdownMenuItem<String>(
                        value: value,
                        child: new Text(value),
                      );
                    }).toList(),
                    onChanged: (val) {
                      setState(() => area = val);
                      //print("haha" + area_search);
                    },
                  ),
                  SizedBox(height: 20.0),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      hintText: 'Group',
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
                      'Boiler',
                      'Feed Cycle',
                      'BOP',
                      'CHP',
                      'DCS/Turbine/IT',
                    ].map((String value) {
                      return new DropdownMenuItem<String>(
                        value: value,
                        child: new Text(value),
                      );
                    }).toList(),
                    onChanged: (val) {
                      setState(() => group = val);
                    },
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
                      'New Installation',
                      'Others'
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
                  SizedBox(height: 20.0),
                  RaisedButton(
                      color: Colors.blueGrey[600],
                      child: Text(
                        "Submit",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        global.area = area;
                        global.group = group;
                        global.activity = activity;

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AnalyticsHome()));
                      }
                      //adding date and time

                      ),
                ]),
              ),
            ),
          ],
        ));
  }
}
