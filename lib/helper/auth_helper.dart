import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:hm_service/navigation/app_routes.dart';
import 'package:hm_service/util/collections.dart';
import '../main.dart';

class AuthHelper {
  bool isLoggedIn() => FirebaseAuth.instance.currentUser != null;
  User? get user => FirebaseAuth.instance.currentUser;

  //fire-store clients reference
  DocumentReference clientRef() {
    return FirebaseFirestore.instance
        .collection(Collections.clients)
        .doc(user!.uid);

  }

  DocumentReference techRef() {
    return FirebaseFirestore.instance
        .collection(Collections.technician)
        .doc(user!.uid);

  }

  ///Logout
  Future<Void?> logout() async {
    await pref.clear();
    await FirebaseAuth.instance.signOut();
    Get.offAllNamed(Routes.welcome);
    return Future.value();
  }
}
