import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_chat_app/models/src/chat_dto.dart';
import 'package:simple_chat_app/modules/signal_service/chat_ref/chat_state_ref.dart';

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

  Future createChat({
    String? mainUserId,
    ChatDto? receiverChat,
  }) async {
    try {
      List<String> chats = [];

      await _firebase
          .collection("users")
          .doc(mainUserId ?? UserPref.getUserUid)
          .collection('chat')
          .get()
          .then((event) async {
        if (event.docs.isNotEmpty) {
          for (var doc in event.docs) {
            chats.add(ChatDto.fromMap(doc.data()).uid!);
          }

          if (chats.contains(receiverChat?.uid ?? state.selectedChat?.uid) ==
              false) {
            await _createChatWithSelectedChat(mainUserId ?? UserPref.getUserUid,
                receiverChat ?? state.selectedChat!);
          }
        } else {
          await _createChatWithSelectedChat(mainUserId ?? UserPref.getUserUid,
              receiverChat ?? state.selectedChat!);
        }
      });
    } catch (e) {
      throw Exception();
    }
  }

  Future _createChatWithSelectedChat(
    String mainUserId,
    ChatDto receiverChat,
  ) async =>
      await _firebase
          .collection('users')
          .doc(mainUserId)
          .collection('chat')
          .doc(receiverChat.uid)
          .set(receiverChat.toMap());

  Future<void> updateChatData(Map<String, dynamic> data,
      {required String updatedChatUid, String? mainUid}) async {
    try {
      await _firebase
          .collection('users')
          .doc(mainUid ?? UserPref.getUserUid)
          .collection('chat')
          .doc(updatedChatUid)
          .update(data);
    } catch (e) {
      throw Exception();
    }
  }
}
