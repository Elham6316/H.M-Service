import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hm_service/helper/auth_helper.dart';
import 'package:hm_service/model/client.dart';
import 'package:hm_service/model/service.dart';
import 'package:hm_service/model/technician.dart';
import 'package:hm_service/theme/app_colors.dart';
import 'package:intl/intl.dart';

class RequestData {
  final String? serviceId, technicianId, description, clientId;
  final Timestamp? time;
  final DocumentReference? ref;
  String? status;
  Technician? technician;
  Client? client;
  Service? service;

  bool get isPending => status == 'pending';

  bool get isReceived => status == 'received';

  bool get isWorking => status == 'working';

  bool get isComplete => status == 'complete';

  String get strTime => _dateFormat(time!.toDate());

  String get requestIncoming => isPending
      ? 'received'
      : isReceived
          ? 'working'
          : 'complete';

  Color get color => isPending
      ? kYellow
      : isReceived
          ? kRed
          : isWorking
              ? kPrimary
              : kGreen;

  Color get colorIncoming => requestIncoming == 'received'
      ? kRed
      : requestIncoming == 'working'
          ? kPrimary
          : kGreen;

  RequestData(
      {this.serviceId,
      this.technicianId,
      this.description,
      this.time,
      this.status,
      this.ref,
      this.technician,
      this.clientId,
      this.service});

  Map<String, dynamic> toMap() {
    return {
      'serviceId': serviceId,
      'technicianId': technicianId,
      'description': description,
      'time': time,
      'clientId': Get.find<AuthHelper>().clientRef().id,
      'status': 'pending',
      'createdAt': FieldValue.serverTimestamp()
    };
  }

  factory RequestData.fromMap(
      Map<String, dynamic> map, DocumentReference reference) {
    return RequestData(
        serviceId: map['serviceId'] as String?,
        technicianId: map['technicianId'] as String?,
        description: map['description'] as String?,
        clientId: map['clientId'] as String?,
        time: map['time'] as Timestamp?,
        ref: reference,
        status: map['status'] as String?);
  }

  String _dateFormat(DateTime date) {
    return DateFormat('EEE  MMM, dd yyyy').add_jm().format(date);
  }
}
