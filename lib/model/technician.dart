import 'package:cloud_firestore/cloud_firestore.dart';

class Technician {
  final String? email, password;
  final String? name,serviceId;
  final num? avgRate,numRating;
  final DocumentReference? reference;


  Technician({this.name, this.avgRate, this.reference, this.numRating,this.serviceId, this.email, this.password});

  Map<String, dynamic> toMap() {
    return {
      'email':email,
      'password':password,
      'name': name,
      'avgRate': 0,
      'numRating': 0,
      'serviceId': serviceId
    };
  }

  factory Technician.fromMap(Map<String, dynamic> map, DocumentReference reference) {
    return Technician(
      name: map['name'] as String,
      avgRate: map['avgRate'] as num,
      numRating: map['numRating'] as num,
      reference: reference
    );
  }
}

