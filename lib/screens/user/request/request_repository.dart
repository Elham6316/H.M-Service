import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hm_service/model/request.dart';
import 'package:hm_service/model/technician.dart';
import 'package:hm_service/util/collections.dart';

class RequestRepository {
  Future<List<Technician>> fetchTechnician(String serviceId) async {
    try {
      var res = await FirebaseFirestore.instance
          .collection(Collections.technician)
          .where('serviceId', isEqualTo: serviceId)
          .get();
      return res.docs
          .map((e) => Technician.fromMap(e.data(), e.reference))
          .toList();
    } catch (e) {
      return <Technician>[];
    }
  }

  Future<bool> sendRequest(RequestData request) async {
    try {
       await FirebaseFirestore.instance
          .collection(Collections.requests).add(request.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }
}
