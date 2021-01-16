import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'searchHome.dart';
import 'package:imd/global.dart' as global;
import 'package:intl/intl.dart';
import 'package:dropdown_search/dropdown_search.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String area = '';
  String group = '';
  String equipment = '';
  String activity = '';
  String optional = '';
  DateTime fromDate;
  DateTime toDate;
  String fromDateString = '';
  String toDateString = '';

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
        body: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                  child: Column(children: <Widget>[
                    ////
                    //// From
                    ///
                    Padding(
                        padding: const EdgeInsets.all(0),
                        child: Container(
                            child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                              RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(2.0)),
                                elevation: 0,
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
                                color: Colors.grey[50],
                              ),
                            ]))),

                    ///
                    ///
                    ///
                    ///
                    Padding(
                        padding: const EdgeInsets.all(0),
                        child: Container(
                            child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                              RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(2.0)),
                                elevation: 0,
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
                                color: Colors.grey[50],
                              ),
                            ]))),

                    ///
                    ///
                    ///
                    ///
                    ///

                    SizedBox(height: 20.0),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'Area',
                        labelStyle: TextStyle(
                          color: Colors.blueGrey[900],
                          //fontWeight: FontWeight.bold
                        ),
                        fillColor: Colors.grey[50],
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey[50], width: 2.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blueGrey[300])),
                      ),
                      items: <String>[
                        'All',
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
                    SizedBox(height: 10.0),
                    DropdownSearch<String>(
                      dropdownSearchDecoration: InputDecoration(
                        labelStyle: TextStyle(
                          color: Colors.blueGrey[900],
                          //fontWeight: FontWeight.bold
                        ),
                        fillColor: Colors.grey[50],
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey[50], width: 2.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blueGrey[300])),
                      ),
                      searchBoxDecoration: InputDecoration(
                        labelStyle: TextStyle(
                          color: Colors.blueGrey[900],
                          //fontWeight: FontWeight.bold
                        ),
                        fillColor: Colors.grey[50],
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey[50], width: 2.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blueGrey[300])),
                      ),
                      mode: Mode.MENU,
                      showSelectedItem: true,
                      items: [
                        'All',
                        'TSI',
                        'MSV',
                        'CV',
                        'ICV',
                        'RSV',
                        'Debris Filter',
                        'SCS',
                        'CWS',
                        'TWS',
                        'DEHC',
                        'PLC',
                        'LVS',
                        'OS ES',
                        'PI',
                        'Panel',
                        'FCP',
                        'DCS IO Card',
                        'Communication',
                        'Network',
                        'CCTV',
                        'BFP',
                        'CEP',
                        'HPBP',
                        'LPBP',
                        'Vaccum Pump',
                        'HPH',
                        'LPH',
                        'BMS',
                        'Fuel Control Station',
                        'Coal feeders',
                        'Mill Instruments',
                        'Water & Steam transmitters',
                        'SWAS',
                        'Metal Temperature',
                        'Burner Tilt',
                        'SH RH spray station',
                        'Soot Blowing System',
                        'ID',
                        'FD',
                        'PA',
                        'SADC',
                        'Air & Flue gas transmitter',
                        'Hydrojet/Water Cannon',
                        'AAQMS',
                        'CEMS',
                        'FOPH',
                        'FWPH/SWPH',
                        'ETP',
                        'RO',
                        'DM',
                        'CPU',
                        'ECP',
                        'Hydrogen',
                        'AHS',
                        'HVAC',
                        'FDAS',
                        'CAS',
                        'SCR/RCR',
                        'TTR',
                        'Belt Conveyor Instrumentation',
                        'BVS',
                        'Wireless System',
                        'FDAS',
                      ],
                      showSearchBox: true,
                      label: "Equipment",
                      hint: "Search",
                      onChanged: (val) {
                        setState(() => equipment = val);
                      },
                    ),
                    SizedBox(height: 20.0),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'Group',
                        labelStyle: TextStyle(
                          color: Colors.blueGrey[900],
                          //fontWeight: FontWeight.bold
                        ),
                        fillColor: Colors.grey[50],
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey[50], width: 2.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blueGrey[300])),
                      ),
                      items: <String>[
                        'All',
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
                        labelText: 'Activity',
                        labelStyle: TextStyle(
                          color: Colors.blueGrey[900],
                          //fontWeight: FontWeight.bold
                        ),
                        fillColor: Colors.grey[50],
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey[50], width: 2.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blueGrey[300])),
                      ),
                      items: <String>[
                        'All',
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
                          global.fromDate = fromDate;
                          global.toDate = toDate;
                          global.equipment = equipment;

                          //print();

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SearchHome()));
                        }
                        //adding date and time

                        ),
                  ]),
                ),
              ),
            ],
          ),
        ));
  }
}
