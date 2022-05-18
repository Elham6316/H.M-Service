import 'package:get/get.dart';

class DropdownController extends GetxController{

  ///Data ********************************************
  String? selectedString;

  ///logic *******************************************
  onItemSelected(String value){
    selectedString = value;
    update();
  }
}