import 'package:flutter/material.dart';
import 'package:imd/models/imd.dart';

class DataTile extends StatelessWidget {
  final Imd data;
  DataTile({this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6, 20.0, 0),
        child: ListTile(
          title: Text(data.activity),
          subtitle: Text("Unit: ${data.area} Equipment: ${data.equipment}"),
        ),
      ),
    );
  }
}
