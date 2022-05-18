import 'package:get/get.dart';
import 'package:hm_service/screens/technician/comment/comment_controller.dart';
import 'package:hm_service/screens/technician/comment/comment_repository.dart';

class CommentBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(CommentRepository());
    Get.put(CommentController());
  }

}