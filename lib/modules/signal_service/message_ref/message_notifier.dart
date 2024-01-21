import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_chat_app/models/src/message_dto.dart';
import 'package:simple_chat_app/modules/signal_service/message_ref/message_state_ref.dart';
import 'package:simple_chat_app/utils/user_pref.dart';

class MessageNotifier extends StateNotifier<MessageStateRef> {
  MessageNotifier() : super(const MessageStateRef());
  Future sendMessage(
      {required String content, required String receiverId}) async {
    final localMessage = MessageDto(
      content: content,
      receiverId: receiverId,
      senderId: UserPref.getUserUid,
      sentTime: DateTime.now(),
    );
    await FirebaseFirestore.instance
        .collection('users')
        .doc(UserPref.getUserUid)
        .collection('chat')
        .doc(receiverId)
        .collection('messages')
        .add(localMessage.toMap());
  }
}
