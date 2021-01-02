import 'package:flutter/material.dart';
import 'package:imd/screens/home/listpage.dart';
import 'package:imd/sevices/auth.dart';
import 'package:imd/screens/data/datapage.dart';
import 'package:imd/sevices/database.dart';
import 'package:provider/provider.dart';
import 'package:imd/models/imd.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Imd>>.value(
      value: DatabaseService().imd,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(''),
          backgroundColor: Colors.white,
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
                onPressed: () async {
                  await _auth.signOut();
                },
                icon: Icon(Icons.person),
                label: Text('logout'))
          ],
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
