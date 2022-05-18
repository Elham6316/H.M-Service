import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hm_service/model/chat.dart';
import 'package:hm_service/model/message.dart';
import 'package:hm_service/util/collections.dart';

class ChatRepository {
  Future<bool> checkIfRoomExist(Chat chat) async {
    try {
      var docRef = await FirebaseFirestore.instance
          .collection(Collections.chat)
          .doc(chat.roomId)
          .get();
      if (!docRef.exists) {
        await FirebaseFirestore.instance
            .collection(Collections.chat)
            .doc(chat.roomId)
            .set(chat.toMap());
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> sendMessage(Chat chat, Message message) async {
    try {
      await FirebaseFirestore.instance
          .collection(Collections.chat)
          .doc(chat.roomId)
          .collection(Collections.message)
          .add(message.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  Stream<List<Message>> listenToMessages(Chat chat) async* {
    try {
      yield* FirebaseFirestore.instance
          .collection(Collections.chat)
          .doc(chat.roomId)
          .collection(Collections.message)
          .orderBy('createdAt', descending: true)
          .snapshots()
          .asyncMap((data) {
            return data.docs.map((e) => Message.fromMap(e.data())).toList();
      });
    } catch (e) {
      yield <Message>[];
    }
  }
}
