import 'dart:convert';

class MessageDto {
  final String? senderId;
  final String? receiverId;
  final String? content;
  final DateTime? sentTime;

  MessageDto({
    this.senderId,
    this.receiverId,
    this.content,
    this.sentTime,
  });

  MessageDto copyWith({
    String? senderId,
    String? receiverId,
    String? content,
    DateTime? sentTime,
  }) =>
      MessageDto(
        senderId: senderId ?? this.senderId,
        receiverId: receiverId ?? this.receiverId,
        content: content ?? this.content,
        sentTime: sentTime ?? this.sentTime,
      );

  factory MessageDto.fromJson(String str) =>
      MessageDto.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MessageDto.fromMap(Map<String, dynamic> json) => MessageDto(
        senderId: json["sender_id"],
        receiverId: json["receiver_id"],
        content: json["content"],
        sentTime: json["sent_time"] == null
            ? null
            : DateTime.parse(json["sent_time"]),
      );

  Map<String, dynamic> toMap() => {
        "sender_id": senderId,
        "receiver_id": receiverId,
        "content": content,
        "sent_time": sentTime?.toIso8601String(),
      };
}
