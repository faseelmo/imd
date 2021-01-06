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
          margin: EdgeInsets.fromLTRB(20.0, 0, 20.0, 5),
          child: Column(
            children: [
              ListTile(
                title: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Text(data.activity),
                ),
                subtitle: Text(
                    "Equipment: ${data.equipment}\nArea: ${data.area} \nGroup: ${data.group}"),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: data.optional != ''
                      ? Padding(
                          padding: const EdgeInsets.fromLTRB(16.0, 4, 12, 5),
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
