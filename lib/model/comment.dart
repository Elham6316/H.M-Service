import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:hm_service/helper/auth_helper.dart';
import 'package:hm_service/model/client.dart';
import 'package:intl/intl.dart';

class Comment{
  final String? text, clientId;
  final num? rating;
  final Timestamp? createdAt;
  Client? client;

  String get createdTime => _dateFormat(createdAt!.toDate());
  Comment({this.text, this.createdAt, this.clientId, this.client, this.rating});

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'rating': rating,
      'clientId': Get.find<AuthHelper>().clientRef().id,
      'createdAt': FieldValue.serverTimestamp()
    };
  }

  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
      text: map['text'] as String?,
      clientId: map['clientId'] as String?,
      rating: map['rating'] as num?,
      createdAt: map['createdAt'] as Timestamp?,
    );
  }

  String _dateFormat(DateTime date) {
    return DateFormat('EEE  MMM, dd yyyy').add_jm().format(date);
  }
}