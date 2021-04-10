import 'package:flutter/material.dart';
import 'package:imd/screens/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:imd/sevices/auth.dart';
import 'package:imd/models/user.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      initialData: null,
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
        theme: ThemeData(
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              primary: Colors.blueGrey[900],
            ),
          ),
        ),
      ),
    );
  }
}
