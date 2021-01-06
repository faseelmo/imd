import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:imd/models/imd.dart';
import 'package:imd/screens/home/data_tile.dart';

class AnalyticsListPage extends StatefulWidget {
  @override
  _AnalyticsListPageState createState() => _AnalyticsListPageState();
}

class _AnalyticsListPageState extends State<AnalyticsListPage> {
  @override
  Widget build(BuildContext context) {
    final imd = Provider.of<List<Imd>>(context);
    return Scaffold(
      body: Center(
        child: imd == null
            ? Container()
            : ListView.builder(
                itemCount: imd.length,
                itemBuilder: (context, index) {
                  return DataTile(data: imd[index]);
                },
              ),
      ),
    );
  }
}
