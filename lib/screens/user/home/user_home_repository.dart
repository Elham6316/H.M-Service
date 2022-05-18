import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:hm_service/helper/auth_helper.dart';
import 'package:hm_service/model/client.dart';
import 'package:hm_service/model/service.dart';
import 'package:hm_service/util/collections.dart';

class UserHomeRepository {
  Future<List<Service>> fetchService()async{
    try{
      var res = await FirebaseFirestore.instance.collection(Collections.services).orderBy('sortIndex').get();
      return res.docs.map((e) => Service.fromMap(e.data(),e.reference)).toList();
    }catch (e){
      return <Service>[];
    }
  }

  Future<Client?> fetchCurrentClient()async{
    try{
      var res =await Get.find<AuthHelper>().clientRef().get();
      return Client.fromMap(res.data() as Map<String,dynamic>);
    }on FirebaseException catch(e){
      return null;
    }
  }
}