import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_chat_app/models/models.dart';

import 'package:simple_chat_app/modules/signal_service/user_ref/user_state_ref.dart';

class UserNotifier extends StateNotifier<UserStateRef> {
  final firebase = FirebaseFirestore.instance;

  UserNotifier() : super(const UserStateRef());
  setMainUser(UserDto user) {
    state.copyWith(mainUser: user);
  }

  Stream<List<UserDto>> getAllUsers() {
    List<UserDto> users = [];
    // await firebase.collection('users').doc("4234324325DS423dsdSAdsafewra46dSD464d6sawqe216S6").set(UserDto(
    //         email: "Test@mail.ru",
    //         firstName: 'Коля',
    //         isOnline: false,
    //         lastActive: DateTime(2022),
    //         lastName: "Иванов",
    //         password: "123456",
    //         uid: "4234324325DS423dsdSAdsafewra46dSD464d6sawqe216S6")
    // .toMap());
    try {
      return firebase
          .collection('users')
          .orderBy('last_active', descending: true)
          .snapshots(includeMetadataChanges: true)
          .map((snapshot) {
        users =
            snapshot.docs.map((doc) => UserDto.fromMap(doc.data())).toList();
        state.copyWith(users: users);
        return users;
      });
    } catch (e) {
      throw 'Error';
    }
  }
}
