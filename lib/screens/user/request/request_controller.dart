import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hm_service/helper/flash_helper.dart';
import 'package:hm_service/model/request.dart';
import 'package:hm_service/model/service.dart';
import 'package:hm_service/model/technician.dart';
import 'package:hm_service/screens/user/request/request_repository.dart';
import 'package:hm_service/theme/app_colors.dart';
import 'package:intl/intl.dart';

class RequestController extends GetxController {
  RequestRepository repository = Get.find();

  @override
  void onInit() {
    date.text = dateFormat(DateTime.now());
    _fetchTechnician();
  }

  ///Data ******************************************
  TextEditingController problem = TextEditingController();
  TextEditingController date = TextEditingController();
  DateTime selectedDate = DateTime.now();
  Service service = Get.arguments;
  var technicians = <Technician>[];
  Technician? selectTech;
  var loadTech = false.obs;
  var loading = false.obs;
  final formKey = GlobalKey<FormState>();

  ///listener *************************************
  onShowDate() async {
    DateTime? picked = await showDatePicker(
        context: Get.context!,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(DateTime.now().year + 100),
        builder: (BuildContext? context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: kPrimary,
              colorScheme: const ColorScheme.light(primary: kPrimary),
              buttonTheme:
                  const ButtonThemeData(textTheme: ButtonTextTheme.primary),
            ),
            child: child!,
          );
        });

    if (picked != null) {
      var time = await showTimePicker(
          context: Get.context!,
          initialTime: TimeOfDay.now(),
          builder: (BuildContext? context, Widget? child) {
            return Theme(
              data: ThemeData.light().copyWith(
                primaryColor: kPrimary,
                colorScheme: const ColorScheme.light(primary: kPrimary),
                buttonTheme:
                    const ButtonThemeData(textTheme: ButtonTextTheme.primary),
              ),
              child: child!,
            );
          });
      if (time != null) {
        selectedDate = DateTime(
            picked.year, picked.month, picked.day, time.hour, time.minute);
        dateFormat(selectedDate);
        date.text = dateFormat(selectedDate);
      }
    }
  }

  onTechSelect(Technician technician) {
    selectTech = technician;
    update();
  }

  onSendRequest() {
    if(formKey.currentState!.validate()) {
      _sendRequest();
    }
  }

  ///logic *****************************************
  String? validateString(String? value) {
    if (value!.isEmpty) return '${'enter'.tr} ${'what_problem'.tr}';
    return null;
  }

  Timestamp convertToTimestamp(DateTime time) {
    return Timestamp.fromMillisecondsSinceEpoch(time.millisecondsSinceEpoch);
  }

  String dateFormat(DateTime date) {
    return DateFormat('EEE  MMM, dd yyyy').add_jm().format(date);
  }

  _fetchTechnician() async {
    loadTech.value = true;
    technicians = await repository.fetchTechnician(service.reference!.id);
    if (technicians.isNotEmpty) {
      selectTech = technicians.first;
      update();
    }
    loadTech.value = false;
  }

  _sendRequest() async {
    loading.value = true;
    var isSending = await repository.sendRequest(RequestData(
        serviceId: service.reference!.id,
        technicianId: selectTech!.reference!.id,
        description: problem.text,
        time: convertToTimestamp(selectedDate)));
    loading.value = false;

    if(isSending){
      FlashHelper.showTopFlash('request_send'.tr,bckColor: kGreen);
      Get.back();
    }
  }
}
