/* services/firestore_service.dart */

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:imd/models/imd.dart';

class DatabaseService {
//collection reference

  final databaseReference = Firestore.instance;

  Future updateImd(String area, String equipment, String activity,
      String optional, DateTime date) async {
    return await databaseReference.collection("imd").add({
      'area': area,
      'equipment': equipment,
      'activity': activity,
      'optional': optional,
      'date': date,
    });
  }

  //imd data from snapshot
  List<Imd> _imdListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Imd(
        area: doc.data['area'] ?? '0',
        equipment: doc.data['equipment'] ?? '',
        activity: doc.data['activity'] ?? '',
        optional: doc.data['optional'] ?? '',
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
