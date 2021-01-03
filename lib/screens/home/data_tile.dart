import 'package:flutter/material.dart';
import 'package:imd/models/imd.dart';

class DataTile extends StatelessWidget {
  final Imd data;
  DataTile({this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
      child: Card(
          margin: EdgeInsets.fromLTRB(20.0, 10, 20.0, 10),
          child: Column(
            children: [
              ListTile(
                title: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Text(data.activity),
                ),
                subtitle:
                    Text("Equipment: ${data.equipment}\nUnit: ${data.area}"),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: data.optional != ''
                      ? Padding(
                          padding: const EdgeInsets.fromLTRB(16.0, 10, 12, 10),
                          child: Text('Description: ${data.optional}',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.6))),
                        )
                      : null,
                ),
              ),
            ],
          )),
    );
  }
}
