import 'package:flutter/material.dart';
import 'package:imd/screens/notanalytics/analyticsHome.dart';
import 'package:imd/screens/search/search.dart';
import 'package:imd/screens/home/listpage.dart';
import 'package:imd/screens/data/datapage.dart';
import 'package:imd/sevices/database.dart';
import 'package:provider/provider.dart';
import 'package:imd/models/imd.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Imd>>.value(
      value: DatabaseService().imd,
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          title: Text(''),
          backgroundColor: Colors.grey[50],
          elevation: 0.0,
        ),
        body: DataList(),
        floatingActionButton: SpeedDial(
          // both default to 16
          marginRight: 18,
          marginBottom: 20,
          animatedIcon: AnimatedIcons.menu_close,
          animatedIconTheme: IconThemeData(size: 22.0),
          // this is ignored if animatedIcon is non null
          // child: Icon(Icons.add),
          //visible: _dialVisible,
          // If true user is forced to close dial manually
          // by tapping main button and overlay is not rendered.
          closeManually: false,
          curve: Curves.easeOut,
          overlayColor: Colors.black,
          overlayOpacity: 0.5,
          //onOpen: () => print('OPENING DIAL'),
          //onClose: () => print('DIAL CLOSED'),
          tooltip: 'Speed Dial',
          heroTag: 'speed-dial-hero-tag',
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 8.0,
          shape: CircleBorder(),
          children: [
            SpeedDialChild(
              child: Icon(Icons.add),
              backgroundColor: Colors.greenAccent,
              label: 'Add Data',
              labelStyle: TextStyle(fontSize: 18.0),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => DataPage()));
              },
            ),
            SpeedDialChild(
              child: Icon(Icons.search),
              backgroundColor: Colors.blueAccent,
              label: 'Search Database',
              labelStyle: TextStyle(fontSize: 18.0),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Search()));
              },
            ),
            SpeedDialChild(
              child: Icon(Icons.analytics),
              backgroundColor: Colors.redAccent,
              label: 'Analytics',
              labelStyle: TextStyle(fontSize: 18.0),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => NotAnalytics()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
