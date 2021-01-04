import 'package:flutter/material.dart';

class Analytics extends StatelessWidget {
  static Route<dynamic> route() => MaterialPageRoute(
        builder: (context) => Analytics(),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Analytics"),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: Center(
        child: Text("Under Construction"),
      ),
    );
  }
}
