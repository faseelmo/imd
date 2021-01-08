import 'package:flutter/material.dart';

class NotAnalytics extends StatefulWidget {
  @override
  _NotAnalyticsState createState() => _NotAnalyticsState();
}

class _NotAnalyticsState extends State<NotAnalytics> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(''),
          backgroundColor: Colors.grey[50],
          elevation: 0.0,
        ),
        body: Container(
            child: Center(
          child: Text('Under Construction :)'),
        )));
  }
}
