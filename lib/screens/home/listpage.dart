import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:imd/models/imd.dart';
import 'package:imd/screens/home/data_tile.dart';

class DataList extends StatefulWidget {
  @override
  _DataListState createState() => _DataListState();
}

class _DataListState extends State<DataList> {
  @override
  Widget build(BuildContext context) {
    final imd = Provider.of<List<Imd>>(context);
    //print(imd.documents);

    return ListView.builder(
      itemCount: imd.length,
      itemBuilder: (context, index) {
        return DataTile(data: imd[index]);
      },
    );
  }
}
