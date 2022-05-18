import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hm_service/model/client.dart';

class SplashRepository{
  Future<Client?> fetchCurrentClient(DocumentReference reference)async{
    try{
      var res =await reference.get();
      return Client.fromMap(res.data() as Map<String,dynamic>);
    }on FirebaseException catch(e){
      return null;
    }
  }
}