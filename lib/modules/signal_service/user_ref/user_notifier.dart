import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_chat_app/models/models.dart';

import 'package:simple_chat_app/modules/signal_service/user_ref/user_state_ref.dart';
import 'package:simple_chat_app/utils/user_pref.dart';

class UserNotifier extends StateNotifier<UserStateRef> {
  final firebase = FirebaseFirestore.instance;

  UserNotifier() : super(const UserStateRef());
  void setMainUser(UserDto user) {
    state = state.copyWith(mainUser: user);
  }

  Stream<List<UserDto>> getAllUsers() {
    List<UserDto> users = [];

    try {
      return firebase
          .collection('users')
          .orderBy('last_active', descending: true)
          .snapshots(includeMetadataChanges: true)
          .map((snapshot) {
        users =
            snapshot.docs.map((doc) => UserDto.fromMap(doc.data())).toList();
        state = state.copyWith(users: users);
        return users;
      });
    } catch (e) {
      throw 'Error';
    }
  }

  Future<void> updateUserData(Map<String, dynamic> data) async {
    await firebase.collection('users').doc(UserPref.getUserUid).update(data);
  }
}
