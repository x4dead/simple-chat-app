import 'package:simple_chat_app/models/models.dart';


class UserStateRef  {
  final List<UserDto>? users;
  final UserDto? mainUser;
  // final bool? userDb;
  // final bool? isDeleted;
  const UserStateRef({this.users,
  //  this.userDb, 
  // this.isDeleted, 
  this.mainUser});

  UserStateRef copyWith({
    List<UserDto>? users,
    UserDto? mainUser,
    // bool? userDb,
    // bool? isDeleted,
  }) {
    return UserStateRef(
      users: users ?? this.users,
      mainUser: mainUser ?? this.mainUser,
      // userDb: userDb ?? this.userDb,
      // isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  // bool get userDbthis => UserPref.getUserDbPref;

  // @override
  // List<Object?> get props => [users, mainUser, userDb, isDeleted];
}
