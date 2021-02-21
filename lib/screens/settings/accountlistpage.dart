import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:imd/models/imd.dart';
import 'package:imd/screens/home/data_tile.dart';

class Accountlistpage extends StatefulWidget {
  @override
  _AccountlistpageState createState() => _AccountlistpageState();
}

class _AccountlistpageState extends State<Accountlistpage> {
  @override
  Widget build(BuildContext context) {
    final imd = Provider.of<List<Imd>>(context);
    return Scaffold(
      body: Center(
        child: imd == null
            ? Container(
                child: Text('No Records founds :(',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              )
            : ListView.builder(
                cacheExtent: 9999,
                itemCount: imd.length,
                itemBuilder: (context, index) {
                  return DataTile(data: imd[index]);
                },
              ),
      ),
    );
  }
}
