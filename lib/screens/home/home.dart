import 'package:flutter/material.dart';
import 'package:imd/screens/home/listpage.dart';
import 'package:imd/screens/data/datapage.dart';
import 'package:imd/sevices/database.dart';
import 'package:provider/provider.dart';
import 'package:imd/models/imd.dart';

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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => DataPage()));
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.blueGrey[300],
        ),
      ),
    );
  }
}
