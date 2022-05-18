import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class Service{
  final String? icon;
  final Map? name;
  final DocumentReference? reference;

  Service({this.icon, this.name, this.reference});

  String get locale => name![Get.locale!.languageCode];


  factory Service.fromMap(Map<String, dynamic> map, DocumentReference reference) {
    return Service(
        icon: map['icon'] as String?,
      name: map['name'] as Map?,
      reference: reference

    );
  }
}