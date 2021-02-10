/* services/firestore_service.dart */

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:imd/models/imd.dart';

class DatabaseService {
  //collection reference

  final collectionReference = Firestore.instance.collection('imd');

  Future updateImd(String area, String group, String equipment, String activity,
      String optional, DateTime date, String url, String uemail) async {
    final databaseReference = collectionReference.document();
    return await databaseReference.setData({
      'area': area,
      'group': group,
      'equipment': equipment,
      'activity': activity,
      'optional': optional,
      'date': date,
      'url': url,
      'uemail': uemail,
      'docId': databaseReference.documentID

      /* 'docId': document Id here*/
    });
  }

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
      );
    }).toList();
  }

  Stream<List<Imd>> get imd {
    return collectionReference
        .orderBy('date', descending: true)
        .snapshots()
        .map(_imdListFromSnapshot);
  }
}
