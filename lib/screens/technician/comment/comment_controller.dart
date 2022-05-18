import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hm_service/helper/auth_helper.dart';
import 'package:hm_service/helper/flash_helper.dart';
import 'package:hm_service/model/comment.dart';
import 'package:hm_service/model/comment_args.dart';
import 'package:hm_service/screens/technician/comment/comment_repository.dart';
import 'package:hm_service/screens/user/home/user_home_controller.dart';
import 'package:hm_service/theme/app_colors.dart';

class CommentController extends GetxController{
  ///repository ****************************
  CommentRepository repository = Get.find();

  ///Data ***********************
  CommentArgs args = Get.arguments;
  var sending = false.obs;
  var loading = false.obs;
  var comments = <Comment>[];
  var isCommentBefore = false.obs;
  var rating = 0.obs;
  TextEditingController review = TextEditingController();

  ///listener ******************
  onSendingReview(){
    if(rating.value == 0 || review.text.trim().isEmpty){
      FlashHelper.showTopFlash('choose_rate'.tr,bckColor: kRed);
      return;
    }
    _sendReview();
  }
  onRatingChange(int i){
    rating.value = i;
  }

  ///logic ******************
  _fetchComments()async{
    loading.value = true;
    comments = await repository.fetchTechnicalRefComment(args.technician.reference!);
    update();
    loading.value = false;
  }

  _checkAndFetch()async{
    isCommentBefore.value = await repository.isReviewBefore(args.technician.reference!);
  }

  _sendReview()async{
    sending.value = true;
    var _comment = Comment(
        rating: rating.value,
        text: review.text,
        clientId: Get.find<AuthHelper>().clientRef().id,
      createdAt: Timestamp.now(),
      client: Get.find<UserHomeController>().client
    );
    var res = await repository.sendReview(args.technician, _comment);
    if(res){
      comments.insert(comments.length, _comment);
      isCommentBefore.value = true;
      update();
    }
    sending.value = false;
  }

  @override
  void onInit() {
    _checkAndFetch();
    _fetchComments();
  }
}