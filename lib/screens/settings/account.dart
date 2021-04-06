import 'package:flutter/material.dart';

import 'package:imd/screens/settings/accountlistpage.dart';
import 'package:imd/screens/settings/accountservice.dart';
import 'package:imd/sevices/auth.dart';
import 'package:imd/models/imd.dart';
import 'package:imd/global.dart' as global;

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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 200,
                color: Colors.blueGrey[50],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                      child: CircleAvatar(
                        backgroundColor: Colors.blueGrey,
                        radius: 50,
                        child: Text(
                          global.uemail.substring(0, 2).toUpperCase(),
                          style: TextStyle(fontSize: 50, color: Colors.white),
                        ), //Text
                      ), //CirlceAvatar
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: TextButton.icon(
                          onPressed: () async {
                            await _auth.signOut();
                          },
                          icon: Icon(Icons.logout),
                          label: Text('logout')),
                    )
                  ],
                ),
              ),
              Container(
                height: 520,
                child: Scaffold(
                  body: Accountlistpage(),
                ),
              ),
            ],
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
