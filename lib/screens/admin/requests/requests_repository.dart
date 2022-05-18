import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hm_service/model/client.dart';
import 'package:hm_service/model/request.dart';
import 'package:hm_service/model/service.dart';
import 'package:hm_service/model/technician.dart';
import 'package:hm_service/util/collections.dart';

class RequestsRepositoryList {
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

  Future<List<RequestData>> fetchRequests() async {
    try {
      var res = await FirebaseFirestore.instance
          .collection(Collections.requests)
          .orderBy('createdAt', descending: true)
          .get();
      var requests = res.docs
          .map((e) => RequestData.fromMap(e.data(), e.reference))
          .toList();

      if (requests.isNotEmpty) {
        requests = await Future.wait(requests.map((e) async {
          var clientRef = await FirebaseFirestore.instance
              .collection(Collections.clients)
              .doc(e.clientId)
              .get();
          var client = Client.fromMap(clientRef.data()!);
          e.client = client;

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
    } on FirebaseException catch (e) {
      return <RequestData>[];
    }
  }
}
