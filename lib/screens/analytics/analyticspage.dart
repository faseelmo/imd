import 'package:flutter/material.dart';

class Analytics extends StatelessWidget {
  static Route<dynamic> route() => MaterialPageRoute(
        builder: (context) => Analytics(),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search"),
      ),
      body: Center(
        child: Text("Hello, Search!"),
      ),
    );
  }
}
