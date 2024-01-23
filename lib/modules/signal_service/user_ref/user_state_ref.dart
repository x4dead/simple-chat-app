import 'package:simple_chat_app/models/models.dart';

class UserStateRef {
  final List<UserDto>? users;

  const UserStateRef({
    this.users,
  });

  UserStateRef copyWith({
    List<UserDto>? users,
  }) {
    return UserStateRef(
      users: users ?? this.users,
    );
  }
}
