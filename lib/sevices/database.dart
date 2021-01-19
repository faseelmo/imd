/* services/firestore_service.dart */

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:imd/models/imd.dart';

class DatabaseService {
//collection reference

  final databaseReference = Firestore.instance;

  Future updateImd(String area, String group, String equipment, String activity,
      String optional, DateTime date, String url, String uemail) async {
    return await databaseReference.collection("imd").add({
      'area': area,
      'group': group,
      'equipment': equipment,
      'activity': activity,
      'optional': optional,
      'date': date,
      'url': url,
      'uemail': uemail,
    });
  }

  //imd data from snapshot
  List<Imd> _imdListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Imd(
        area: doc.data['area'] ?? '',
        group: doc.data['group'] ?? '',
        equipment: doc.data['equipment'] ?? '',
        activity: doc.data['activity'] ?? '',
        optional: doc.data['optional'] ?? '',
        url: doc.data['url'] ?? '',
        uemail: doc.data['uemail'] ?? '',
        //date: doc.data['date'],
      );
    }).toList();
  }
  // get imd stream

  Stream<List<Imd>> get imd {
    // orderBy is here

    return databaseReference
        .collection("imd")
        .orderBy('date', descending: true)
        .snapshots()
        .map(_imdListFromSnapshot);
  }
}
