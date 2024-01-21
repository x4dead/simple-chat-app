import 'package:simple_chat_app/models/src/message_dto.dart';

class MessageStateRef {
  final List<MessageDto>? messages;
  // final int? chatId;
  // final int? localChatId;

  const MessageStateRef({
    this.messages,
    //  this.chatId, this.localChatId
  });

  MessageStateRef copyWith({List<MessageDto>? messages}) {
    return MessageStateRef(
      messages: messages ?? this.messages,
      // chatId: chatId ?? this.chatId,
    );
  }

  @override
  List<Object?> get props => [
        messages,
        //  chatId, localChatId
      ];
}
