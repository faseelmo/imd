import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:imd/screens/bottom%20tabs/tabspage.dart';
import 'package:imd/sevices/database.dart';
import 'package:imd/shared/loading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:path/path.dart' as Path;
import 'package:dropdown_search/dropdown_search.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DataPage extends StatefulWidget {
  @override
  _DataPageState createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {
  bool loading = false;

  String area = '';
  String group = '';
  String equipment = '';
  String activity = '';
  String optional = '';
  String url = '';
  String uemail = '';

  String uploadedFileURL = '';

  File _image;
  final picker = ImagePicker();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future getCurrentUser() async {
    final FirebaseUser user = await _auth.currentUser();
    //final uid = user.uid;
    // Similarly we can get email as well

    setState(() {
      uemail = user.email;
    });

    //print(uemail);
  }

  Future getImage() async {
    final pickedFile =
        await picker.getImage(source: ImageSource.gallery, imageQuality: 20);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        print(
            'LOOK HERE LOL \n IMAGE SELECTED LLOL  \n \n \n \n FASEEL LOOK HERE.');
      } else {
        print(
            'LOOK HERE LOL \n No image selected \n \n \n \n FASEEL LOOK HERE.');
      }
    });
  }

  Future uploadFile() async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('imageData/${Path.basename(_image.path)}');
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.onComplete;

    String fileURL = await storageReference.getDownloadURL();
    setState(() {
      uploadedFileURL = fileURL;
    });
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
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
                  //
                  // Image Picker
                  RaisedButton(
                      child: Text('Choose Image'),
                      onPressed: () async {
                        await getImage();
                      }),

                  //
                  //

                  Container(
                    child: _image != null
                        ? Text('Image Selected')
                        : Text('No Image Selected'),
                  ),

                  Container(
                    child: Text(uemail),
                  ),

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
                          borderSide: BorderSide(color: Colors.blueGrey[300])),
                    ),
                    items: <String>[
                      'Unit 10',
                      'Unit 20',
                      'Unit 30',
                      'Unit 40',
                      'Unit 50',
                      'BOP',
                      'CHP',
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
                          borderSide: BorderSide(color: Colors.blueGrey[300])),
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
                          borderSide: BorderSide(color: Colors.blueGrey[300])),
                    ),
                    mode: Mode.MENU,
                    showSelectedItem: true,
                    items: [
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
                  SizedBox(height: 10.0),
                  TextFormField(
                    onChanged: (val) {
                      setState(() => optional = val);
                    },
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
                      labelText: 'Description',
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
                      setState(() => loading = true);

                      if (_image != null) {
                        await uploadFile();
                        url = uploadedFileURL;
                      }

                      print("First");

                      DateTime date = DateTime.now();
                      await getCurrentUser();

                      print('Uemail is ');
                      print(uemail);
                      await DatabaseService().updateImd(area, group, equipment,
                          activity, optional, date, url, uemail);

                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Tabs()));
                    },
                  ),
                ]),
              ),
            ));
  }
}
