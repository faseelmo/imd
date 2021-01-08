/* services/firestore_service.dart */

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:imd/models/imd.dart';
import 'package:imd/global.dart' as global;

class SearchServices {
  final Imd data;
  SearchServices({this.data});

  final databaseReference = Firestore.instance;

  Stream<List<Imd>> get imd {
    // orderBy is here

    List<Imd> _imdListFromSnapshot(QuerySnapshot snapshot) {
      return snapshot.documents.map((doc) {
        return Imd(
          area: doc.data['area'] ?? '',
          group: doc.data['group'] ?? '',
          equipment: doc.data['equipment'] ?? '',
          activity: doc.data['activity'] ?? '',
          optional: doc.data['optional'] ?? '',
        );
      }).toList();
    }

    if (global.area == '') {
      global.area = null;
    }
    if (global.group == '') {
      global.group = null;
    }
    if (global.activity == '') {
      global.activity = null;
    }

    if (global.area == 'All') {
      global.area = null;
    }
    if (global.group == 'All') {
      global.group = null;
    }
    if (global.activity == 'All') {
      global.activity = null;
    }

    return databaseReference
        .collection("imd") // I need the variable from the dropdown menu
        .where('area', isEqualTo: global.area)
        .where('group', isEqualTo: global.group)
        .where('activity', isEqualTo: global.activity)
        .orderBy('date', descending: true)
        .snapshots()
        .map(_imdListFromSnapshot);
  }
}
