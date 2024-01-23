import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_chat_app/models/models.dart';
import 'package:simple_chat_app/modules/signal_service/auth_ref/auth_state_ref.dart';
import 'package:simple_chat_app/utils/user_pref.dart';

class AuthNotifier extends StateNotifier<AuthStateRef> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final _firebase = FirebaseFirestore.instance;
  AuthNotifier() : super(AuthStateRef());

  Future<bool> login({required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      UserPref.setUserUid = _firebaseAuth.currentUser!.uid;
    } on FirebaseAuthException catch (e) {
      throw e.message ?? 'Error';
    }
    return false;
  }

  Future signUp({required UserDto user}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: user.email!, password: user.password!);
      _firebase
          .collection('users')
          .doc(_firebaseAuth.currentUser?.uid)
          .set(user.copyWith(uid: _firebaseAuth.currentUser?.uid).toMap());

      UserPref.setUserUid = _firebaseAuth.currentUser!.uid;
    } on FirebaseAuthException catch (e) {
      throw e.message ?? 'Error';
    }

  }

  Future signOut(BuildContext context) async {
    try {
      await _firebaseAuth.signOut();
      await UserPref.remove();
      if (mounted) {
        context.go('/');
      }
    } catch (e) {
      throw Exception();
    }
  }
}
