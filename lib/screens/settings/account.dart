import 'package:flutter/material.dart';

import 'package:imd/screens/settings/accountlistpage.dart';
import 'package:imd/screens/settings/accountservice.dart';
import 'package:imd/screens/settings/myprofile.dart';
import 'package:imd/sevices/auth.dart';
import 'package:imd/models/imd.dart';

import 'package:provider/provider.dart';

class Account extends StatefulWidget {
  final Imd data;
  Account({this.data});

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Imd>>.value(
        initialData: null,
        value: AccountServices().imd,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'You',
              style: TextStyle(color: Colors.grey[900]),
            ),
            backgroundColor: Colors.grey[50],
            elevation: 0.0,
          ),
          body: Accountlistpage(),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.indigo[900],
            foregroundColor: Colors.black,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Myprofile()));
              // Respond to button press
            },
            child: Icon(Icons.settings_outlined, color: Colors.white),
          ),
        ));
  }
}

/*child: FlatButton.icon(
              onPressed: () async {
                await _auth.signOut();
              },
              icon: Icon(Icons.person),
              label: Text('logout')), */
