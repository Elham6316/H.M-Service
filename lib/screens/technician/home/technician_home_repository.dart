import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:hm_service/helper/auth_helper.dart';
import 'package:hm_service/model/client.dart';
import 'package:hm_service/model/request.dart';
import 'package:hm_service/model/service.dart';
import 'package:hm_service/model/technician.dart';
import 'package:hm_service/util/collections.dart';

class TechnicianHomeRepository {
  Future<Technician?> fetchCurrentTechnician() async {
    try {
      var res = await Get.find<AuthHelper>().techRef().get();
      return Technician.fromMap(
          res.data() as Map<String, dynamic>, res.reference);
    } on FirebaseException catch (e) {
      return null;
    }
  }

  Future<bool> changeStatus(DocumentReference reference, String status) async {
    try {
     await reference.update({
       'status': status
     });
     return true;
    } on FirebaseException catch (e) {
      return false;
    }
  }

  Future<List<RequestData>> fetchMyRequests() async {
    try {
      var res = await FirebaseFirestore.instance
          .collection(Collections.requests)
          .where('technicianId',
              isEqualTo: Get.find<AuthHelper>().techRef().id).orderBy('createdAt',descending: true).get();
      var requests =
      res.docs.map((e) => RequestData.fromMap(e.data(),e.reference)).toList();

      if (requests.isNotEmpty) {
        requests = await Future.wait(requests.map((e) async {
          var clientRef = await FirebaseFirestore.instance
              .collection(Collections.clients)
              .doc(e.clientId)
              .get();
          var client =
          Client.fromMap(clientRef.data()!);
          e.client = client;

          var serviceRes = await FirebaseFirestore.instance
              .collection(Collections.services)
              .doc(e.serviceId)
              .get();
          var service =
          Service.fromMap(serviceRes.data()!, serviceRes.reference);
          e.service = service;

          return e;
        }));
      }

      return requests;
    } on FirebaseException catch (e) {
      return <RequestData>[];
    }
  }
}
