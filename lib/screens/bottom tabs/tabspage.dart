import 'package:flutter/material.dart';
import 'package:imd/screens/analytics/analyticspage.dart';
import 'package:imd/screens/home/home.dart';
import 'package:imd/screens/settings/account.dart';
import 'package:imd/sevices/database.dart';
import 'package:provider/provider.dart';
import 'package:imd/models/imd.dart';

class Tabs extends StatefulWidget {
  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  int _currentIndex = 0;
  final tabs = [
    Center(child: Home()),
    Center(child: Analytics()),
    Center(child: Account()),
  ];
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Imd>>.value(
      value: DatabaseService().imd,
      child: Scaffold(
        body: tabs[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          items: [
            (BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            )),
            (BottomNavigationBarItem(
              icon: Icon(Icons.analytics_outlined),
              label: 'Analytics',
            )),
            (BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined),
              label: 'Account',
            ))
          ],
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}
