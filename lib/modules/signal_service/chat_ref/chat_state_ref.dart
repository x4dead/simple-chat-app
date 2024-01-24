import 'package:simple_chat_app/models/src/chat_dto.dart';

class ChatStateRef {
  final List<ChatDto>? chats;
  final ChatDto? selectedChat;

  const ChatStateRef({this.chats, this.selectedChat});

  ChatStateRef copyWith({
    ChatDto? selectedChat,
    List<ChatDto>? chats,
  }) {
    return ChatStateRef(
      selectedChat: selectedChat ?? this.selectedChat,
      chats: chats ?? this.chats,
    );
  }
}
