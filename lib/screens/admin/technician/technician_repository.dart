import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hm_service/model/technician.dart';
import 'package:hm_service/util/collections.dart';

class TechnicianRepositoryList {

  Future<List<Technician>> fetchTechnician() async {
    try {
      var res = await FirebaseFirestore.instance
          .collection(Collections.technician)
          .get();
      return res.docs.map((e) => Technician.fromMap(e.data(),e.reference)).toList();
    } on FirebaseException catch (e) {
      return <Technician>[];
    }
  }
}
