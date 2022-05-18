import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:hm_service/helper/auth_helper.dart';
import 'package:hm_service/model/client.dart';
import 'package:hm_service/model/comment.dart';
import 'package:hm_service/model/technician.dart';
import 'package:hm_service/util/collections.dart';

class CommentRepository {
  Future<bool> isReviewBefore(DocumentReference techRef) async {
    try {
      var res = await techRef
          .collection(Collections.comments)
          .where('clientId', isEqualTo: Get.find<AuthHelper>().clientRef().id)
          .limit(1)
          .get();
      return res.docs.isNotEmpty;
    } on FirebaseException catch (e) {
      return false;
    }
  }

  Future<List<Comment>> fetchTechnicalRefComment(
      DocumentReference techRef) async {
    try {
      var res = await techRef
          .collection(Collections.comments)
          .orderBy('createdAt', descending: true)
          .get();
      var comments = res.docs.map((e) => Comment.fromMap(e.data())).toList();

      comments = await Future.wait(comments.map((e) async {
        var clientRef = await FirebaseFirestore.instance
            .collection(Collections.clients)
            .doc(e.clientId)
            .get();
        var client = Client.fromMap(clientRef.data() as Map<String, dynamic>);
        e.client = client;
        return e;
      }));
      return comments;
    } on FirebaseException catch (e) {
      return <Comment>[];
    }
  }

  Future<bool> sendReview(
    Technician tech,
    Comment comment,
  ) async {
    try {
      var rating = tech.avgRate!.toDouble() * tech.numRating!.toDouble();
      var totalRating = comment.rating!.toDouble() + rating.toDouble();
      var totalNumRating = tech.numRating!.toInt() + 1;
      var totalAvgRating = totalRating / totalNumRating;

      await tech.reference!
          .update({'avgRate': totalAvgRating, 'numRating': totalNumRating});

      var res = await tech.reference!
          .collection(Collections.comments).add(comment.toMap());
      return true;
    } on FirebaseException catch (e) {
      return false;
    }
  }
}
