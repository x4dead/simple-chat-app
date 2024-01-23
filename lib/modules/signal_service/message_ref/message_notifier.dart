import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_chat_app/models/src/message_dto.dart';
import 'package:simple_chat_app/modules/signal_service/message_ref/message_state_ref.dart';
import 'package:simple_chat_app/pages/chat_page/widgets/messages_list_widget.dart';
import 'package:simple_chat_app/utils/user_pref.dart';

class MessageNotifier extends StateNotifier<MessageStateRef> {
  final _firebase = FirebaseFirestore.instance;
  MessageNotifier() : super(const MessageStateRef());
  Future sendMessage(
      {required String content, required String receiverId}) async {
    final localMessage = MessageDto(
      content: content,
      receiverId: receiverId,
      senderId: UserPref.getUserUid,
      sentTime: DateTime.now(),
    );
    // if(){

    // }
    await _firebase
        .collection('users')
        .doc(UserPref.getUserUid)
        .collection('chat')
        .doc(receiverId)
        .collection('messages')
        .doc()
        .set(localMessage.toMap());

    await _firebase
        .collection('users')
        .doc(receiverId)
        .collection('chat')
        .doc(UserPref.getUserUid)
        .collection('messages')
        .doc()
        .set(localMessage.toMap());
  }

  Stream<List<MessageDto>> getMessages(String receiverId) {
    List<MessageDto> messages = [];

    return _firebase
        .collection('users')
        .doc(UserPref.getUserUid)
        .collection('chat')
        .doc(receiverId)
        .collection('messages')
        .orderBy('sent_time', descending: false)
        .snapshots(includeMetadataChanges: true)
        .map((doc) {
      messages = doc.docs.map((e) => MessageDto.fromMap(e.data())).toList();
      state = state.copyWith(messages: messages);
      scrollDown();
      return messages;
    });
  }

  scrollDown() => WidgetsBinding.instance.addPostFrameCallback((_) {
        if (scrollController.hasClients) {
          scrollController.jumpTo(scrollController.position.maxScrollExtent);
        }
      });
}
