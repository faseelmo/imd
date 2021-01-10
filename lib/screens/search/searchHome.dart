import 'package:flutter/material.dart';
import 'package:imd/screens/search/SearchService.dart';
import 'package:provider/provider.dart';
import 'package:imd/models/imd.dart';
import 'searchListPage.dart';

class SearchHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Imd>>.value(
      value: SearchServices().imd,
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          title: Text(''),
          backgroundColor: Colors.grey[50],
          elevation: 0.0,
        ),
        body: SearchListPage(),
      ),
    );
  }
}
