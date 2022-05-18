import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hm_service/model/client.dart';
import 'package:hm_service/util/collections.dart';

class ClientsRepositoryList {

  Future<List<Client>> fetchClients() async {
    try {
      var res = await FirebaseFirestore.instance
          .collection(Collections.clients)
          .get();
      return res.docs.map((e) => Client.fromMap(e.data())).toList();
    } on FirebaseException catch (e) {
      return <Client>[];
    }
  }
}
