import 'dart:convert';

class UserDto {
  final String? uid;
  final String? firstName;
  final String? lastName;
  final bool? isOnline;
  final DateTime? lastActive;
  final String? password;
  final String? email;
  // final String? lastMessage;
  // final DateTime? lastMessageDate;
  // final String? messageReceiverId;

  UserDto({
    this.uid,
    this.firstName,
    this.lastName,
    this.isOnline,
    this.lastActive,
    this.password,
    this.email,
    // this.lastMessage,
    // this.lastMessageDate,
    // this.messageReceiverId,
  });

  UserDto copyWith({
    String? uid,
    String? firstName,
    String? lastName,
    bool? isOnline,
    DateTime? lastActive,
    String? password,
    String? email,
    // String? lastMessage,
    // DateTime? lastMessageDate,
    // String? messageReceiverId,
  }) =>
      UserDto(
        uid: uid ?? this.uid,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        isOnline: isOnline ?? this.isOnline,
        lastActive: lastActive ?? this.lastActive,
        password: password ?? this.password,
        email: email ?? this.email,
        // lastMessage: lastMessage ?? this.lastMessage,
        // lastMessageDate: lastMessageDate ?? this.lastMessageDate,
        // messageReceiverId: messageReceiverId ?? this.messageReceiverId,
      );

  factory UserDto.fromJson(String str) => UserDto.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserDto.fromMap(Map<String, dynamic> json) => UserDto(
        uid: json["uid"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        isOnline: json[" is_online"],
        lastActive: json["last_active"] == null
            ? null
            : DateTime.parse(json["last_active"]),
        password: json[" password"],
        email: json["email"],
        // lastMessage: json["last_message"],
        // lastMessageDate: json["last_message_date"] == null
        //     ? null
        //     : DateTime.parse(json["last_message_date"]),
        // messageReceiverId: json["message_receiver_id"],
      );

  Map<String, dynamic> toMap() => {
        "uid": uid,
        "first_name": firstName,
        "last_name": lastName,
        "is_online": isOnline,
        "last_active": lastActive?.toIso8601String(),
        "password": password,
        "email": email,
        // "last_message": lastMessage,
        // "last_message_date": lastMessageDate?.toIso8601String(),
        // "message_receiver_id": messageReceiverId,
      };
}
