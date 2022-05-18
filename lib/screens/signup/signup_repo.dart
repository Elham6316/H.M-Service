import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hm_service/helper/flash_helper.dart';
import 'package:hm_service/model/client.dart';
import 'package:hm_service/model/service.dart';
import 'package:hm_service/model/technician.dart';
import 'package:hm_service/theme/app_colors.dart';
import 'package:hm_service/util/collections.dart';

class SignUpRepository {
  Future<Client?> createClient(Client client)async{
    try {
      var _authInstance = FirebaseAuth.instance;
      var credential = await _authInstance.createUserWithEmailAndPassword(
          email: client.email!, password: client.password!);

      FirebaseAuth.instance.currentUser!.reload();

      await FirebaseFirestore.instance.collection(Collections.clients).doc(credential.user!.uid)
          .set(client.toMap());
      return client;
    }on FirebaseException catch(e){
      FlashHelper.showTopFlash(e.message,bckColor: kRed,);
      return null;
    }
  }

  Future<Technician?> createTechnician(Technician technician)async{
    try {
      var _authInstance = FirebaseAuth.instance;
      var credential = await _authInstance.createUserWithEmailAndPassword(
          email: technician.email!, password: technician.password!);

      FirebaseAuth.instance.currentUser!.reload();

      await FirebaseFirestore.instance.collection(Collections.technician).doc(credential.user!.uid)
          .set(technician.toMap());
      return technician;
    }on FirebaseException catch(e){
      FlashHelper.showTopFlash(e.message,bckColor: kRed,);
      return null;
    }
  }
  Future<List<Service>> fetchService()async{
    try{
      var res = await FirebaseFirestore.instance.collection(Collections.services).orderBy('sortIndex').get();
      return res.docs.map((e) => Service.fromMap(e.data(),e.reference)).toList();
    }catch (e){
      return <Service>[];
    }
  }

  Future<Client?> fetchCurrentClient(DocumentReference reference)async{
    try{
      var res =await reference.get();
      return Client.fromMap(res.data() as Map<String,dynamic>);
    }on FirebaseException catch(e){
      return null;
    }
  }
}