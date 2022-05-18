import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hm_service/helper/flash_helper.dart';
import 'package:hm_service/model/client.dart';
import 'package:hm_service/theme/app_colors.dart';


class SignInRepository {
  Future<bool> signInWithEmailAndPassword({required String email, required String password})async{
    try{
      var _authInstance = FirebaseAuth.instance;
      await _authInstance.signInWithEmailAndPassword(email: email, password: password);
      await _authInstance.currentUser!.reload();
      return true;
    }on FirebaseException catch(e){
      FlashHelper.showTopFlash(e.message,bckColor: kRed,);
      return false;
    }
  }


  Future<bool> resetPassword({required String email})async{
    try{
      var _authInstance = FirebaseAuth.instance;
      await _authInstance.sendPasswordResetEmail(email: email);
      return true;
    }on FirebaseException catch(e){
      FlashHelper.showTopFlash(e.message,bckColor: kRed,);
      return false;
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