import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:hm_service/helper/auth_helper.dart';
import 'package:hm_service/model/request.dart';
import 'package:hm_service/model/service.dart';
import 'package:hm_service/model/technician.dart';
import 'package:hm_service/util/collections.dart';

class MyRequestRepository {
  Future<List<RequestData>> fetchRequests() async {
    try {
      var res = await FirebaseFirestore.instance
          .collection(Collections.requests)
          .where('clientId', isEqualTo: Get.find<AuthHelper>().clientRef().id)
          .orderBy('createdAt', descending: true)
          .get();

      var requests =
          res.docs.map((e) => RequestData.fromMap(e.data(),e.reference)).toList();

      if (requests.isNotEmpty) {
        requests = await Future.wait(requests.map((e) async {
          var techRes = await FirebaseFirestore.instance
              .collection(Collections.technician)
              .doc(e.technicianId)
              .get();
          var technician =
              Technician.fromMap(techRes.data()!, techRes.reference);
          e.technician = technician;

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
    } catch (e) {
      return <RequestData>[];
    }
  }
}
