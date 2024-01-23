import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_chat_app/models/models.dart';

import 'package:simple_chat_app/modules/signal_service/user_ref/user_state_ref.dart';
import 'package:simple_chat_app/utils/user_pref.dart';

class UserNotifier extends StateNotifier<UserStateRef> {
  final _firebase = FirebaseFirestore.instance;

  UserNotifier() : super(const UserStateRef());

  Stream<List<UserDto>> getAllUsers() {
    List<UserDto> users = [];

    try {
      return _firebase
          .collection('users')
          .orderBy('last_active', descending: true)
          .snapshots(includeMetadataChanges: true)
          .map((snapshot) {
        users =
            snapshot.docs.map((doc) => UserDto.fromMap(doc.data())).toList();
        users.removeWhere((e) => e.uid == UserPref.getUserUid);
        state = state.copyWith(users: users);
        return users;
      });
    } catch (e) {
      throw 'Error';
    }
  }

  Future<void> updateUserData(Map<String, dynamic> data) async {
    try {
       await _firebase.collection('users').doc(UserPref.getUserUid).update(data);
    } catch (e) {
      throw Exception();
    }
   
  }
}
