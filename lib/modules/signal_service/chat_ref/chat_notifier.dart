import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_chat_app/models/models.dart';
import 'package:simple_chat_app/models/src/chat_dto.dart';
import 'package:simple_chat_app/modules/signal_service/chat_ref/chat_state_ref.dart';

import 'package:simple_chat_app/modules/signal_service/user_ref/user_state_ref.dart';
import 'package:simple_chat_app/utils/user_pref.dart';

class ChatNotifier extends StateNotifier<ChatStateRef> {
  final _firebase = FirebaseFirestore.instance;

  ChatNotifier() : super(const ChatStateRef());
  void setSelectedChat(ChatDto chat) {
    state = state.copyWith(selectedChat: chat);
  }

  Stream<List<ChatDto>> getAllChats() {
    List<ChatDto> chats = [];

    try {
      return _firebase
          .collection('users')
          .doc(UserPref.getUserUid)
          .collection('chat')
          .orderBy('last_active', descending: true)
          .snapshots(includeMetadataChanges: true)
          .map((snapshot) {
        chats =
            snapshot.docs.map((doc) => ChatDto.fromMap(doc.data())).toList();
        state = state.copyWith(chats: chats);
        return chats;
      });
    } catch (e) {
      throw 'Error';
    }
  }

  Future createChat() async {
    try {
      List<String> chats = [];

      await _firebase
          .collection("users")
          .doc(UserPref.getUserUid)
          .collection('chat')
          .get()
          .then((event) async {
        if (event.docs.isNotEmpty) {
          for (var doc in event.docs) {
            chats.add(ChatDto.fromMap(doc.data()).uid!);
          }

          if (chats.contains(state.selectedChat?.uid) == false) {
            await _firebase
                .collection('users')
                .doc(UserPref.getUserUid)
                .collection('chat')
                .doc(state.selectedChat?.uid)
                .set(state.selectedChat!.toMap());
          }
        } else {
          await _firebase
              .collection('users')
              .doc(UserPref.getUserUid)
              .collection('chat')
              .doc(state.selectedChat?.uid)
              .set(state.selectedChat!.toMap());
        }
      });
    } catch (e) {
      throw Exception();
    }
  }

  Future<void> updateChatData(Map<String, dynamic> data,
      {required String uid}) async {
    try {
      await _firebase
          .collection('users')
          .doc(UserPref.getUserUid)
          .collection('chat')
          .doc(uid)
          .update(data);
    } catch (e) {
      throw Exception();
    }
  }
}
