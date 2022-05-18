import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String? from, message;
  Message({this.from, this.message});

  Map<String, dynamic> toMap() {
    return {
      'from': from,
      'message': message,
      'createdAt':FieldValue.serverTimestamp()
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      from: map['from'] as String,
      message: map['message'] as String,
    );
  }
}