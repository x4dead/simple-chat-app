import 'dart:convert';

class ChatDto {
  final String? uid;
  final String? firstName;
  final String? lastName;
  final bool? isOnline;
  final DateTime? lastActive;
  final String? lastMessage;
  final DateTime? lastMessageDate;
  final String? messageReceiverId;

  ChatDto({
    this.uid,
    this.firstName,
    this.lastName,
    this.isOnline,
    this.lastActive,
    this.lastMessage,
    this.lastMessageDate,
    this.messageReceiverId,
  });

  ChatDto copyWith({
    String? uid,
    String? firstName,
    String? lastName,
    bool? isOnline,
    DateTime? lastActive,
    String? lastMessage,
    DateTime? lastMessageDate,
    String? messageReceiverId,
  }) =>
      ChatDto(
        uid: uid ?? this.uid,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        isOnline: isOnline ?? this.isOnline,
        lastActive: lastActive ?? this.lastActive,
        lastMessage: lastMessage ?? this.lastMessage,
        lastMessageDate: lastMessageDate ?? this.lastMessageDate,
        messageReceiverId: messageReceiverId ?? this.messageReceiverId,
      );

  factory ChatDto.fromJson(String str) => ChatDto.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ChatDto.fromMap(Map<String, dynamic> json) => ChatDto(
        uid: json["uid"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        isOnline: json["is_online"] ?? false,
        lastActive: json["last_active"] == null
            ? null
            : DateTime.parse(json["last_active"]),
        lastMessage: json["last_message"],
        lastMessageDate: json["last_message_date"] == null
            ? null
            : DateTime.parse(json["last_message_date"]),
        messageReceiverId: json["message_receiver_id"],
      );

  Map<String, dynamic> toMap() => {
        "uid": uid,
        "first_name": firstName,
        "last_name": lastName,
        "is_online": isOnline,
        "last_active": lastActive?.toIso8601String(),
        "last_message": lastMessage,
        "last_message_date": lastMessageDate?.toIso8601String(),
        "message_receiver_id": messageReceiverId,
      };
  Map<String, dynamic> toMapWithOutUid() => {
        // "uid": uid,
        "first_name": firstName,
        "last_name": lastName,
        "is_online": isOnline,
        "last_active": lastActive?.toIso8601String(),
        "last_message": lastMessage,
        "last_message_date": lastMessageDate?.toIso8601String(),
        "message_receiver_id": messageReceiverId,
      };
}
