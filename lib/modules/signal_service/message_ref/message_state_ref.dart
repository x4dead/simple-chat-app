import 'package:simple_chat_app/models/src/message_dto.dart';

class MessageStateRef {
  final List<MessageDto>? messages;
  const MessageStateRef({
    this.messages,
  });

  MessageStateRef copyWith({List<MessageDto>? messages}) {
    return MessageStateRef(
      messages: messages ?? this.messages,
    );
  }
}
