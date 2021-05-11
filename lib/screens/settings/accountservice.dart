/* services/firestore_service.dart */

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:imd/models/imd.dart';
import 'package:imd/global.dart' as global;

class AccountServices {
  final collectionReference = Firestore.instance;

  Future deletePost(id) async {
    return await collectionReference.document(id).delete();
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
          docId: doc.data['docId'] ?? '',
          date: doc.data['date'] ?? '');
    }).toList();
  }

  Stream<List<Imd>> get imd {
    // orderBy is here
    return collectionReference
        .collection("imd") // I need the variable from the dropdown menu
        .where('uemail', isEqualTo: global.uemail)
        .orderBy('osdate', descending: true)
        .snapshots()
        .map(_imdListFromSnapshot);
  }
}
