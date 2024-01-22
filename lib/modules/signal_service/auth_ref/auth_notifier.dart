import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_chat_app/modules/signal_service/auth_ref/auth_state_ref.dart';
import 'package:simple_chat_app/utils/user_pref.dart';

class AuthNotifier extends StateNotifier<AuthStateRef> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
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
}
